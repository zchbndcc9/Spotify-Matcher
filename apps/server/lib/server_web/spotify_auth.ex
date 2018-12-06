defmodule SpotifyAPI.Auth.Plug do
  import Plug.Conn

  def init(default), do: default

  def call(conn, default) do
    authenticate(conn, default)
  end

  defp authenticate(conn, _) do
    case Spotify.Authentication.authenticated?(conn) do
      {:ok, conn} ->
        conn |> halt()
      _ ->
        conn |> refresh_tokens()
    end
  end

  defp refresh_tokens(conn) do
    case Spotify.Authentication.refresh(conn) do
      {:ok, new_conn} -> new_conn
      :unauthorized ->
        conn
        |> Phoenix.Controller.render("new_user.html")
        |> halt()
    end
  end
end
