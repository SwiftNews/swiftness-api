defmodule SwiftNews.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :hashed_password, :string
    end

    create index(:users, [:email], unique: true)
  end
end
