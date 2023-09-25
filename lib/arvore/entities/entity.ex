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

      if not is_nil(parent_id) and "#{parent_id}" == "#{entity.id}" do
        changeset |> add_error(:parent_id, "cannot point to itself")
      else
        changeset
      end
    end)
  end
end
