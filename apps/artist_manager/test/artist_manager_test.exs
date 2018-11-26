defmodule ArtistManagerTest do
  use ExUnit.Case
  doctest ArtistManager

  test "Add and retrieving artist" do
    artist = ArtistManager.add_and_get("Bob Dylan")
    assert artist == "Bob Dylan"
    assert ArtistManager.contains?("Bob Dylan") == true
  end

  describe "Similar artists" do
    test "when adding new artist" do
      ArtistManager.add("American Football")
      assert ArtistManager.get_similar_artists("American Football") == []
    end

    test "when added to existing artist" do
      ArtistManager.add("Title Fight")
      ArtistManager.update_similar_artists("Title Fight", ["Into It, Over It", "Hello Again", "Alex G"])
      assert ArtistManager.get_similar_artists("Title Fight") == ["Into It, Over It", "Hello Again", "Alex G"]
      ArtistManager.update_similar_artists("Title Fight", [])
      assert ArtistManager.get_similar_artists("Title Fight") == ["Into It, Over It", "Hello Again", "Alex G"]
    end

    test "when no artist exists" do
      artists = ArtistManager.get_all()
      ArtistManager.update_similar_artists("Fred Durst", ["Smash Mouth"])
      assert ArtistManager.Stash.get() == artists

    end
  end
end
