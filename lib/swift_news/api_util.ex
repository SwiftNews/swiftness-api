defmodule SwiftNews.ApiUtil do
    import Plug.Conn
    import Phoenix.Controller

    def send_error(conn, status_code, message) do
        conn 
        |> put_status(status_code)
        |> render(SwiftNewsWeb.ErrorView, "error.json", %{message: message})
    end
end