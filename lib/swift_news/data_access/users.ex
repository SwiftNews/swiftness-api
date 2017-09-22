defmodule SwiftNews.DataAccess.Users do
  import Ecto.Query

  alias SwiftNews.User
  
  def create(email, password) do
    hashed_password = SwiftNews.Authentication.hash_password(password)
    changeset = User.changeset(%User{}, %{email: email, hashed_password: hashed_password, password: password})
    SwiftNews.Repo.insert(changeset)
  end

  def find_by_email(email) do
    User
    |> where([u], u.email == ^email)
    |> SwiftNews.Repo.one
  end

  def find_by_conn(conn) do
    email = SwiftNews.Guardian.Plug.current_resource(conn)
    find_by_email(email)
  end
end