defmodule Kg.Repo.Migrations.CreateEggOrders do
  use Ecto.Migration

  def change do
    create table(:egg_orders) do
      add :quantity, :integer
      add :paid_at, :naive_datetime
      add :completed_at, :naive_datetime
      add :is_delivery, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:egg_orders, [:user_id])
  end
end
