require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")

Cotery.findAll().then((coteries)->
	for cotery in coteries
		cotery.destroy()
)
