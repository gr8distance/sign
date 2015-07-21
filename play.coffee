puts = (s)->
	console.log s
require("./lib/models")()
_ = require("underscore")
eimg = require("easyimage")


for i in [0...100]
	User.create({
		name: "user_#{i}",
		email: "mail#{i}@mail.com",
		password: "password",
		uniq_session_id: "ghsio rhi bhaeoishgalidhsdb ierhg"
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


