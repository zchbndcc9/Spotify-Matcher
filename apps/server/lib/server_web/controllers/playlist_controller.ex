defmodule ServerWeb.PlaylistController do
  use ServerWeb, :controller
  def create(conn, _params) do
    playlist_uri = conn
    |> PlaylistBuilder.build()

    IO.inspect(playlist_uri)

    conn
    |> render(ServerWeb.PlaylistsView, "show.json", %{"playlist_uri" => playlist_uri})
  end
end
