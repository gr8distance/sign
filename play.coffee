puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


Permit.findAll().then((pp)->
	for p in pp
		puts p.dataValues
)
