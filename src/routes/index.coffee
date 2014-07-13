
findDuplicateCards = (steamInv, cb) ->
  dups = {}
  dupcards = []
  for key,el of steamInv.rgInventory
    if dups[el.classid]
      dupcards.push steamInv.rgDescriptions[el.classid+'_'+el.instanceid]
    if !dups[el.classid]
      dups[el.classid] = true
  cb dupcards if cb

http_get = (url, cb) ->
  http = require('http')
  #require('fs').readFile "tst.json", (err,data) ->
  http.get require('url').parse(url), (res) ->
    if not /application\/json/.test res.headers['content-type']
      return cb "Error, no such profile?"
    data = ''
    res.on 'data', (chunk) ->
      data += chunk.toString()
    res.on 'end', () ->
      cb null, data

exports.cards = (req, res) ->
  query = require('url').parse(req.url, true).query
  contentType = 'text/plain'

  username = query.username
  invurl = "http://steamcommunity.com/id/#{username}/inventory/json/753/6/"
  http_get invurl, (err, value) ->
    if err
      return res.send 500, err
    json = JSON.parse value
    if json.success == "false"
      res.send 500, json.Error
    else
      findDuplicateCards json, (dups) ->
        res.json(dups).end()
