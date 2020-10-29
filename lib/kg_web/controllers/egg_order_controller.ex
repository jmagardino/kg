defmodule KgWeb.EggOrderController do
  use KgWeb, :controller

  alias Kg.EggOrders
  alias Kg.EggOrders.EggOrder

  def index(conn, _params) do
    egg_orders = EggOrders.list_egg_orders()
    render(conn, "index.html", egg_orders: egg_orders)
  end

  def new(conn, _params) do
    changeset = EggOrders.change_egg_order(%EggOrder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"egg_order" => egg_order_params}) do
    user = conn.assigns.current_user

    egg_order_params =
      egg_order_params
      |> Map.put("paid_at", nil)
      |> Map.put("completed_at", nil)

    case EggOrders.create_egg_order(egg_order_params, user) do
      {:ok, egg_order} ->
        conn
        |> put_flash(:info, "Egg order created successfully.")
        |> redirect(to: Routes.egg_order_path(conn, :show, egg_order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    egg_order = EggOrders.get_egg_order!(id)
    render(conn, "show.html", egg_order: egg_order)
  end

  def edit(conn, %{"id" => id}) do
    egg_order = EggOrders.get_egg_order!(id)
    changeset = EggOrders.change_egg_order(egg_order)
    render(conn, "edit.html", egg_order: egg_order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "egg_order" => egg_order_params}) do
    egg_order = EggOrders.get_egg_order!(id)

    case EggOrders.update_egg_order(egg_order, egg_order_params) do
      {:ok, egg_order} ->
        conn
        |> put_flash(:info, "Egg order updated successfully.")
        |> redirect(to: Routes.egg_order_path(conn, :show, egg_order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", egg_order: egg_order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    egg_order = EggOrders.get_egg_order!(id)
    {:ok, _egg_order} = EggOrders.delete_egg_order(egg_order)

    conn
    |> put_flash(:info, "Egg order deleted successfully.")
    |> redirect(to: Routes.egg_order_path(conn, :index))
  end
end
