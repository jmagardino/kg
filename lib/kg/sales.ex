defmodule Kg.Sales do
  alias Kg.Sales.Sale
  alias Kg.Repo

  import Ecto.Query, warn: false

  def create_sale(attrs) do
    %Sale{}
    |> Sale.changeset(attrs)
    |> Repo.insert()
  end

  def all_sales() do
    query = from(c in Sale)
    Repo.all(query)
  end

  def get_sale!(id), do: Repo.get!(Sale, id)
end
