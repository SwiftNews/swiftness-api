defmodule SwiftNewsWeb.UserView do
  use SwiftNewsWeb, :view

  def render("user.json", %{user: user}) do
    %{"email": user.email,
      "id": user.id}
  end
end