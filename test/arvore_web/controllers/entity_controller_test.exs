defmodule ArvoreWeb.EntityControllerTest do
  use ArvoreWeb.ConnCase
  import Arvore.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "GET /entities" do
    test "lists all entities", %{conn: conn} do
      conn = get(conn, ~p"/api/v2/partners/entities")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "POST /entities" do
    test "requires a name", %{conn: conn} do
      params = params_for(:entity) |> Map.delete(:name)

      conn0 = post(conn, ~p"/api/v2/partners/entities", params)
      assert json_response(conn0, 422)["errors"] != %{}

      params = params |> Map.put(:name, "Linus Torvalds")

      conn1 = post(conn, ~p"/api/v2/partners/entities", params)
      assert json_response(conn1, 201)
    end

    test "creates a entity", %{conn: conn} do
      params = params_for(:entity)

      conn = post(conn, ~p"/api/v2/partners/entities", params)
      assert %{"data" => entity} = json_response(conn, 201)

      assert "#{entity["name"]}" == "#{params.name}"
      assert "#{entity["inep"]}" == "#{params.inep}"
      assert "#{entity["type"]}" == "#{params.type}"
    end
  end

  describe "PATCH /entities/:id" do
    setup do
      %{entity: insert(:entity)}
    end

    test "updates a entity's name", %{conn: conn, entity: entity} do
      new_name = Faker.Person.name()

      conn0 = patch(conn, ~p"/api/v2/partners/entities/#{entity}", %{name: new_name})

      assert %{"data" => payload} = json_response(conn0, 200)
      assert payload["name"] == new_name

      conn1 = get(conn, ~p"/api/v2/partners/entities/#{entity}")

      assert %{"data" => payload} = json_response(conn1, 200)
      assert payload["name"] == new_name
    end

    test "updates a entity's inep", %{conn: conn, entity: entity} do
      new_inep = build(:inep)

      conn0 = patch(conn, ~p"/api/v2/partners/entities/#{entity}", %{inep: new_inep})

      assert %{"data" => payload} = json_response(conn0, 200)
      assert payload["inep"] == new_inep

      conn0 = get(conn, ~p"/api/v2/partners/entities/#{entity}")
      assert %{"data" => payload} = json_response(conn0, 200)
      assert payload["inep"] == new_inep
    end
  end

  describe "DELETE /entities/:id" do
    setup do
      %{entity: insert(:entity)}
    end

    test "deletes a entity", %{conn: conn, entity: entity} do
      conn0 = delete(conn, ~p"/api/v2/partners/entities/#{entity}")
      assert response(conn0, 204)

      conn1 = get(conn, ~p"/api/v2/partners/entities/#{entity}")
      assert json_response(conn1, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end
  end
end
