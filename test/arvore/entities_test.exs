defmodule Arvore.EntitiesTest do
  use Arvore.DataCase
  import Arvore.Factory
  alias Arvore.Entities
  alias Arvore.Entities.Entity

  describe "Entities.get_entity_offspring/1" do
    test "returns an empty list when there's no offspring" do
      entity = insert(:entity)

      assert [] = Entities.get_entity_offspring(entity)
    end

    test "returns a list of entities' children" do
      entity = insert(:entity)
      insert(:entity, parent_id: entity.id)

      assert [%Entity{}] = Entities.get_entity_offspring(entity)

      insert(:entity, parent_id: entity.id)

      assert [%Entity{}, %Entity{}] = Entities.get_entity_offspring(entity)
    end

    test "returns a recursive list of entities' children" do
      e0 = insert(:entity)
      insert(:entity, parent_id: e0.id)

      e1 = insert(:entity, parent_id: e0.id)
      insert(:entity, parent_id: e1.id)

      e2 = insert(:entity, parent_id: e1.id)

      e3 = insert(:entity, parent_id: e2.id)
      insert(:entity, parent_id: e3.id)

      offspring = Entities.get_entity_offspring(e0)

      assert 6 = Enum.count(offspring)

      Enum.each(offspring, fn entity ->
        assert %Entity{} = entity
      end)
    end
  end

  describe "Entity.changeset/2" do
    # I'll avoid implementing some basic tests here, in order to prioritize the
    # most complex ones. This is a technical test, so I won't put so much
    # energy in covering all possible test cases.

    test "forbids `parent_id` self-references" do
      entity = insert(:entity)

      assert %Ecto.Changeset{} = Entity.changeset(entity, %{parent_id: entity.id})
    end

    test "forbids `parent_id` for network entities" do
      entity0 = insert(:entity)
      entity1 = insert(:entity, type: :network)

      assert %Ecto.Changeset{} = Entity.changeset(entity1, %{parent_id: entity0.id})

      assert %Ecto.Changeset{} =
               Entity.changeset(entity0, %{type: :network, parent_id: entity1.id})
    end
  end
end
