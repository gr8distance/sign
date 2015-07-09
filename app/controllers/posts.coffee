express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()


#app.get("/:id",(req,res)->
#	id = req.params.id
#	Post.findById(id).then((post)->
#		post.getUser().then((user)->
#			post.user = user.dataValues
#			res.render("posts/show",{
#				post:	post,
#				current_user: req.session.current_user
#			})
#		)
#	).catch((err)->
#		console.log err
#		req.flash("info","投稿が見つかりません(´・ω・`)`)")
#		res.redirect("/")
#	)
#)


module.exports = app
