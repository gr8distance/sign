puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")

Song.findAll().then((songs)->
	for song in songs
		song.destroy()
)
