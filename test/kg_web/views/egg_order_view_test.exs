defmodule KgWeb.EggOrderViewTest do
  use KgWeb.ConnCase, async: true

  alias KgWeb.EggOrderView
  alias Kg.EggOrders

  @create_attrs_completed %{completed_at: ~N[2010-04-17 14:00:00], is_delivery: true, paid_at: ~N[2010-04-17 14:00:00], quantity: 42}
  @create_attrs_pending %{completed_at: nil, is_delivery: true, paid_at: ~N[2010-04-17 14:00:00], quantity: 42}
  @account_attrs %{email: "tester@tester.com", password: "password12345678"}

  test "pending order returns only orders that have not been completed" do
    {:ok, user} = Kg.Accounts.register_user(@account_attrs)

    {:ok, completed} = EggOrders.create_egg_order(@create_attrs_completed, user)
    {:ok, pending} = EggOrders.create_egg_order(@create_attrs_pending, user)

    order_list = [completed, pending]

    assert [completed] == EggOrderView.completed_egg_orders(order_list)
    assert [pending] == EggOrderView.pending_egg_orders(order_list)
  end
end
