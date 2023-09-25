defmodule ArvoreWeb.EntityController do
  use ArvoreWeb, :controller

  alias Arvore.Entities
  alias Arvore.Entities.Entity

  action_fallback ArvoreWeb.FallbackController

  def index(conn, _params) do
    entities = Entities.list_entities()
    render(conn, :index, entities: entities)
  end

  def create(conn, %{"entity" => entity_params}) do
    with {:ok, %Entity{} = entity} <- Entities.create_entity(entity_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/entities/#{entity}")
      |> render(:show, entity: entity)
    end
  end

  def show(conn, %{"id" => id}) do
    entity = Entities.get_entity!(id)
    render(conn, :show, entity: entity)
  end

  def update(conn, %{"id" => id, "entity" => entity_params}) do
    entity = Entities.get_entity!(id)

    with {:ok, %Entity{} = entity} <- Entities.update_entity(entity, entity_params) do
      render(conn, :show, entity: entity)
    end
  end

  def delete(conn, %{"id" => id}) do
    entity = Entities.get_entity!(id)

    with {:ok, %Entity{}} <- Entities.delete_entity(entity) do
      send_resp(conn, :no_content, "")
    end
  end
end
