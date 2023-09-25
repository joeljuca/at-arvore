defmodule ArvoreWeb.EntityJSON do
  alias Arvore.Entities.Entity

  @doc """
  Renders a list of entities.
  """
  def index(%{entities: entities}) do
    %{data: for(entity <- entities, do: data(entity))}
  end

  @doc """
  Renders a single entity.
  """
  def show(%{entity: entity}) do
    %{data: data(entity)}
  end

  defp data(%Entity{} = entity) do
    %{
      id: entity.id,
      name: entity.name,
      type: entity.type,
      inep: entity.inep
    }
  end
end
