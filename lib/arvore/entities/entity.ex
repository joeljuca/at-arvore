defmodule Arvore.Entities.Entity do
  use Ecto.Schema
  use SwissSchema, repo: Arvore.Repo
  import Ecto.Changeset
  alias Arvore.Entities.Entity

  schema "entities" do
    belongs_to :parent, Entity
    has_many :children, Entity

    field :inep, :string
    field :type, Ecto.Enum, values: [:network, :school, :class], default: :school
    field :name, :string

    # offspring IDs (children, grandchildren, etc., recursively)
    field :offspring, {:array, :integer}, virtual: true

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:parent_id, :inep, :type, :name])
    |> validate_required([:type, :name])
    |> foreign_key_constraint(:parent_id)
    |> unique_constraint(:inep)
    |> then(fn %{changes: changes, errors: _errors} = changeset ->
      parent_id = Map.get(changes, :parent_id)
      type = Map.get(changes, :type)

      cond do
        !is_nil(parent_id) and "#{parent_id}" == "#{entity.id}" ->
          changeset |> add_error(:parent_id, "cannot point to itself")

        !is_nil(parent_id) and :network in [entity.type, type] ->
          changeset |> add_error(:parent_id, "is not allowed for network entities")

        true ->
          changeset
      end
    end)
  end
end
