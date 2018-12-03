defmodule ServerWeb.PageController do
  use ServerWeb, :controller

  plug :authenticate

  def index(conn, _params) do
    artists = conn
    |> Server.SpotifyAPI.get_artists()

    render(conn, "index.html", artists: artists)
  end

  defp authenticate(conn, _) do
    case Spotify.Authentication.authenticated?(conn) do
      {:ok, conn} ->
        conn
        |> halt()
      _ ->
        conn
        |> refresh_tokens()
    end
  end

  defp refresh_tokens(conn) do
    case Spotify.Authentication.refresh(conn) do
      {:ok, new_conn} -> new_conn
      :unauthorized ->
        conn
        |> render("new_user.html")
        |> halt()
    end
  end
end
