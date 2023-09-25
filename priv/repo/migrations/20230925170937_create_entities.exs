defmodule Arvore.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities) do
      timestamps(type: :utc_datetime)

      add :parent_id, references(:entities)
      add :inep, :string
      add :type, :string, null: false
      add :name, :string, null: false
    end

    create unique_index(:entities, [:inep])

    create index(:entities, [:parent_id])
    create index(:entities, [:type])
    create index(:entities, [:name])
  end
end
