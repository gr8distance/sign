require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


Post.findAll(where: {id: [1,2]}, order: "updated_at desc").then((posts)->
	for post in posts
		console.log post.dataValues
)
