express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()


app.get("/:id",(req,res)->
	id = req.params.id
	Post.findById(id).then((post)->
		post.getComments().then((comments)->
			v_comments = []
			for comment in comments
				v_comments.push comment.dataValues

			post.getUser().then((user)->
				post.user = user.dataValues
				res.render("posts/show",{
					post:	post,
					current_user: req.session.current_user,
					room_id: User.hash("posts_#{id}"),
					comments: v_comments
				})
			)
		).catch((e)->
			console.log e
			req.flash "info","コメントの取得に失敗しました"
			res.redirect "/posts/#{id}"
		)
	).catch((err)->
		console.log err
		req.flash("info","投稿が見つかりません(´・ω・`)`)")
		res.redirect("/")
	)
)

app.get("/:id/edit",(req,res)->
	id = req.params.id
	data = req.body

	if req.session.current_user?
		Post.findById(id).then((post)->

			res.render("posts/edit",{
				current_user: req.session.current_user,
				post: post.dataValues
			})
		).catch((err)->
			console.log err
			req.flash("info","投稿編集中にエラーが発生しました")
			res.redirect "/"
		)
	else
		req.flash "info","投稿を編集するにはログインしている必要があります"
		res.redirect "/"
)



app.post("/:id/delete",(req,res)->
	data = req.body
	console.log data

	Post.findById(parseInt(data.post)).then((post)->
		post.destroy()
		data = {state: true,id: data.post,flash:"投稿を削除しました"}
		res.json data
	).catch((e)->
		console.log e
		data = {state: false,flash:"削除に失敗しました(´・ω・｀)"}
		res.json data
	)
)

##トップページで表示分以上のカードを取得するためのコード
app.post("/more",(req,res)->
	console.log "START"

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

app.post("/:id",(req,res)->
	data = req.body
	id = req.params.id

	Post.findById(id).then((post)->
		post.updateAttributes(data)
		req.flash("info","投稿を編集しました")
		res.redirect "/"
	)
)

module.exports = app
