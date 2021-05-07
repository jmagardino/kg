defmodule Kg.Cows do
  alias Kg.Cows.Cow
  alias Kg.Repo

  import Ecto.Query, warn: false

  def create_cow(attrs) do
    %Cow{}
    |> Cow.changeset(attrs)
    |> Repo.insert()
  end

  def all_cows() do
    query = from(c in Cow)
    Repo.all(query)
  end

  def get_cow!(id), do: Repo.get!(Cow, id)
end
