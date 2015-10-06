express = require('express')
app = express.Router()
require('../../lib/models')()

app.get("/login",(req,res)->
	res.render("auth/login",{
		title: "Login authenticate"
	})
)




module.exports = app
