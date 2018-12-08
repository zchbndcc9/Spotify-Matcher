defmodule ArtistLibrary.Library do
  use GenServer
  @me ArtistLibrary.Library.Server

  def start_link(stash) do
    GenServer.start_link(@me, stash, name: @me)
  end

  def init(_) do
    {:ok, ArtistLibrary.Archive.get()}
  end

  @spec add(String) :: :ok
  def add(artist) do
    GenServer.cast(@me, {:add, artist})
  end

  @spec update_similar_artists(String, list(String)) :: :ok
  def update_similar_artists(artist, similar_artists) do
    GenServer.call(@me, {:update_similar_artists, artist, similar_artists})
  end

  @spec get_similar_artists(String) :: list(String)
  def get_similar_artists(artist) do
    GenServer.call(@me, {:get_similar_artists, artist})
  end

  @spec add_and_get(String) :: String
  def add_and_get(artist) do
    GenServer.call(@me, {:add_and_get, artist})
  end

  @spec similar_artists?(String) :: boolean()
  def similar_artists?(artist) do
    GenServer.call(@me, {:contains_similar?, artist})
  end

  @spec contains?(String) :: boolean()
  def contains?(artist) do
    GenServer.call(@me, {:contains?, artist})
  end

  @spec get_all() :: any()
  def get_all() do
    GenServer.call(@me, :get_all)
  end
end
