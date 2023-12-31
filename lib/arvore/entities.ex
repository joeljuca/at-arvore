defmodule Arvore.Entities do
  @moduledoc """
  The Entities context.
  """

  import Ecto.Query, warn: false
  alias Arvore.Repo

  alias Arvore.Entities.Entity

  @doc """
  Returns the list of entities.

  ## Examples

      iex> list_entities()
      [%Entity{}, ...]

  """
  def list_entities do
    Repo.all(Entity)
  end

  @doc """
  Gets a single entity.

  Raises `Ecto.NoResultsError` if the Entity does not exist.

  ## Examples

      iex> get_entity!(123)
      %Entity{}

      iex> get_entity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entity!(id), do: Repo.get!(Entity, id)

  @doc """
  Gets a single entity.

  ## Examples

      iex> get_entity(123)
      {:ok, %Entity{}}

      iex> get_entity(456)
      {:error, :not_found}

  """
  def get_entity(id) do
    case Repo.get(Entity, id) do
      %Entity{} = entity -> {:ok, entity}
      _ -> {:error, :not_found}
    end
  end

  @doc """
  Returns a recursive list of entities related to the given entity.

  ## Examples

    iex> {:ok, entity} = get_entity(1)
    {:ok, %Entity{}}

    iex> get_entity_offspring(entity)
    [%Entity{}, %Entity{}, ...]

  """
  def get_entity_offspring(%Entity{id: id}) do
    cte = """
      WITH RECURSIVE cte AS (
        SELECT id FROM entities WHERE parent_id = ?
        UNION
        SELECT e.id id FROM cte o LEFT JOIN entities e ON o.id = e.parent_id
      )
      SELECT id FROM cte ORDER BY id
    """

    with {:ok, %{rows: rows}} <- Repo.query(cte, [id]),
         entity_ids <- rows |> List.flatten() |> Enum.reject(&is_nil/1),
         entities <- Repo.all(from e in Entity, where: e.id in ^entity_ids) do
      entities
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  @doc """
  Creates a entity.

  ## Examples

      iex> create_entity(%{field: value})
      {:ok, %Entity{}}

      iex> create_entity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entity(attrs \\ %{}) do
    %Entity{}
    |> Entity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entity.

  ## Examples

      iex> update_entity(entity, %{field: new_value})
      {:ok, %Entity{}}

      iex> update_entity(entity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entity(%Entity{} = entity, attrs) do
    entity
    |> Entity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entity.

  ## Examples

      iex> delete_entity(entity)
      {:ok, %Entity{}}

      iex> delete_entity(entity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entity(%Entity{} = entity) do
    Repo.delete(entity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entity changes.

  ## Examples

      iex> change_entity(entity)
      %Ecto.Changeset{data: %Entity{}}

  """
  def change_entity(%Entity{} = entity, attrs \\ %{}) do
    Entity.changeset(entity, attrs)
  end
end
