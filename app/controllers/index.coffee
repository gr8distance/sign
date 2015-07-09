express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()
u = require("util")


# GET home page. 
app.get("/", (req, res) ->
	if req.session.current_user?
		user = req.session.current_user
		v_posts = []
		friends = [user.dataValues.id]

		Post.findAll(where:{user_id: friends},order: "updated_at desc").then((posts)->
			for post in posts
				v_posts.push post.dataValues


			res.render("home/index",{
				title: "Aimerthyst:ホーム",
				flash: req.flash("info")[0],
				current_user: req.session.current_user,
				posts: v_posts
			})
		).catch((err)->
			console.log err
			req.flash("info","表示関連でなにかのエラーが発生しました(・∀・):")
			res.redirect("/")
		)
	else

		res.render("home/index",{
			title: "Aimerthyst:ホーム",
			flash: req.flash("info")[0],
		})

)


module.exports = app

