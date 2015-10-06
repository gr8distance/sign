express = require('express')
app = express.Router()
require('../../lib/models')()
_ = require "underscore"

app.get("/",(req,res)->
	v_users = []
	console.log req.current_user
	User.findAll().then((users)->
		_.each(users,(user)->
			unless req.current_user.email == user.dataValues.email
				v_users.push user.dataValues
			console.log v_users
			res.render("friends/index",{
				title: "Friends page",
				users: v_users
			})
		)
	)
)




module.exports = app
