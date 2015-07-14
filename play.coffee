puts = (s)->
	console.log s

require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


Post.findById(153).then((post)->
	post.getComments().then((comments)->
		console.log comments.length
		for comment in comments
			console.log comment.destroy()
	)
)
