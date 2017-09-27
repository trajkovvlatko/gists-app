defmodule GistsApp.Repo.Migrations.CreateGists do
  use Ecto.Migration

  def change do
    create table(:gists) do
      add :name, :string, null: false
      add :code, :text, null: false
      add :public, :boolean, null: false, default: false
      add :user_id, :integer, null: false

      timestamps()
    end

  end
end
