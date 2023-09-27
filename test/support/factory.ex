defmodule Arvore.Factory do
  @moduledoc """
  ExMachina-based Ecto schema factories for tests.
  """
  use ExMachina.Ecto, repo: Arvore.Repo

  def entity_factory do
    %Arvore.Entities.Entity{
      inep: build(:inep),
      type: [:network, :school, :class] |> Enum.random(),
      name: Faker.Company.name()
    }
  end

  # Utils

  def inep_factory(_) do
    1..Enum.random(4..8)
    |> Enum.map(fn _ -> Enum.random(0..9) end)
    |> Enum.join("")
  end
end
