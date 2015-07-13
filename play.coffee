require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


Cotery.findById(3).then((cotery)->
	console.log cotery.dataValues
)
