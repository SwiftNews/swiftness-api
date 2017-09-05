defmodule SwiftNewsWeb.Router do
  use SwiftNewsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SwiftNewsWeb do
    pipe_through :api
  end
end
