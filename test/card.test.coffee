CardUtil = require '../src/CardUtil'

process.on 'uncaughtException', (err) ->
  console.error(err.stack)

tstJson = {
  "rgInventory": {
    "1": { "classid": 123, "instanceid": 4 },
    "2": { "classid": 123, "instanceid": 4 },
    "3": { "classid": 456, "instanceid": 7 }
  },
  "rgDescriptions": {
    "123_4": {
      "classid": 123,
      "name": "testikortti"
    },
    "456_7": {
      "classid": 456,
      "name": "testikortti 2"
    }
  }
}

exports.CardTest =
  'test that duplicates are found': (test) ->
    CardUtil.findDuplicateCards tstJson, (dups) ->
      test.equal(dups.length, 1)
      test.done()

  'test that games are found': (test) ->
    CardUtil.findGamesWithCards tstJson, (games) ->
      test.equal(games.length, 2)
      test.done()
      
