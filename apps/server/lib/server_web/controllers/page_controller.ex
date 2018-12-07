defmodule ServerWeb.PageController do
  use ServerWeb, :controller

  def index(conn, params) do
    render(conn, "app.html")
  end
end
