defmodule Platform.Core.Templates.Template do
  use Ecto.Schema
  import Ecto.Changeset

  schema "" do
    field :generator_id, :string
    field :file, :string
    field :contents, :string
    field :syntax, :string
  end

  @doc false
  @fields ~w(contents)a
  def changeset(template, attrs, type) when type in [:create, :update] do
    template
    |> cast(attrs, @fields)
    |> validate_required(~w(contents)a)
  end
end
