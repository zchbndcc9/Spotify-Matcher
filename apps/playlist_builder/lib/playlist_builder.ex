defmodule PlaylistBuilder do
  use DynamicSupervisor

  def build_for(user) do
    {:ok, pid} = DynamicSupervisor.start_child(PlaylistBuilder.Supervisor, child_spec)
  end
end
