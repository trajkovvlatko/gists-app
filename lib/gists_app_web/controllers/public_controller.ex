defmodule GistsAppWeb.PublicController do
  use GistsAppWeb, :controller

  alias GistsApp.Publications

  def index(conn, _) do
    gists = Publications.public_gists
    render(conn, "index.html", gists: gists)
  end

  def show(conn, %{"id" => id}) do
    gist = Publications.public_gist(id)
    render(conn, "show.html", gist: gist)
  end

end
