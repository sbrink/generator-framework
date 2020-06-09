defmodule Platform.Core.Templates do
  alias Platform.Core.Generators
  alias Platform.Core.Templates.Template

  def list_for_generator(generator_id) do
    generator_id
    |> Generators.get!()
    |> Map.get(:templates)
    |> Enum.map(fn template ->
      Map.put(template, :generator_id, generator_id)
    end)
  end

  def get!(generator_id, id) do
    contents = File.read!("priv/templates/#{generator_id}/#{id}")

    generator_id
    |> list_for_generator()
    |> Enum.find(fn template ->
      template.id == id
    end)
    |> Map.put(:generator_id, generator_id)
    |> Map.put(:contents, contents)
  end

  def get_file(%Template{} = template) do
    "priv/templates/#{template.generator_id}/#{template.id}"
  end

  @doc """
  Updates a template.
  """
  def update(%Template{} = template, attrs, changeset_type) do
    template
    |> Template.changeset(attrs, changeset_type)
    |> Ecto.Changeset.apply_action(:update)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking template changes.
  """
  def change(%Template{} = template, attrs \\ %{}, changeset_type) do
    Template.changeset(template, attrs, changeset_type)
  end
end
