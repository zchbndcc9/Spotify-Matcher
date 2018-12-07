defmodule ArtistLibrary do
  alias ArtistLibrary.Librarian

  defdelegate stocked?(artist),                       to: Librarian
  defdelegate checkout_sim_artists(artist),           to: Librarian
  defdelegate stock_sim_artists(artist, sim_artists), to: Librarian

end
