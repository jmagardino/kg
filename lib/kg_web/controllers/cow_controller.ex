defmodule KgWeb.CowController do
  use KgWeb, :controller

  alias Kg.Cows
  alias Kg.Cows.Cow

  def index(conn, _params) do
    cows = Cows.all_cows()

    render(conn, "index.html", cows: cows)
  end

  def show(conn, %{"id" => id}) do
    cow = Kg.Cows.get_cow!(id)
    render(conn, "show.html", cow: cow)
  end

  def new(conn, _params) do
    changeset = Cows.change_cow(%Cow{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cow" => cow_params}) do
    case Cows.create_cow(cow_params) do
      {:ok, cow} ->
        conn
        |> put_flash(:info, "Cow created successfully.")
        |> redirect(to: Routes.cow_path(conn, :show, cow))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
