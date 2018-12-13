defmodule ArtistManagerTest do
  use ExUnit.Case
  doctest ArtistManager

  test "greets the world" do
    assert ArtistManager.hello() == :world
  end
end
