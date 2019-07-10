defmodule TutorialApp.Repo do
  use Ecto.Repo,
    otp_app: :tutorial_app,
    adapter: Ecto.Adapters.Postgres
end
