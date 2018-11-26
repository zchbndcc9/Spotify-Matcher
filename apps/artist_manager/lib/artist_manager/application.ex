defmodule ArtistManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {ArtistManager.Stash, %{}},
      {ArtistManager.Store, nil}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: ArtistManager.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
