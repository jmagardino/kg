defmodule Kg.EggOrders do
  @moduledoc """
  The EggOrders context.
  """

  import Ecto.Query, warn: false
  alias Kg.Repo

  alias Kg.EggOrders.EggOrder
  alias Kg.Accounts.User

  @doc """
  Returns the list of egg_orders.

  ## Examples

      iex> list_egg_orders()
      [%EggOrder{}, ...]

  """
  def list_egg_orders do
    EggOrder
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Returns the list of egg_orders belonging to a specific account

  ## Examples

      iex> list_egg_orders_for_user(1)
      [%EggOrder{}, ...]

  """
  def list_egg_orders_for_user(user_id) do
    query = from eo in EggOrder, where: eo.user_id == ^user_id

    Repo.all(query)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single egg_order.

  Raises `Ecto.NoResultsError` if the Egg order does not exist.

  ## Examples

      iex> get_egg_order!(123)
      %EggOrder{}

      iex> get_egg_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_egg_order!(id), do: Repo.get!(EggOrder, id)

  @doc """
  Creates a egg_order.

  ## Examples

      iex> create_egg_order(%{field: value})
      {:ok, %EggOrder{}}

      iex> create_egg_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_egg_order(attrs \\ %{}, %User{} = user) do
    user
    |> Ecto.build_assoc(:egg_order)
    |> EggOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a egg_order.

  ## Examples

      iex> update_egg_order(egg_order, %{field: new_value})
      {:ok, %EggOrder{}}

      iex> update_egg_order(egg_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_egg_order(%EggOrder{} = egg_order, attrs) do
    egg_order
    |> EggOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a egg_order.

  ## Examples

      iex> delete_egg_order(egg_order)
      {:ok, %EggOrder{}}

      iex> delete_egg_order(egg_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_egg_order(%EggOrder{} = egg_order) do
    Repo.delete(egg_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking egg_order changes.

  ## Examples

      iex> change_egg_order(egg_order)
      %Ecto.Changeset{data: %EggOrder{}}

  """
  def change_egg_order(%EggOrder{} = egg_order, attrs \\ %{}) do
    EggOrder.changeset(egg_order, attrs)
  end
end
