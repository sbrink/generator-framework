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
    generator_id
    |> list_for_generator()
    |> Enum.find(fn template ->
      template.id == id
    end)
    |> Map.put(:generator_id, generator_id)
  end

  def get_file(%Template{} = template) do
    "priv/templates/#{template.generator_id}/#{template.id}"
  end
end
