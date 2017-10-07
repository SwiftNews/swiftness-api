defmodule SwiftNewsWeb.StoryController do
  use SwiftNewsWeb, :controller

  import SwiftNews.ApiUtil

  require Logger

  def index(conn, _params) do
    stories = SwiftNews.Story
              |> SwiftNews.Repo.all
    conn
    |> render(SwiftNewsWeb.StoryView, "stories.json", %{stories: stories})
  end

  def create(conn, %{"title" => title,
                  "body" => body}) do
    user = SwiftNews.DataAccess.Users.find_by_conn(conn) 

    if is_nil(user) do
      conn 
      |> send_error(401, "Not authorized") 
    else 
      story = Ecto.build_assoc(user, :stories, %{title: title, body: body, user: user})
      case SwiftNews.Repo.insert(story) do
      {:ok, _story} ->
        conn 
        |> json("success")

      {:error, changeset} ->
        conn 
        |> put_status(400)
        |> render(SwiftNewsWeb.ErrorView, "error.json", %{changeset: changeset})
      end
    end
  end
end