defmodule KgWeb.PageController do
  use KgWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
