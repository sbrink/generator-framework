defmodule Platform.Core.Generators do
  @moduledoc """
  The Core.Generators context.
  """

  import Ecto.Query, warn: false
  alias Platform.Repo

  alias Platform.Core.Generators.Generator

  @doc """
  Returns the list of generators.

  ## Examples

      iex> list_generators()
      [%Generator{}, ...]

  """
  def list_generators do
    Repo.all(Generator)
  end

  @doc """
  Gets a single generator.

  Raises `Ecto.NoResultsError` if the Generator does not exist.

  ## Examples

      iex> get_generator!(123)
      %Generator{}

      iex> get_generator!(456)
      ** (Ecto.NoResultsError)

  """
  def get_generator!(id), do: Repo.get!(Generator, id)

  @doc """
  Creates a generator.

  ## Examples

      iex> create_generator(%{field: value})
      {:ok, %Generator{}}

      iex> create_generator(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_generator(attrs \\ %{}) do
    %Generator{}
    |> Generator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a generator.

  ## Examples

      iex> update_generator(generator, %{field: new_value})
      {:ok, %Generator{}}

      iex> update_generator(generator, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_generator(%Generator{} = generator, attrs) do
    generator
    |> Generator.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a generator.

  ## Examples

      iex> delete_generator(generator)
      {:ok, %Generator{}}

      iex> delete_generator(generator)
      {:error, %Ecto.Changeset{}}

  """
  def delete_generator(%Generator{} = generator) do
    Repo.delete(generator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking generator changes.

  ## Examples

      iex> change_generator(generator)
      %Ecto.Changeset{data: %Generator{}}

  """
  def change_generator(%Generator{} = generator, attrs \\ %{}) do
    Generator.changeset(generator, attrs)
  end
end
