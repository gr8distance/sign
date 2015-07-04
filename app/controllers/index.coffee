express = require("express")
app = express.Router()
require("../../lib/models")()

# GET home page. 
app.get("/", (req, res) ->
	f = req.flash("info")
	
	res.render("home/index",{
		title: "Aimerthyst",
		flash: f[0],
		user: req.session.user
	})
)


module.exports = app

