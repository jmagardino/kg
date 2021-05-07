defmodule Kg.Repo.Migrations.CreateCowsTable do
  use Ecto.Migration

  def change do
    create table(:cows) do
      add :name, :string
      add :calved_on, :date

      timestamps()
    end
  end
end
