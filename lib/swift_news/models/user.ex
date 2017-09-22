defmodule SwiftNews.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true
    has_many :stories, SwiftNews.Story
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :hashed_password, :password])
    |> validate_required([:email, :hashed_password, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 3)
    |> unique_constraint(:email)
  end
end