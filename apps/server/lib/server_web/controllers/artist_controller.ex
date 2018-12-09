defmodule ServerWeb.ArtistController do
  use ServerWeb, :controller

  def similar(conn, %{"id" => artist_id}) do
    {:ok, %Spotify.Profile{id: user_id}} = Spotify.Profile.me(conn)
    related_artists = case Spotify.Artist.get_related_artists(conn, artist_id) do
      {:ok, artists} -> artists
    end

    ArtistManager.pick_artist(user_id, artist_id)

    %ArtistManager.Store.Impl{ artists_showing: showing, picked_artists: picked } = ArtistManager.get_store(user_id)

    rec_artist_id = related_artists
    |> Enum.map(fn %Spotify.Artist{ id: id } -> id end)
    |> get_unique_recs(showing, picked)
    |> Enum.random

    ArtistManager.add_shown_artist(user_id, rec_artist_id)

    recommended_artist = related_artists
    |> Enum.find(fn %Spotify.Artist{ id: id } -> id === rec_artist_id end)

    conn
    |> render(ServerWeb.ArtistsView, "show.json", %{"artist" => recommended_artist})
  end

  defp get_unique_recs(related_artists, artists_showing, picked_artists) do
    related_artists
    |> MapSet.new
    |> MapSet.difference(picked_artists)
    |> MapSet.difference(artists_showing)
    |> MapSet.to_list
  end
end
