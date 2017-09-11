defmodule SwiftNewsWeb.UserController do
    use SwiftNewsWeb, :controller

    def create(conn, %{"email" => email,
                    "password" => password}) do
        hashed_password = SwiftNews.Authentication.hash_password(password)
        changeset = SwiftNews.User.changeset(%SwiftNews.User{}, %{email: email, password: hashed_password, api_token: "test"})
        case SwiftNews.Repo.insert(changeset) do
        {:ok, person} ->
            conn |>
                json("success")
        {:error, changeset} ->
            conn |>
                json("failure")
        end
    end
end