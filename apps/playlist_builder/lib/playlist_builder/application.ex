defmodule PlaylistBuilder.Application do
  use Application

  def start(_type, _args) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: PLaylistBuilder.DynamicSupervisor}
    ]

    opts = [strategy: :one_for_one, name: PlaylistBuilder.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
