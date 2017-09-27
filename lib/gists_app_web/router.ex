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

    get "/", PageController, :index
    resources "/gists", GistController
    resources "/users", UserController

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/register", UserController, :new
    delete "/logout", SessionController, :delete
  end

end
