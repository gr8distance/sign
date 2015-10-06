express = require('express')
app = express.Router()
require('../../lib/models')()

app.get("/",(req,res)->
	
	res.render("friends/index",{
		title: "友達を検索"
	})
)




module.exports = app
