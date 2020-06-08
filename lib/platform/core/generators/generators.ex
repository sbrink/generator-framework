defmodule Platform.Core.Generators do
  @moduledoc """
  The Core.Generators context.
  """
  alias Platform.Core.Generators.Generator
  @templates_dir "priv/templates"
  @generator_config "gen.exs"

  @doc """
  Returns the list of generators.
  """
  def list do
    "#{@templates_dir}/*/#{@generator_config}"
    |> Path.wildcard()
    |> Enum.map(fn file ->
      file
      |> Path.dirname()
      |> Path.split()
      |> List.last()
      |> get!()
    end)
  end

  @doc """
  Gets a single generator.
  """
  def get!(id) do
    {result, _} = Code.eval_file("#{@templates_dir}/#{id}/#{@generator_config}")
    result
  end

  @doc """
  Creates a generator.
  """
  def create(attrs \\ %{}) do
    %Generator{}
    |> Generator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a generator.
  """
  def update(%Generator{} = generator, attrs) do
    generator
    |> Generator.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a generator.
  """
  def delete(%Generator{} = generator) do
    Repo.delete(generator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking generator changes.
  """
  def change(%Generator{} = generator, attrs \\ %{}) do
    Generator.changeset(generator, attrs)
  end
end
