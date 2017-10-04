defmodule GistsApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :is_admin, :boolean, default: false

      timestamps()
    end

  end
end
