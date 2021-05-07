defmodule KgWeb.CowController do
  use KgWeb, :controller

  alias Kg.Cows
  def index(conn, _params) do
    cows = Cows.all_cows()

    render(conn, "index.html", cows: cows)
  end

  def show(conn, %{"id" => id}) do
    cow = Kg.Cows.get_cow!(id)
    render(conn, "show.html", cow: cow)
  end
end
