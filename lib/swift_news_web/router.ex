defmodule SwiftNewsWeb.Router do
  use SwiftNewsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated_api do
    plug Guardian.Plug.Pipeline, module: SwiftNews.Guardian,
                          error_handler: SwiftNews.AuthErrorHandler 
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", SwiftNewsWeb do
    pipe_through :api

    get "/", HealthCheckController, :index

    post "/user/", AuthController, :create
    post "/auth/", AuthController, :login
  end

  scope "/", SwiftNewsWeb do
    pipe_through [:api, :authenticated_api]

    post "/story/", StoryController, :create    
  end
end
