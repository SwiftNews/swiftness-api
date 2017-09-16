defmodule SwiftNewsWeb.AuthViewTest do
  use SwiftNewsWeb.ConnCase, async: true

  test "auth.json" do
    user = %SwiftNews.User{email: "alice@gmail.com", password: "password"}

    rendered_user = SwiftNewsWeb.UserView.render("user.json", %{user: user})
    rendered_auth_response = SwiftNewsWeb.AuthView.render("auth.json", %{jwt: "test", user: user})

    assert rendered_auth_response == %{
      "jwt": "test",
      "user": rendered_user
    }
  end
end
