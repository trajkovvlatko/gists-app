defmodule GistsAppWeb.PublicController do
  use GistsAppWeb, :controller

  alias GistsApp.Publications

  def index(conn, params) do
    page = Publications.public_gists
           |> GistsApp.Repo.paginate(params)
    render(conn, "index.html", page: page)
  end

  def show(conn, %{"id" => id}) do
    gist = Publications.public_gist(id)
    render(conn, "show.html", gist: gist)
  end

end
