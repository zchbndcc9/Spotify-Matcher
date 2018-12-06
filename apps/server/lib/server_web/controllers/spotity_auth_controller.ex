defmodule ServerWeb.SpotifyAuthController do
  use ServerWeb, :controller

  def authorize(conn, _params) do
    conn
    |> redirect(external: Spotify.Authorization.url)
  end

  def authenticate(conn, params) do
    case Spotify.Authentication.authenticate(conn, params) do
      {:ok, conn} -> conn |> Plug.Conn.send_resp(200, "authorized")
    end
  end
end
