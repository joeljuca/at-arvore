defmodule Arvore.EntitiesTest do
  use Arvore.DataCase

  alias Arvore.Entities

  describe "entities" do
    alias Arvore.Entities.Entity

    import Arvore.EntitiesFixtures

    @invalid_attrs %{inep: nil, name: nil, type: nil}

    test "list_entities/0 returns all entities" do
      entity = entity_fixture()
      assert Entities.list_entities() == [entity]
    end

    test "get_entity!/1 returns the entity with given id" do
      entity = entity_fixture()
      assert Entities.get_entity!(entity.id) == entity
    end

    test "create_entity/1 with valid data creates a entity" do
      valid_attrs = %{inep: "some inep", name: "some name", type: :network}

      assert {:ok, %Entity{} = entity} = Entities.create_entity(valid_attrs)
      assert entity.inep == "some inep"
      assert entity.name == "some name"
      assert entity.type == :network
    end

    test "create_entity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_entity(@invalid_attrs)
    end

    test "update_entity/2 with valid data updates the entity" do
      entity = entity_fixture()
      update_attrs = %{inep: "some updated inep", name: "some updated name", type: :school}

      assert {:ok, %Entity{} = entity} = Entities.update_entity(entity, update_attrs)
      assert entity.inep == "some updated inep"
      assert entity.name == "some updated name"
      assert entity.type == :school
    end

    test "update_entity/2 with invalid data returns error changeset" do
      entity = entity_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_entity(entity, @invalid_attrs)
      assert entity == Entities.get_entity!(entity.id)
    end

    test "delete_entity/1 deletes the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{}} = Entities.delete_entity(entity)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_entity!(entity.id) end
    end

    test "change_entity/1 returns a entity changeset" do
      entity = entity_fixture()
      assert %Ecto.Changeset{} = Entities.change_entity(entity)
    end
  end
end
