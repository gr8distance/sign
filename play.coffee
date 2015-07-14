puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


for i in [0...100]
	User.create({
		name: "yuu_#{i}",
		email: "yy_#{i}@mail.xom",
		password: User.hash("password"),
		uniq_session_id: User.hash("password")
	})
