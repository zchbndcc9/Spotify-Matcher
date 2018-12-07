import React from 'react'

export const Artist = ({name, id, img}) => (
  <div>
    <img src={img.url} alt={img.url}/>
    <h1>{name}</h1>
  </div>
)