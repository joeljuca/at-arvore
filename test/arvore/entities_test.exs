defmodule Arvore.EntitiesTest do
  use Arvore.DataCase
  import Arvore.Factory
  alias Arvore.Entities.Entity

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
