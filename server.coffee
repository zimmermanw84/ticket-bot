# Deeps
express = require 'express'
bodyParser = require 'body-parser'
app = express()

# app port
PORT = process.env.PORT or 3000

# request parser
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: true

# logger
require('console-stamp')(console, pattern: "dd/mm/yyyy HH:MM:ss.l")

# naive auth
app.use require "./lib/auth"

# log reqests
app.use (req, res, next) ->
  console.log "[#{req.method}] - Host: #{req.headers.host}"
  next()

# routes
app.use "/", require "./routes/index"

# catch all
app.use (req, res, next) ->
  err = new Error "Not Found"
  err.status = 404
  next err

# sends out dirty error right to slack output XD
app.use (err, req, res, next) ->
  res.status = err.status or 500
  res.json text: err.message

app.listen PORT, (req, res, next) ->
  console.log "Ticket Bot running on port #{PORT}"

module.exports = app