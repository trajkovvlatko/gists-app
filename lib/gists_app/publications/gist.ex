defmodule GistsApp.Publications.Gist do
  use Ecto.Schema
  import Ecto.Changeset
  alias GistsApp.Publications.Gist
  alias GistsApp.Accounts.User


  schema "gists" do
    field :code, :string
    field :name, :string
    field :public, :boolean
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Gist{} = gist, attrs) do
    gist
    |> cast(attrs, [:name, :code, :user_id, :public])
    |> validate_required([:name, :code, :user_id, :public])
  end
end
