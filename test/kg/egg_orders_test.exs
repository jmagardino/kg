defmodule Kg.EggOrdersTest do
  use Kg.DataCase

  alias Kg.EggOrders

  describe "egg_orders" do
    alias Kg.EggOrders.EggOrder

    @valid_attrs %{completed_at: ~N[2010-04-17 14:00:00], is_delivery: true, paid_at: ~N[2010-04-17 14:00:00], quantity: 42}
    @update_attrs %{completed_at: ~N[2011-05-18 15:01:01], is_delivery: false, paid_at: ~N[2011-05-18 15:01:01], quantity: 43}
    @invalid_attrs %{completed_at: nil, is_delivery: nil, paid_at: nil, quantity: nil}
    @user_attrs %{"email" => "test@test.com", "password" => "tester123456789"}

    def egg_order_fixture(attrs \\ %{}) do
      {:ok, user} = Kg.Accounts.register_user(@user_attrs)

      {:ok, egg_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> EggOrders.create_egg_order(user)

      egg_order
    end

    test "list_egg_orders/0 returns all egg_orders with user information" do
      egg_order = egg_order_fixture()
      [created_egg_order] = EggOrders.list_egg_orders()

      assert created_egg_order.id == egg_order.id
      assert created_egg_order.is_delivery == egg_order.is_delivery
      assert created_egg_order.paid_at == egg_order.paid_at
      assert created_egg_order.quantity == egg_order.quantity
    end

    test "list_egg_orders_for_user/1 returns all egg_orders for a specific user with user information" do
      egg_order = egg_order_fixture()
      user_id = egg_order.user_id

      [created_egg_order] = EggOrders.list_egg_orders_for_user(user_id)

      assert created_egg_order.id == egg_order.id
      assert created_egg_order.is_delivery == egg_order.is_delivery
      assert created_egg_order.paid_at == egg_order.paid_at
      assert created_egg_order.quantity == egg_order.quantity

      [] = EggOrders.list_egg_orders_for_user(1000)
    end

    test "get_egg_order!/1 returns the egg_order with given id" do
      egg_order = egg_order_fixture()
      assert EggOrders.get_egg_order!(egg_order.id) == egg_order
    end

    test "create_egg_order/1 with valid data creates a egg_order" do
      {:ok, user} = Kg.Accounts.register_user(@user_attrs)

      assert {:ok, %EggOrder{} = egg_order} = EggOrders.create_egg_order(@valid_attrs, user)
      assert egg_order.completed_at == ~N[2010-04-17 14:00:00]
      assert egg_order.is_delivery == true
      assert egg_order.paid_at == ~N[2010-04-17 14:00:00]
      assert egg_order.quantity == 42
    end

    test "create_egg_order/1 with invalid data returns error changeset" do
      {:ok, user} = Kg.Accounts.register_user(@user_attrs)
      assert {:error, %Ecto.Changeset{}} = EggOrders.create_egg_order(@invalid_attrs, user)
    end

    test "update_egg_order/2 with valid data updates the egg_order" do
      egg_order = egg_order_fixture()
      assert {:ok, %EggOrder{} = egg_order} = EggOrders.update_egg_order(egg_order, @update_attrs)
      assert egg_order.completed_at == ~N[2011-05-18 15:01:01]
      assert egg_order.is_delivery == false
      assert egg_order.paid_at == ~N[2011-05-18 15:01:01]
      assert egg_order.quantity == 43
    end

    test "update_egg_order/2 with invalid data returns error changeset" do
      egg_order = egg_order_fixture()
      assert {:error, %Ecto.Changeset{}} = EggOrders.update_egg_order(egg_order, @invalid_attrs)
      assert egg_order == EggOrders.get_egg_order!(egg_order.id)
    end

    test "delete_egg_order/1 deletes the egg_order" do
      egg_order = egg_order_fixture()
      assert {:ok, %EggOrder{}} = EggOrders.delete_egg_order(egg_order)
      assert_raise Ecto.NoResultsError, fn -> EggOrders.get_egg_order!(egg_order.id) end
    end

    test "change_egg_order/1 returns a egg_order changeset" do
      egg_order = egg_order_fixture()
      assert %Ecto.Changeset{} = EggOrders.change_egg_order(egg_order)
    end
  end
end
