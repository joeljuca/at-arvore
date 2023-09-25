defmodule Arvore.EntitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Arvore.Entities` context.
  """

  @doc """
  Generate a entity.
  """
  def entity_fixture(attrs \\ %{}) do
    {:ok, entity} =
      attrs
      |> Enum.into(%{
        inep: "some inep",
        name: "some name",
        type: :network
      })
      |> Arvore.Entities.create_entity()

    entity
  end
end
