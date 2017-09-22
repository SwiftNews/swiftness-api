defmodule SwiftNews.Repo.Migrations.CreateStory do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string
      add :body, :string
      add :user_id, references(:users)
    end

    create index(:stories, [:user_id])
  end
end
