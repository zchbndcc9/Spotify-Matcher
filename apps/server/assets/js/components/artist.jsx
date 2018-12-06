import React from 'react'

export const Artist = ({name, id, img}) => (
  <div id={id}>
    <img src={img} alt={img}/>
    <h1>{name}</h1>
  </div>
)