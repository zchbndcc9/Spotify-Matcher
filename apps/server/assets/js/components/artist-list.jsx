import React from 'react'
import { Artist } from './artist';

export const ArtistList = ({artists, pickArtist}) => {
  const artistList = artists.map(artist => <Artist artist={artist} pickArtist={(id) => pickArtist(id)/>)

  return (
    <div>{artistList}</div>
  )
}