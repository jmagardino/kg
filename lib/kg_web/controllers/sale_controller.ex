defmodule KgWeb.SaleController do
  use KgWeb, :controller

  alias Kg.Sales

  def index(conn, _params) do
    sales = Sales.all_sales()

    render(conn, "index.html", sales: sales)
  end

  def show(conn, %{"id" => id}) do
    sale = Kg.Sales.get_sale!(id)
    render(conn, "show.html", sale: sale)
  end
end
