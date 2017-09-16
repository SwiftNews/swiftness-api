defmodule SwiftNewsWeb.AuthController do
  use SwiftNewsWeb, :controller

  import Ecto.Query

  alias Comeonin.Bcrypt
  
  def create(conn, %{"email" => email,
                  "password" => password}) do
    hashed_password = SwiftNews.Authentication.hash_password(password)
    changeset = SwiftNews.User.changeset(%SwiftNews.User{}, %{email: email, password: hashed_password})
    case SwiftNews.Repo.insert(changeset) do
    {:ok, user} ->

      conn = SwiftNews.Guardian.Plug.sign_in(conn, user.email)
      jwt = SwiftNews.Guardian.Plug.current_token(conn)
      claims = SwiftNews.Guardian.Plug.current_claims(conn)
      exp = Map.get(claims, "exp")

      conn
      |> render("auth.json", %{jwt: jwt, user: user})

    {:error, changeset} ->
      conn |>
          json("failure")
    end
  end

  def login(conn, %{"email" => email,
                  "password" => password}) do
    user = SwiftNews.User
            |> where([u], u.email == ^email)
            |> SwiftNews.Repo.one

    if Bcrypt.checkpw(password, user.password) do
      conn = SwiftNews.Guardian.Plug.sign_in(conn, user.email)
      jwt = SwiftNews.Guardian.Plug.current_token(conn)
      claims = SwiftNews.Guardian.Plug.current_claims(conn)
      exp = Map.get(claims, "exp")

      conn
      |> render("auth.json", %{jwt: jwt, user: user})
    else
      conn
      |> put_status(401)
      |> render(SwiftNewsWeb.ErrorView, "error.json", %{message: "Your email or password is incorrect."})
    end
  end
end

defmodule SwiftNews.Guardian do
  use Guardian, otp_app: :swift_news

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource)}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    {:ok, "test"}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end