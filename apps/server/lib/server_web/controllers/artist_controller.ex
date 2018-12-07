defmodule ServerWeb.ArtistController do
  use ServerWeb, :controller

  def similar(conn, %{"id" => artist_id}) do
    sim_artist = artist_id
    |> ArtistLibrary.stocked?()
    |> retrieve_similar_artists(conn, artist_id)
    |> pick_random_artist()

    conn
    |> render(ServerWeb.ArtistsView, "show.json", %{"artist" => sim_artist})
  end

  defp retrieve_similar_artists({:lib_stocked}, _conn, artist_id) do
    {:ok, artists} = ArtistLibrary.checkout_sim_artists(artist_id)

    artists
  end

  defp retrieve_similar_artists({:no_stock}, conn, artist_id) do
    artists = case Spotify.Artist.get_related_artists(conn, artist_id) do
      {:ok, artists} -> artists
    end

    ArtistLibrary.stock_sim_artists(artist_id, artists)
  end

  defp pick_random_artist(artists) do
    artists
    |> Enum.random
  end
end
