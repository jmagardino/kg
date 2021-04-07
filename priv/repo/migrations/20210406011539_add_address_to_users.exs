defmodule Kg.Repo.Migrations.AddAddressToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :address, :string
    end
  end
end
