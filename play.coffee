puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")

Post.findAll(order: "updated_at desc").then((posts)->
	for post in posts
		puts post.dataValues
)
