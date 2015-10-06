puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")

User.findAll().then((users)->
	_.each(users,(user)->
		puts user.dataValues
	)
)
