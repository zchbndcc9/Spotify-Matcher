defmodule Server.SpotifyAPI do
  def get_artists(conn) do
    {_status, %Paging{items: artists}} = conn
    |> Spotify.Personalization.top_artists

    artists
  end
end
