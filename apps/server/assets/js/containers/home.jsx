import React from 'react'
import axios from 'axios'
import { ArtistList } from '../components/artist-list';

export class Home extends React.Component {
  constructor(props) {
    super(props)
    this.state = { }
  }

  componentDidMount() {
    axios.get("http://localhost:4000").then(result => {

    })
  }

  pickArtist(id) {
    axios.get(`http://localhost:4000/artist/${id}/similar`).then(response => {
      // Swap artist and add to picked artists
    })
  }

  render() {
    return(
      <ArtistList artists={this.state.artists} pickArtist={(id) => this.pickArtist(id)}
    )
  }
}