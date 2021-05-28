defmodule Kg.Repo.Migrations.CreateSalesTable do
  use Ecto.Migration

  def change do
    create table(:sales) do
      add :name, :string
      add :sale_date, :date

      timestamps()
    end
  end
end
