puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


Notification.findAll().then((notifs)->
	for n in notifs
		n.destroy()
		console.log n.dataValues
)
