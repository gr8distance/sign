puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


User.findAll().then((users)->
	for i in users
		console.log i.dataValues
)

