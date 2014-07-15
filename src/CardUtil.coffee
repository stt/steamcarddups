
Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

class CardUtil
  constructor: () ->

  @findDuplicateCards: (steamInv, cb) ->
    dups = {}
    dupcards = []
    for key,el of steamInv.rgInventory
      dups[el.classid] = if !dups[el.classid] then 1 else dups[el.classid] + 1
      if dups[el.classid] == 2
        dupcards.push steamInv.rgDescriptions[el.classid+'_'+el.instanceid]
    cb dupcards if cb

  @findGamesWithCards: (steamInv, cb) ->
    games = (el.classid for key,el of steamInv.rgDescriptions).unique()
    cb games if cb


module.exports = CardUtil
