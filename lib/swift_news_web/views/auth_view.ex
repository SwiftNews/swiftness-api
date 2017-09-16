defmodule SwiftNewsWeb.AuthView do
  use SwiftNewsWeb, :view
  alias SwiftNewsWeb.UserView

  def render("auth.json", %{jwt: jwt, user: user}) do
    %{"jwt": jwt, 
      "user": render_one(user, UserView, "user.json")}
  end
end
