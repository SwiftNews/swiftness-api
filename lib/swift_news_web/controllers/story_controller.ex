defmodule SwiftNewsWeb.StoryController do
  use SwiftNewsWeb, :controller

  import SwiftNews.ApiUtil

  alias SwiftNews.Story

  require Logger

  def create(conn, %{"title" => title,
                  "body" => body}) do
    user = SwiftNews.DataAccess.Users.find_by_conn(conn) 

    if is_nil(user) do
      conn |> send_error(401, "Not authorized") 
    else 
      story = Ecto.build_assoc(user, :stories, %{title: title, body: body, user: user})
      case SwiftNews.Repo.insert(story) do
      {:ok, _story} ->
        conn |> json("success")

      {:error, _} ->
        conn |> send_error(400, "SOMETHING WENT WROOOOONG")
      end
    end
  end
end