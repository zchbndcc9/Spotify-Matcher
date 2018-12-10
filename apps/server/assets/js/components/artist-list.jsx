import React from 'react'
import Artist from './artist';

const ArtistList = ({artists, pickArtist}) => {
  const artistList = artists.map(artist => <Artist key={artist.id} artist={artist} pickArtist={(id) => pickArtist(id)}/>)

  return (
    <div className="container card-columns">{artistList}</div>
  )
}

export default ArtistList