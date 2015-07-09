express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()


# GET home page. 
app.get("/", (req, res) ->
	if req.session.current_user?
		console.log "(；・∀・)#{req.session.current_user}"

	res.render("home/index",{
		title: "Aimerthyst:ホーム",
		flash: req.flash("info")[0],
		current_user: req.session.current_user
	})
)


module.exports = app

