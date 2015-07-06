express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()

# GET home page. 
app.get("/", (req, res) ->
	f = req.flash("info")
	

	if req.session.current_user
		
		friends = [1,2,3]
		Post.findAll(where: {user_id: friends},order: [['created_at', 'DESC']],limit: 18).then((posts)->
			res.render("home/index",{
				title: "Aimerthyst",
				flash: f[0],
				current_user: req.session.current_user,
				posts: posts
			})
		)
			
	else
		res.render("home/index",{
			title: "Aimerthyst",
			flash: f[0],
			user: req.session.current_user
		})
)


module.exports = app

