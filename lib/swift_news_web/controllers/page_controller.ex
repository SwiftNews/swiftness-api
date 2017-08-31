defmodule SwiftNewsWeb.PageController do
  use SwiftNewsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
