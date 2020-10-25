defmodule Kg.EggOrders.EggOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Kg.Accounts.User

  schema "egg_orders" do
    field :completed_at, :naive_datetime
    field :is_delivery, :boolean, default: false
    field :paid_at, :naive_datetime
    field :quantity, :integer
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(egg_order, attrs) do
    egg_order
    |> cast(attrs, [:quantity, :paid_at, :completed_at, :is_delivery])
    |> validate_required([:quantity, :paid_at, :completed_at, :is_delivery])
  end
end
