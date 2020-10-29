defmodule KgWeb.EggOrderControllerTest do
  use KgWeb.ConnCase

  alias Kg.EggOrders

  @create_attrs %{completed_at: ~N[2010-04-17 14:00:00], is_delivery: true, paid_at: ~N[2010-04-17 14:00:00], quantity: 42}
  @update_attrs %{completed_at: ~N[2011-05-18 15:01:01], is_delivery: false, paid_at: ~N[2011-05-18 15:01:01], quantity: 43}
  @invalid_attrs %{completed_at: nil, is_delivery: nil, paid_at: nil, quantity: nil}
  @account_attrs %{email: "tester@tester.com", password: "password12345678"}

  def fixture(:egg_order) do
    {:ok, user} = Kg.Accounts.register_user(@account_attrs)

    {:ok, egg_order} = EggOrders.create_egg_order(@create_attrs, user)

    egg_order
  end

  setup :register_and_log_in_user

  describe "index" do
    test "lists all egg_orders", %{conn: conn} do
      conn = get(conn, Routes.egg_order_path(conn, :index))
      assert html_response(conn, 200) =~ "Egg orders"
    end
  end

  describe "new egg_order" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.egg_order_path(conn, :new))
      assert html_response(conn, 200) =~ "Order Your Eggs"
    end
  end

  describe "create egg_order" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.egg_order_path(conn, :create), egg_order: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.egg_order_path(conn, :show, id)

      conn = get(conn, Routes.egg_order_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Egg order"
    end

    test "allows the paid_at and completed_at values to be empty on create", %{conn: conn} do
      attrs =
        @create_attrs
        |> Map.delete("paid_at")
        |> Map.delete("completed_at")

      conn = post(conn, Routes.egg_order_path(conn, :create), egg_order: attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.egg_order_path(conn, :show, id)

      conn = get(conn, Routes.egg_order_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Egg order"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.egg_order_path(conn, :create), egg_order: @invalid_attrs)
      assert html_response(conn, 200) =~ "Order Your Eggs"
    end
  end

  describe "edit egg_order" do
    setup [:create_egg_order]

    test "renders form for editing chosen egg_order", %{conn: conn, egg_order: egg_order} do
      conn = get(conn, Routes.egg_order_path(conn, :edit, egg_order))
      assert html_response(conn, 200) =~ "Edit Egg order"
    end
  end

  describe "update egg_order" do
    setup [:create_egg_order]

    test "redirects when data is valid", %{conn: conn, egg_order: egg_order} do
      conn = put(conn, Routes.egg_order_path(conn, :update, egg_order), egg_order: @update_attrs)
      assert redirected_to(conn) == Routes.egg_order_path(conn, :show, egg_order)

      conn = get(conn, Routes.egg_order_path(conn, :show, egg_order))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, egg_order: egg_order} do
      conn = put(conn, Routes.egg_order_path(conn, :update, egg_order), egg_order: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Egg order"
    end
  end

  describe "delete egg_order" do
    setup [:create_egg_order]

    test "deletes chosen egg_order", %{conn: conn, egg_order: egg_order} do
      conn = delete(conn, Routes.egg_order_path(conn, :delete, egg_order))
      assert redirected_to(conn) == Routes.egg_order_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.egg_order_path(conn, :show, egg_order))
      end
    end
  end

  defp create_egg_order(_) do
    egg_order = fixture(:egg_order)
    %{egg_order: egg_order}
  end
end
