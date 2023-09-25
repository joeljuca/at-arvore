defmodule Arvore.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :name, :string
      add :type, :string
      add :inep, :string
      add :parent, references(:entities, on_delete: :nothing)

      timestamps()
    end

    create index(:entities, [:parent])
  end
end
