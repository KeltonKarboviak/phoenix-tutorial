defmodule TutorialAppWeb.Router do
  use TutorialAppWeb, :router

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

  scope "/", TutorialAppWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/test", PageController, :test
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
  end

  scope "/api", TutorialAppWeb do
    pipe_through :api
  end

  forward "/jobs", BackgroundJob.Plug, name: "Hello Phoenix"
end
