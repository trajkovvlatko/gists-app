defmodule GistsAppWeb.PageController do
  use GistsAppWeb, :controller

  alias GistsApp.Publications

  def index(conn, _params) do
    gists = Publications.public_gists()
    render(conn, "index.html", gists: gists)
  end
end
