defmodule SwiftNewsWeb.StoryControllerTest do
  use SwiftNewsWeb.ConnCase, async: true

  test "create story", %{conn: conn} do
    email_prefix = Ecto.UUID.generate()
    {:ok, user} = create_test_user(email_prefix)
    authenticated_conn = SwiftNews.Guardian.Plug.sign_in(conn, user.email)
    conn =
      authenticated_conn
      |> put_req_header("content-type", "application/json")
      |> post("/story/", "{\"title\":\"test\",\"body\":\"cool stuff\"}")

    assert json_response(conn, 200)
    story = SwiftNews.Story 
            |> SwiftNews.Repo.one 
            |> SwiftNews.Repo.preload(user: :stories)

    assert story.title == "test"
    assert story.body == "cool stuff"
    assert story.user.email == email_prefix <> "@gmail.com"
  end

  test "listing 0 stories", %{conn: conn} do
    conn =
    conn
      |> put_req_header("content-type", "application/json")
      |> get("/stories/")

    assert json_response(conn, 200) == %{
      "stories" => []
    }
  end

  test "listing 1 story", %{conn: conn} do
    email_prefix = Ecto.UUID.generate()    
    {:ok, user} = create_test_user(email_prefix)
    create_conn = build_conn()
    authenticated_conn = SwiftNews.Guardian.Plug.sign_in(create_conn, user.email)
    authenticated_conn
      |> put_req_header("content-type", "application/json")
      |> post("/story/", "{\"title\":\"test\",\"body\":\"cool stuff\"}")
      
    conn =
    conn
      |> put_req_header("content-type", "application/json")
      |> get("/stories/")

    user = %SwiftNews.User{email: "alice@gmail.com", hashed_password: "password"}
    stories = [%SwiftNews.Story{title: "test", body: "cool stuff", user: user}]

    assert json_response(conn, 200) == SwiftNewsWeb.StoryView.render("stories.json", %{stories: stories}) |> Poison.encode! |> Poison.decode!
  end

  defp create_test_user(email_prefix) do
    email = email_prefix <> "@gmail.com"
    password = "password"
    SwiftNews.DataAccess.Users.create(email, password)
  end
end