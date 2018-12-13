defmodule ArtistManager.StoreSupervisor do
  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  @doc """
  Creates a store for a given user and stores the pid in Registry

  Returns error if process already exists for a given user
  """
  def create_store(user_id) do
    spec = {ArtistManager.Store, user_id}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end


  @doc """
  Restarts a store if it has already been started.

  If store for user has not been started, a store will be initialized
  """
  def restart_store(user_id) do
    case Registry.lookup(:store_registry, user_id) do
      [{pid, _}] -> DynamicSupervisor.terminate_child(__MODULE__, pid)
      _ -> nil
    end

    create_store(user_id)
  end
end
