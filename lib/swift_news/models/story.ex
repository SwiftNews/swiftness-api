defmodule SwiftNews.Story do
  use Ecto.Schema

  import Ecto.Changeset

  schema "stories" do
    field :title, :string
    field :body, :string
    belongs_to :user, SwiftNews.User
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
  end
end