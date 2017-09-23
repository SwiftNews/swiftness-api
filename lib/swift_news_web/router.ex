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
    plug Guardian.Plug.EnsureAuthenticated, handler: SwiftNews.AuthErrorHandler 
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

  def user_authenticated(conn, _) do
    token = SwiftNews.Guardian.Plug.current_token(conn)
    case SwiftNews.Guardian.decode_and_verify(token) do
      {:ok, _} ->
        conn
      {:error, _} ->
        conn
        |> put_status(401)
        |> json("Invalid auth token")
        |> halt
      
    end
  end
end
