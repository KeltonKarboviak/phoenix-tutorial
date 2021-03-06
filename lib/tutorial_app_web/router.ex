defmodule TutorialAppWeb.Router do
  use TutorialAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug OurAuth
    # plug :put_user_token
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, TutorialApp.Accounts.get_user!(user_id))
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TutorialAppWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true

    get "/test", PageController, :test
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
  end

  scope "/cms", TutorialAppWeb.CMS, as: :cms do
    pipe_through [:browser, :authenticate_user]

    resources "/pages", PageController
  end

  scope "/api", TutorialAppWeb do
    pipe_through :api
  end

  forward "/jobs", BackgroundJob.Plug, name: "Hello Phoenix"
end
