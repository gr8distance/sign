puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


for i in [0...100]
	Post.create({
		body: "hello _ #{i}",
		user_id: 4,
		user_name: "USER"
	})

#Talk.findAll(order: "updated_at desc").then((talks)->
#	for i in talks
#		puts i.dataValues
#)
#Notification.findAll().then((ns)->
#	for i in ns
#		console.log i.dataValues
#)
#
#Permit.findAll(order: "updated_at desc").then((ps)->
#	puts "Permit"
#	for i in ps
#		console.log i.dataValues
#)


