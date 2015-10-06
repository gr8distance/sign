puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")

User.findAll(where: {
	name: "UG",
	email: "suzaku622@gmail.com",
	token: "722379201cb43e43fd2906d569bb691f953413d0ff1d6f5d80dfcaf156d64f4a"
}).then((users)->
	_.each(users,(user)->
		puts user.dataValues
	)
)
