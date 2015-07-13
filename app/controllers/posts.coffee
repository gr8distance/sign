express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()


app.get("/:id",(req,res)->
	id = req.params.id
	Post.findById(id).then((post)->
		post.getUser().then((user)->
			post.user = user.dataValues
			res.render("posts/show",{
				post:	post,
				current_user: req.session.current_user
			})
		)
	).catch((err)->
		console.log err
		req.flash("info","投稿が見つかりません(´・ω・`)`)")
		res.redirect("/")
	)
)

app.post("/more",(req,res)->
	PAGE_NUM = 18
	id = req.body.page_id
	user_id = req.session.current_user.id
	next_page = PAGE_NUM * id
	User.findById(user_id).then((user)->
		user.getFriends().then((friends)->
			v_friends = [user.dataValues.id]
			for f in friends
				v_friends.push f.friend_id
			Post.findAll(where: {user_id: v_friends},offset: (PAGE_NUM*id),limit: PAGE_NUM,order: "updated_at desc").then((posts)->
				v_posts = []
				for post in posts
					v_posts.push post.dataValues
				res.json(posts)
			)
		)
	)
)

module.exports = app
