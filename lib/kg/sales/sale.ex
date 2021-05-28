defmodule Kg.Sales.Sale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales" do
    field :name, :string
    field :sale_date, :date

    timestamps()
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:name, :sale_date])
    |> validate_required([:name, :sale_date])
  end
end
