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

  # Taken from https://github.com/amokan/registry_sample/blob/master/lib/registry_sample/account.ex
  defp via_tuple(user_id), do: {:via, Registry, {:store_registry, user_id}}

  def add_shown_artist(user_id, artist) do
    GenServer.cast(via_tuple(user_id), {:add_shown_artist, artist})
  end
  def get_store(user_id) do
    GenServer.call(via_tuple(user_id), :get_store)
  end

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

  def handle_cast({:add_shown_artist, artist}, store) do
    {:noreply, Impl.add_shown_artist(store, artist)}
  end
end
