defmodule ArtistManager.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: :store_registry},
      {DynamicSupervisor, name: ArtistManager.StoreSupervisor, strategy: :one_for_one},
    ]

    opts = [strategy: :one_for_one, name: ArtistManager.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
