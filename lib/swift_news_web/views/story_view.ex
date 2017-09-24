defmodule SwiftNewsWeb.StoryView do
  use SwiftNewsWeb, :view

  def render("story.json", %{story: story}) do
    %{
      "story": story_json(story)
    }
  end

  def render("stories.json", %{stories: stories}) do
    %{
      "stories": stories 
                  |> Enum.map(&story_json/1)
    }
  end

  defp story_json(story) do
    %{ 
      "title": story.title,
      "body": story.body
    }
  end
end
