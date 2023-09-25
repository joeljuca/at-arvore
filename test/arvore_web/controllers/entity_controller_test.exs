defmodule ArvoreWeb.EntityControllerTest do
  use ArvoreWeb.ConnCase

  import Arvore.EntitiesFixtures

  alias Arvore.Entities.Entity

  @create_attrs %{
    inep: "some inep",
    name: "some name",
    type: :network
  }
  @update_attrs %{
    inep: "some updated inep",
    name: "some updated name",
    type: :school
  }
  @invalid_attrs %{inep: nil, name: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all entities", %{conn: conn} do
      conn = get(conn, ~p"/api/entities")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create entity" do
    test "renders entity when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/entities", entity: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/entities/#{id}")

      assert %{
               "id" => ^id,
               "inep" => "some inep",
               "name" => "some name",
               "type" => "network"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/entities", entity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update entity" do
    setup [:create_entity]

    test "renders entity when data is valid", %{conn: conn, entity: %Entity{id: id} = entity} do
      conn = put(conn, ~p"/api/entities/#{entity}", entity: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/entities/#{id}")

      assert %{
               "id" => ^id,
               "inep" => "some updated inep",
               "name" => "some updated name",
               "type" => "school"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, entity: entity} do
      conn = put(conn, ~p"/api/entities/#{entity}", entity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete entity" do
    setup [:create_entity]

    test "deletes chosen entity", %{conn: conn, entity: entity} do
      conn = delete(conn, ~p"/api/entities/#{entity}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/entities/#{entity}")
      end
    end
  end

  defp create_entity(_) do
    entity = entity_fixture()
    %{entity: entity}
  end
end
