defmodule ArtistManager.StoreSupervisor do
  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def create_store(user_id) do
    spec = {ArtistManager.Store, user_id}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
