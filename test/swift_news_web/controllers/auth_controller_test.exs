defmodule SwiftNewsWeb.AuthControllerTest do
  use SwiftNewsWeb.ConnCase, async: true

  test "create user", %{conn: conn} do
    conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> post("/user/", "{\"email\":\"alice@gmail.com\",\"password\":\"password\"}")

    assert json_response(conn, 200)
  end

  test "login", %{conn: conn} do
    conn1 =
      build_conn()
      |> put_req_header("content-type", "application/json")
      |> post("/user/", "{\"email\":\"alice@gmail.com\",\"password\":\"password\"}")
      
    assert json_response(conn1, 200)
    
    conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> post("/auth/", "{\"email\":\"alice@gmail.com\",\"password\":\"password\"}")

    assert json_response(conn, 200)
  end
end