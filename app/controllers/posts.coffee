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

app.post("/:id/edit",(req,res)->
	data = req.body
	
	req.flash("info","投稿を編集しました")
	res.redirect "/"
)

app.post("/:id/delete",(req,res)->
	id = req.body.post_id
	Post.findById(id).then((post)->
		post.destroy()
		#req.flash("info","投稿を削除しました")
		#res.redirect("/")
		data = {state: true,id: id,flash:"投稿を削除しました"}
		res.json data
	).catch((e)->
		console.log e
		#req.flash("info","投稿を削除できませんでした(´・ω・｀)")
		#res.redirect("/")
		data = {state: false,flash:"削除に失敗しました(´・ω・｀)"}
		res.json data
	)
)

##トップページで表示分以上のカードを取得するためのコード
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
