defmodule FootballWeb.Router do
  use FootballWeb, :router

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

  scope "/", FootballWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", FootballWeb do
    pipe_through :api

    get "/leagues", LeaguesController, :index
    get "/leagues/:division/:season", LeaguesController, :show
    get "/protobuff/:division/:season", ProtobuffsController, :index
  end
end
