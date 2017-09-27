defmodule GistsApp.Plugs.Authenticate do
  import Plug.Conn
  import Phoenix.Controller
  import GistsAppWeb.Router.Helpers

  alias GistsApp.Accounts.User

  def init(_) do
    nil
  end

  def call(conn, _opts) do
    user = User.current_user(conn)
    case user do
      nil  -> invalid_user(conn)
      user -> assign(conn, :current_user, user)
    end
  end

  defp invalid_user(conn) do
    conn
    |> put_flash(:error, "Please login first.")
    |> redirect(to: session_path(conn, :new))
    |> halt
  end
end
