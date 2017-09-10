defmodule SwiftNews.User do
  use Ecto.Schema

  schema "users" do
    field :email, :string
    field :password, :string
    field :api_token, :string
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:email, :password, :api_token])
    |> Ecto.Changeset.validate_required([:email, :password, :api_token])
  end
end