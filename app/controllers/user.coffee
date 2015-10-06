express = require('express')
app = express.Router()
require('../../lib/models')()

app.get("/setting/:email/:token",(req,res)->
	para = req.params
	User.findOne(where: {email: para.email, token: para.token}).then((user)->
		if user?
			res.render("user/setting",{
				title: "Setting!",
				user: user.dataValues
			})
		else
			res.redirect "/"
	)
)




module.exports = app
