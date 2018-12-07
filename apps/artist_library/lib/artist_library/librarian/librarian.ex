defmodule ArtistLibrary.Librarian do
  alias ArtistLibrary.Library

  def start_link(_) do

  end

  def stock_sim_artists(artist, similar_artists) do
    artist
    |> Library.update_similar_artists(similar_artists)
  end

  def stocked?(artist) do
    case Library.contains?(artist) do
      true  -> {:lib_stocked}
      false -> {:no_stock}
    end
  end

  def checkout_sim_artists(artist) do
    case Library.get_similar_artists(artist) do
      artists -> {:ok, artists}
      nil     -> {:no_stock}
    end
  end

  def checkout_sim_artist(artist) do
    case Library.get_similar_artists(artist) do
      artists -> {:ok, Enum.random(artists)}
      nil     -> {:no_stock}
    end
  end
end
