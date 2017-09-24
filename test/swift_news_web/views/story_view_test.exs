defmodule SwiftNewsWeb.StoryViewTest do
  use SwiftNewsWeb.ConnCase, async: true

  test "rendering a single story" do
    user = %SwiftNews.User{email: "alice@gmail.com", hashed_password: "password"}
    story = %SwiftNews.Story{title: "cool story bro", body: "my body is ready", user: user}

    rendered_story = SwiftNewsWeb.StoryView.render("story.json", %{story: story})

    assert rendered_story == %{
      "story": %{
        "title": "cool story bro",
        "body": "my body is ready"
      }
    }
  end

  test "rendering a list of stories" do
    user = %SwiftNews.User{email: "alice@gmail.com", hashed_password: "password"}
    stories = [%SwiftNews.Story{title: "cool story bro", body: "test body", user: user}]

    rendered_story = SwiftNewsWeb.StoryView.render("stories.json", %{stories: stories})

    assert rendered_story == %{
      "stories": [%{
        "title": "cool story bro",
        "body": "test body"
      }]
    }
  end
end
