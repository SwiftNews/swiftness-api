defmodule SwiftNewsWeb.StatusController do
    use SwiftNewsWeb, :controller

    def index(conn, _params) do
        conn |>
            json(%{"version": "1.0.0"})
    end
end