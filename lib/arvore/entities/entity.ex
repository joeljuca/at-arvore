defmodule Arvore.Entities.Entity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entities" do
    field :inep, :string
    field :name, :string
    field :type, Ecto.Enum, values: [:network, :school, :class]
    field :parent, :id

    timestamps()
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:name, :type, :inep])
    |> validate_required([:name, :type, :inep])
  end
end
