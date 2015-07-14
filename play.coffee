puts = (s)->
	console.log s

require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")

Friend.findAll().then((friends)->
	for friend in friends
		friend.destroy()
)
