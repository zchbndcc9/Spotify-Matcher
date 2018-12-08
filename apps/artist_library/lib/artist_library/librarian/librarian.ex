defmodule ArtistLibrary.Librarian do

  def start_link(_) do

  end

  def checkin_artist(artist) do
    artist
    |> ArtistLibrary.Library.contains?
    |> update_library(artist)
  end

  def checkout_sim_artists(artist) do
    artist
    |> Library.add_and_get()
    |> Library.update_similar_artists(similar_artists)
  end

  def checkout_sim_artist(artist) do
    artist
    |> checkout_sim_artists
    |> Enum.random
  end

  def checkout_sim_artists(artist) do
    case Library.get_similar_artists(artist) do
      nil     -> {:no_stock}
      artists -> {:ok, artists}
    end
  end

  def checkout_sim_artist(artist) do
    case Library.get_similar_artists(artist) do
      nil     -> {:no_stock}
      artists -> {:ok, Enum.random(artists)}
    end
  end
end
