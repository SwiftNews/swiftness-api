defmodule SwiftNewsWeb.AuthControllerTest do
  use SwiftNewsWeb.ConnCase, async: true

  test "create user", %{conn: conn} do
    conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> post("/user/", "{\"email\":\"alice@gmail.com\",\"password\":\"password\"}")

    assert json_response(conn, 200)
  end

  test "create user empty email", %{conn: conn} do
    conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> post("/user/", "{\"email\":\"\",\"password\":\"password\"}")

    assert json_response(conn, 400)
  end

  test "create user invalid email", %{conn: conn} do
    conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> post("/user/", "{\"email\":\"alice\",\"password\":\"password\"}")

    assert json_response(conn, 400)
  end

  test "create user empty password", %{conn: conn} do
    conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> post("/user/", "{\"email\":\"alice@gmail.com\",\"password\":\"\"}")

    assert json_response(conn, 400)
  end

  test "create multiple users with same email", %{conn: conn} do
    conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> post("/user/", "{\"email\":\"alice@gmail.com\",\"password\":\"password\"}")

    assert json_response(conn, 200)

    conn1 =
      build_conn()
      |> put_req_header("content-type", "application/json")
      |> post("/user/", "{\"email\":\"alice@gmail.com\",\"password\":\"password\"}")
      
    assert json_response(conn1, 400)
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

  test "login invalid email", %{conn: conn} do
    conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> post("/auth/", "{\"email\":\"bob@gmail.com\",\"password\":\"password\"}")

    assert json_response(conn, 400)
  end

  test "login invalid password", %{conn: conn} do
    conn1 =
      build_conn()
      |> put_req_header("content-type", "application/json")
      |> post("/user/", "{\"email\":\"alice@gmail.com\",\"password\":\"password\"}")
      
    assert json_response(conn1, 200)
    
    conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> post("/auth/", "{\"email\":\"alice@gmail.com\",\"password\":\"wordpass\"}")

    assert json_response(conn, 401)
  end
end