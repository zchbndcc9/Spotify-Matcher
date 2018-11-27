defmodule ArtistLibrary.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {ArtistLibrary.Archive, %{}},
      {ArtistLibrary.Library, nil}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: ArtistLibrary.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
