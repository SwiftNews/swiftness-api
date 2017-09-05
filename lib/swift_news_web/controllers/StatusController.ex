defmodule SwiftNewsWeb.StatusController do
    use SwiftNewsWeb, :controller

    def index(conn, _params) do
        conn |>
            Phoenix.Controller.json(%{"version": "1.0.0"})
    end
end