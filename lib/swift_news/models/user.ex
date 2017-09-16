defmodule SwiftNews.User do
  use Ecto.Schema

  schema "users" do
    field :email, :string
    field :password, :string
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:email, :password])
    |> Ecto.Changeset.validate_required([:email, :password])
  end
end