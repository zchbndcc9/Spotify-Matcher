import React from 'react'
import axios from 'axios'
import ArtistList from '../components/artist-list'

class Home extends React.Component {
  constructor(props) {
    super(props)
    this.state = { 
      artists: [], 
      pickedArtists: [],
      songLimit: 10,
      title: "",
      success: false
    }
    this.createPlaylist = this.createPlaylist.bind(this)
    this.onChange = this.onChange.bind(this)
  }

  componentDidMount() {
    axios.get("http://localhost:4000/api/top-artists").then(({status, data: {artists}}) => {
      if(status === 200) {
        this.setState((prevState) => ({
          artists: artists
        }))
      }
    })
  }

  pickArtist(id) {
    axios.get(`http://localhost:4000/api/artists/${id}/similar`).then(({status, data: {artist}}) => {
      if(status === 200) {
        // Swap artist and add to picked artists
        const artistIndex = this.state.artists.findIndex(artist => artist.id === id)
        const pickedArtist = this.state.artists[artistIndex]
  
        console.log(pickedArtist);
        this.setState((prevState) => ({
          artists: [
            ...prevState.artists.slice(0, artistIndex),
            artist,
            ...prevState.artists.slice(artistIndex + 1)
          ],
          pickedArtists: [...prevState.pickedArtists, pickedArtist]
        }))
      }
    })
  }
  
  restart() {
    this.setState((prevState) => ({
      success: false,
      title: "",
      pickedArtists: []
    }))
  }
  createPlaylist(event) {
    event.preventDefault();
    let data = new FormData()
    data = {
      picked_artists: this.state.pickedArtists,
      title: this.state.title,
      song_limit: +this.state.songLimit
    }

    axios.post('http://localhost:4000/api/playlists', data).then(response => {
      this.setState((prevState) => ({success: true}))
    })
  }

  onChange(event) {
    const value = event.target.value;
    const name = event.target.name;

    this.setState({
      [name]: value
    });
  }

  render() {
    const message = this.state.pickedArtists.length < 5 ? "Please pick at least 5 artists" : "Good to go!"
    const successMessage = this.state.success ? (<div>
      <div className="alert alert-success">Playlist successfully created. Check your Spotify</div>
      <button className="btn btn-primary" onClick={() => this.restart()}>Restart</button>
    </div>) : ''

    return(
      <div className="container pt-4">
        <div className="row">
          <div class="col-9"> 
            <h2>{message}</h2>
            <ArtistList artists={this.state.artists} pickArtist={(id) => this.pickArtist(id)} />
          </div>
          <div>
            <h2>Playlist Info</h2>
            <form className="form" onSubmit={this.createPlaylist}>
              <div className="form-group">
                <label htmlFor="title">Playlist Title</label>
                <input id="title" className="form-control" onChange={this.onChange} type="text" name="title" placeholder="My cool playlist" required/>
              </div>
              <div className="form-group">
                <label htmlFor="num-songs">Number of Songs</label>
                <div className="form-check form-check-inline">
                  <label className="form-check-label" htmlFor="input1">10</label>
                  <input className="form-check-input" type="radio" onChange={this.onChange} name="songLimit" id="input1" value="10" required/>
                </div>
                <div className="form-check form-check-inline">
                  <label className="form-check-label" htmlFor="input2">30</label>
                  <input className="form-check-input" type="radio" onChange={this.onChange} name="songLimit" id="input2" value="30" required/>
                </div>
                <div className="form-check form-check-inline">
                  <label className="form-check-label" htmlFor="input3">50</label>
                  <input className="form-check-input" type="radio" onChange={this.onChange} name="songLimit" id="input3" value="50" required/>
                </div>
              </div>
              <button className="btn btn-success" disabled={this.state.pickedArtists.length < 5}>Create playlist</button>
            </form>
            { successMessage }
          </div>
        </div>
      </div>
    )
  }
}

export default Home