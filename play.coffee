puts = (s)->
	console.log s

require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")

Blog.findAll().then((blogs)->
	for i in blogs
		console.log i.dataValues
)
