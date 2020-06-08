defmodule Platform.Core.Generators.Generator do
  use Ecto.Schema
  import Ecto.Changeset

  schema "generators" do
    field :name, :string
    field :func, :string
    field :templates, :string
  end

  @doc false
  def changeset(generator, attrs) do
    generator
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
