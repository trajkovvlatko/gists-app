defmodule GistsAppWeb.PublicController do
  use GistsAppWeb, :controller

  alias GistsApp.Publications
  alias GistsApp.Accounts.User

  def index(conn, params) do
    page = Publications.public_gists
           |> GistsApp.Repo.paginate(params)
    user = User.current_user(conn)
    render(conn, "index.html", page: page, user: user)
  end

  def show(conn, %{"id" => id}) do
    gist = Publications.public_gist(id)
    render(conn, "show.html", gist: gist)
  end

  def search(conn, params) do
    term = params["term"]
    page = Publications.public_gists(term)
           |> GistsApp.Repo.paginate(params)
    user = User.current_user(conn)
    render(conn, "index.html", page: page, user: user, term: term)
  end

end
