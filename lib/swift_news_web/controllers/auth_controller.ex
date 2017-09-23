defmodule SwiftNewsWeb.AuthController do
  use SwiftNewsWeb, :controller

  import SwiftNews.ApiUtil

  alias Comeonin.Bcrypt
  alias SwiftNews.Guardian.Plug
  
  def create(conn, %{"email" => email,
                  "password" => password}) do
    case SwiftNews.DataAccess.Users.create(email, password) do
    {:ok, user} ->
      conn = Plug.sign_in(conn, user.email)
      jwt = Plug.current_token(conn)

      conn 
      |> render("auth.json", %{jwt: jwt, user: user})

    {:error, changeset} ->
      conn 
      |> put_status(400)
      |> render(SwiftNewsWeb.ErrorView, "error.json", %{changeset: changeset})
    end
  end

  def login(conn, %{"email" => email,
                  "password" => password}) do
    user = SwiftNews.DataAccess.Users.find_by_email(email)

    if is_nil(user) do
      conn 
      |> send_error(400, "No user found with that email.")
    else
      if Bcrypt.checkpw(password, user.hashed_password) do
        conn = Plug.sign_in(conn, user.email)
        jwt = Plug.current_token(conn)

        conn |> render("auth.json", %{jwt: jwt, user: user})
      else
        conn |> send_error(401, "Your password is incorrect.")
      end
    end 
  end
end

defmodule SwiftNews.Guardian do
  use Guardian, otp_app: :swift_news

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource)}
  end
  
  def resource_from_claims(claims) do
    {:ok, claims["sub"]}
  end
end