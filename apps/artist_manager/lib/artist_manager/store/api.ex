defmodule ArtistManager.Store do
  use GenServer
  alias ArtistManager.Store.Impl

  @me ArtistManager.Store

  def start_link(user_id) do
    GenServer.start_link(@me, user_id, name: via_tuple(user_id))
  end

  def init(_) do
    {:ok, %Impl{}}
  end

  @doc """
  Taken from https://github.com/amokan/registry_sample/blob/master/lib/registry_sample/account.ex

  Allows a GenServer pid to be stored in the registry that can be referenced
  by a user's id
  """
  defp via_tuple(user_id), do: {:via, Registry, {:store_registry, user_id}}

  @doc """
  Adds shown artist to the artists_shown MapSet

  Returns the updated struct
  """
  @spec add_shown_artist(String, String) :: String
  def add_shown_artist(user_id, artist) do
    GenServer.call(via_tuple(user_id), {:add_shown_artist, artist})
  end

  @doc """
  Retrieves the store of a user

  Returns the store of a given user

  ## Examples

    ```
    iex> ArtistManager.Store("zchbndcc9")
    %ArtistManager.Store.Impl{
      artists_shown: MapSet<[]>
      picked_artists: MapSet<[]>
    }
    ```
  """
  @spec get_store(String) :: %Impl{}
  def get_store(user_id) do
    GenServer.call(via_tuple(user_id), :get_store)
  end

 @doc """
  Picks an artist from the artists that are currently being shown. Moves artist
  from artists shown to picked artists

  Returns struct of MapSets for a given user's store
  """
  @spec pick_artist(String, String) :: String
  def pick_artist(user_id, artist) do
    GenServer.call(via_tuple(user_id), {:pick_artist, artist})
  end

  def handle_call(:get_store, _from, store) do
    {:reply, store, store}
  end

  def handle_call({:pick_artist, artist}, _from, store) do
    new_store = store |> Impl.pick_artist(artist)
    {:reply, new_store, new_store}
  end

  def handle_call({:add_shown_artist, artist}, _from, store) do
    new_store = store |> Impl.add_shown_artist(artist)
    {:reply, new_store, new_store}
  end
end
