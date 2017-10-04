defmodule GistsApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias GistsApp.Accounts.User
  alias GistsApp.Publications.Gist

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :is_admin, :boolean
    has_many :gists, Gist

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_hash])
    |> validate_required([:email, :password])
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :user_id)
    if id, do: GistsApp.Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)

  def is_admin?(conn), do: current_user(conn).is_admin

end
