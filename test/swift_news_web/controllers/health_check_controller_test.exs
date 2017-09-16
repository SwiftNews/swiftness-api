defmodule SwiftNewsWeb.HealthCheckControllerTest do
  use SwiftNewsWeb.ConnCase, async: true

  test "index", %{conn: conn} do
    conn = get conn, "/"
    assert json_response(conn, 200) == %{"version" => "1.0.0"}
  end
end