puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


User.findById(3).then((user)->
	u = user
	console.log u.dataValues

	u.getFriends().then((fs)->
		for f in fs
			puts f.dataValues
	)
)
