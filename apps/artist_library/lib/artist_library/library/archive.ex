defmodule ArtistLibrary.Archive do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def update(saved_state) do
    GenServer.cast(__MODULE__, {:update, saved_state})
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:update, saved_state}, _state) do
    {:noreply, saved_state}
  end

  def handle_call(:get, _from, saved_state) do
    {:reply, saved_state, saved_state}
  end
end
