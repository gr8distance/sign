express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()
u = require("util")


# GET home page. 
app.get("/", (req, res) ->
	console.log "#{}"
	res.render("home/index",{
		title: "Signal"
	})
)


module.exports = app

