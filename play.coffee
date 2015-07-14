puts = (s)->
	console.log s

require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")

dd = new Date()
Post.findAll().then((posts)->
	for i in posts
		console.log i.id
)
