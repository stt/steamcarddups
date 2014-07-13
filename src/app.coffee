http = require 'http'

express = require 'express'
routes  = require './routes'
app     = express()

app.set 'port', process.env.PORT || 3003

app.use(require('morgan')())

app.route('/cards').get routes.cards

app.use(express.static('web'))

app.use (err, req, res, next) ->
  console.error err.stack
  #res.status(500);  res.render('error', { error: err });
  res.send 500, 'Something broke!'

server = http.createServer(app)

server.listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
