require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")

Post.findById(12).then((post)->
	console.log post.dataValues
)
