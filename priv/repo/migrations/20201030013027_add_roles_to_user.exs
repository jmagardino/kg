defmodule Kg.Repo.Migrations.AddRolesToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :roles, {:array, :string}, default: ["customer"]
    end
  end
end
