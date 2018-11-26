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

  def determine_render(conn, flags = %{authenticated?: false}) do
    case Spotify.Authentication.refresh(conn) do
      {:ok, conn} -> determine_render(conn, %{flags | authenticated?: true})
    end
  end

  def determine_render(conn, %{tokens?: false}) do
    conn
    |> render("new_user.html", conn: conn)
  end

  def determine_render(conn, _conditions) do
    artists = conn
    |> Server.SpotifyAPI.get_artists

    render conn, "index.html", artists: artists
  end
end
