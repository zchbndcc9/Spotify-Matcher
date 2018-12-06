import React from 'react'
import { Artist } from './artist';

export const ArtistList = ({artists}) => {
  const artistList = artists.map(artist => <Artist artist={artist}/>)

  return (
    <div>{artistList}</div>
  )
}