defmodule Kg.Cows.Cow do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cows" do
    field :name, :string
    field :calved_on, :date

    timestamps()
  end

  @doc false
  def changeset(cow, attrs) do
    cow
    |> cast(attrs, [:name, :calved_on])
    |> validate_required([:name, :calved_on])
  end
end
