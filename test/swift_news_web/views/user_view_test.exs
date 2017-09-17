defmodule SwiftNewsWeb.UserViewTest do
  use SwiftNewsWeb.ConnCase, async: true

  test "user.json" do
    user = %SwiftNews.User{email: "alice@gmail.com", hashed_password: "password", id: 1}

    rendered_user = SwiftNewsWeb.UserView.render("user.json", %{user: user})

    assert rendered_user == %{"email": "alice@gmail.com", "id": 1}
  end
end
