# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GistsApp.Repo.insert!(%GistsApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

GistsApp.Repo.insert!(%GistsApp.Accounts.User{
  email: "admin@admin.com",
  password_hash: Comeonin.Bcrypt.hashpwsalt("admin@admin.com"),
  is_admin: true
})
