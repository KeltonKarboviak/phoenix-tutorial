defmodule TutorialAppWeb.HelloController do
  use TutorialAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
