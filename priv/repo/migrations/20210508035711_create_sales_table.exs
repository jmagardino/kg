defmodule Kg.Repo.Migrations.CreateSalesTable do
  use Ecto.Migration

  def change do
    create table(:sales) do

      timestamps()
    end
  end
end
