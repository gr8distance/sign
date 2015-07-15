puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


User.findById(1).then((user)->
	user.getNotifications().then((notifications)->
		for i in notifications
			puts i.dataValues
	)
)

