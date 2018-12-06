import React from 'react'
import axios from 'axios'

export class Home extends React.Component {
  constructor(props) {
    super(props)
    this.state = { authenticated: false,  }
  }

  componentDidMount() {
    axios.get("http://localhost:4000").then(result => {

    })
  }
 
  authorizeApp() {
    axios.get("http://localhost:4000/authorize").then({status, data}=> {
      if(status === 500) {
        alert("Oops server error sorry")
      } else {

      }
    })
  }

  render() {
    let pageView = <Home/>;
    if(!authenticated) pageView = <Login/>

    render(pageView)
  }
}