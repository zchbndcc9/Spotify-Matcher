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
    |> ArtistLibrary.Library.get_similar_artists
  end

  def checkout_sim_artist(artist) do
    artist
    |> checkout_sim_artists
    |> Enum.random
  end

  def exchange_artist(artist) do
    artist
    |> checkin_artist()
    |> checkout_sim_artist()
  end

  defp update_library(true, artist) do
    artist
  end

  defp update_library(false, artist) do
    artist
    |> ArtistLibrary.Library.add_and_get()
    |> order_similar_artists()
    |> await_delivery()
    |> stock_shelves()
  end

  defp await_delivery(artist) do
    artist
  end

  defp order_similar_artists(artist) do
    artist
  end

  defp stock_shelves(artist) do
    artist
  end
end
