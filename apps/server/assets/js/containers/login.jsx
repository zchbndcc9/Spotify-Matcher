import React from 'react'
import axios from 'axios';
import { Link } from 'react-dom-router'
export class Login extends React.Component {
  constructor(props) {
    super(props)
  }

  authorizeApp() {
    axios.get("http://localhost:4000/authorize").then()
  }

  render() {
    if
  }
}