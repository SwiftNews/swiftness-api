defmodule SwiftNewsWeb.AuthController do
  use SwiftNewsWeb, :controller

  import Ecto.Query
  import SwiftNews.ApiUtil

  alias Comeonin.Bcrypt
  alias SwiftNews.User
  alias SwiftNews.Guardian.Plug
  
  def create(conn, %{"email" => email,
                  "password" => password}) do
    hashed_password = SwiftNews.Authentication.hash_password(password)
    changeset = User.changeset(%User{}, %{email: email, hashed_password: hashed_password, password: password})

    case SwiftNews.Repo.insert(changeset) do
    {:ok, user} ->
      conn = Plug.sign_in(conn, user.email)
      jwt = Plug.current_token(conn)

      conn |> render("auth.json", %{jwt: jwt, user: user})
      
    {:error, _} ->
      conn |> send_error(400, "Invalid email or password")
    end
  end

  def login(conn, %{"email" => email,
                  "password" => password}) do
    user = user_by_email(email)

    if is_nil(user) do
      conn |> send_error(400, "No user found with that email.")
    else
      if Bcrypt.checkpw(password, user.hashed_password) do
        conn = Plug.sign_in(conn, user.email)
        jwt = Plug.current_token(conn)

        conn |> render("auth.json", %{jwt: jwt, user: user})
      else
        conn |> send_error(401, "Your email or password is incorrect.")
      end
    end 
  end

  defp user_by_email(email) do
    User
    |> where([u], u.email == ^email)
    |> SwiftNews.Repo.one
  end
end

defmodule SwiftNews.Guardian do
  use Guardian, otp_app: :swift_news

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource)}
  end

  # def subject_for_token(_, _) do
  #   {:error, :reason_for_error}
  # end

  def resource_from_claims(_claims) do
    {:ok, "test"}
  end

  # def resource_from_claims(_claims) do
  #   {:error, :reason_for_error}
  # end
end