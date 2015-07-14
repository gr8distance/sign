puts = (s)->
	console.log s

require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")

for i in [0...1000]
	Post.create({
		user_id: 1,
		user_name: "UG",
		body: "POST_#{i}"
	})
