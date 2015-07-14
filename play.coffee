require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


User.findAll().then((users)->
	for user in users
		console.log user.dataValues
)
