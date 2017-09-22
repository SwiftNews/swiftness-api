defmodule SwiftNewsWeb.Router do
  use SwiftNewsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SwiftNewsWeb do
    pipe_through :api

    get "/", HealthCheckController, :index

    post "/user/", AuthController, :create
    post "/auth/", AuthController, :login

    post "/story/", StoryController, :create
  end
end
