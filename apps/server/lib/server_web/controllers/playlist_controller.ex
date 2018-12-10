defmodule ServerWeb.PlaylistController do
  use ServerWeb, :controller
  def create(conn, _params) do
    {:ok, %Spotify.Profile{id: user_id}} = conn |> Spotify.Profile.me()

    data = conn |> Map.fetch!(:params) |> Map.put("user_id", user_id)
    playlist_uri = %Plug.Conn{ conn | params: data }
    |> PlaylistBuilder.build()

    conn
    |> render(ServerWeb.PlaylistsView, "show.json", %{"playlist_uri" => playlist_uri})
  end
end
