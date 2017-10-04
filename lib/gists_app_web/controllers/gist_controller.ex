defmodule GistsAppWeb.GistController do
  use GistsAppWeb, :controller

  alias GistsApp.Publications
  alias GistsApp.Publications.Gist

  plug GistsApp.Plugs.Authenticate

  def index(conn, _params) do
    user = conn.assigns.current_user
    gists = Publications.list_gists(user)
    render(conn, "index.html", gists: gists)
  end

  def new(conn, _params) do
    changeset = Publications.change_gist(%Gist{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gist" => gist_params}) do
    gist_params = Map.put(gist_params, "user_id", conn.assigns.current_user.id)
    case Publications.create_gist(gist_params) do
      {:ok, gist} ->
        conn
        |> put_flash(:info, "Gist created successfully.")
        |> redirect(to: gist_path(conn, :show, gist))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gist = Publications.get_gist!(conn.assigns.current_user, id)
    render(conn, "show.html", gist: gist)
  end

  def edit(conn, %{"id" => id}) do
    gist = Publications.get_gist!(conn.assigns.current_user, id)
    changeset = Publications.change_gist(gist)
    render(conn, "edit.html", gist: gist, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gist" => gist_params}) do
    gist = Publications.get_gist!(conn.assigns.current_user, id)

    case Publications.update_gist(gist, gist_params) do
      {:ok, gist} ->
        conn
        |> put_flash(:info, "Gist updated successfully.")
        |> redirect(to: gist_path(conn, :show, gist))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gist: gist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gist = Publications.get_gist!(conn.assigns.current_user, id)
    {:ok, _gist} = Publications.delete_gist(gist)

    conn
    |> put_flash(:info, "Gist deleted successfully.")
    |> redirect(to: gist_path(conn, :index))
  end

end
