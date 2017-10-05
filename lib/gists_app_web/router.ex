defmodule GistsAppWeb.Router do
  use GistsAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GistsAppWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PublicController, :index
    get "/public/:id", PublicController, :show

    resources "/gists", GistController

    resources "/users", UserController
    get "/register", UserController, :new

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

end
