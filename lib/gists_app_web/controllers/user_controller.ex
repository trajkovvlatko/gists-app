defmodule GistsAppWeb.UserController do
  use GistsAppWeb, :controller

  alias GistsApp.Accounts
  alias GistsApp.Accounts.User

  plug GistsApp.Plugs.Authenticate when not action in [:new, :create]
  plug :check_admin when not action in [:new, :create]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    password = Map.get(user_params, "password")
    hash_password = Comeonin.Bcrypt.hashpwsalt(password)
    user_params = Map.put(user_params, "password_hash", hash_password)

    case Accounts.create_user(user_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User created successfully. Please login.")
        |> redirect(to: session_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  defp check_admin(conn, _) do
    user = conn.assigns[:current_user] || %User{}
    unless user.is_admin do
      conn
      |> put_flash(:info, "The resource is not allowed.")
      |> redirect(to: public_path(conn, :index))
      |> halt
    end
    conn
  end

end
