defmodule ServerWeb.PageController do
  use ServerWeb, :controller
  plug Server.SpotifyAPI.RaiseFlags

  def index(conn, _params) do
    conditions = %{
      tokens?: conn.assigns[:tokens_present?],
      authenticated?: conn.assigns[:authenticated?]
    }

    determine_render(conn, conditions)
  end

  def determine_render(conn, %{tokens?: false}) do
    conn
    |> render("new_user.html", conn: conn)
  end

  def determine_render(conn, %{authenticated?: false}) do
    conn
    |> redirect(external: Spotify.Authorization.url)
  end

  def determine_render(conn, _conditions) do
    conn
    |> render("index.html", conn: conn)
  end
end
