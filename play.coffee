puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")

Permit.findAll().then((pp)->
	for p in pp
		p.destroy()
)
Cotery.findAll().then((pp)->
	for p in pp
		p.destroy()
)
