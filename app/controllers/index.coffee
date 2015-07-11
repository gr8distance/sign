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
		
		#まずは友達のIDを取得して配列に格納する
		user.getFriends().then((friends)->
			v_friends = [user.dataValues.id]
			for friend in friends
				v_friends.push friend.dataValues.friend_id
			
			#配列に格納した友達のIDを元にすべてのPostモデルから自分と友達の投稿を取得する
			Post.findAll(where:{user_id: v_friends},order: "updated_at desc",limit: 18).then((posts)->
				for post in posts
					v_posts.push post.dataValues
				
				#ビューを生成していろいろなデータを送り込む
				res.render("home/index",{
					title: "Aimerthyst:ホーム",
					flash: req.flash("info")[0],
					current_user: req.session.current_user,
					posts: v_posts,
					btn: "home",
					friends_id: v_friends
				})
			).catch((err)->
				console.log err
				req.flash("info","表示関連でなにかのエラーが発生しました(・∀・):")
				res.redirect("/")
			)
		)
	else
		v_posts = []
		res.render("home/index",{
			posts: v_posts,
			title: "Aimerthyst:ホーム",
			flash: req.flash("info")[0],
		})

)


module.exports = app

