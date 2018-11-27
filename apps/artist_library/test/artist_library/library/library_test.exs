defmodule ArtistLibrary.Library.Test do
  use ExUnit.Case
  doctest ArtistLibrary.Library

  test "Add and retrieving artist" do
    artist = ArtistLibrary.Library.add_and_get("Bob Dylan")
    assert artist == "Bob Dylan"
    assert ArtistLibrary.Library.contains?("Bob Dylan") == true
  end

  describe "Similar artists" do
    test "when adding new artist" do
      ArtistLibrary.Library.add("American Football")
      assert ArtistLibrary.Library.get_similar_artists("American Football") == []
    end

    test "when added to existing artist" do
      ArtistLibrary.Library.add("Title Fight")
      ArtistLibrary.Library.update_similar_artists("Title Fight", ["Into It, Over It", "Hello Again", "Alex G"])
      assert ArtistLibrary.Library.get_similar_artists("Title Fight") == ["Into It, Over It", "Hello Again", "Alex G"]
      ArtistLibrary.Library.update_similar_artists("Title Fight", [])
      assert ArtistLibrary.Library.get_similar_artists("Title Fight") == ["Into It, Over It", "Hello Again", "Alex G"]
    end

    test "when no artist exists" do
      artists = ArtistLibrary.Library.get_all()
      ArtistLibrary.Library.update_similar_artists("Fred Durst", ["Smash Mouth"])
      :timer.sleep(20)
      assert ArtistLibrary.Library.get_all() == artists
    end
  end
end
