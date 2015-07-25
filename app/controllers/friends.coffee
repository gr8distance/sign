express = require('express')
app = express.Router()
require('../../lib/models')()
mailer = require("../../mailer")

#他のユーザー一覧を表示するためのアクション
app.get("/",(req,res)->
	current_user = req.session.current_user
	if current_user?
		current_user.getFriends().then((friends)->
			#自分の友だちのIDをGETする
			v_friends = [current_user.id]
			for friend in friends
				v_friends.push friend.dataValues.friend_id
		
			User.findAll(where: {id: v_friends}).then((my_friends)->
				m_friends = []
				for i in my_friends
					m_friends.push i.dataValues
				
				User.findAll(limit: 18,order: "created_at desc").then((users)->
					v_users = []
					for user in users
						unless v_friends.indexOf(user.dataValues.id) >= 0
							v_users.push user.dataValues

					res.render("friend/index",{
						title: "ユーザーを見つけよう::Aimerthyst:アメジスト",
						friends: m_friends,
						already_friends: v_friends,
						current_user: current_user,
						users: v_users
					})
				)
			)
		)
	else
		req.flash "info","ログインしている必要があります(・∀・)！！"
		res.redirect "/"
)

#ユーザーを検索するためのアクションを実装する
app.post("/search",(req,res)->
	current_user = req.session.current_user
	if current_user?
		data = req.body

		current_user.getFriends().then((friends)->
			#自分の友だちのIDをGETする
			v_friends = [current_user.id]
			for friend in friends
				v_friends.push friend.dataValues.friend_id
		
			User.findAll(where: {id: v_friends}).then((my_friends)->
				m_friends = []
				for i in my_friends
					m_friends.push i.dataValues
				
				User.findAll(where: {name: data.search},limit: 18,order: "created_at desc").then((users)->
					v_users = []
					for user in users
						unless v_friends.indexOf(user.dataValues.id) >= 0
							v_users.push user.dataValues

					res.render("friend/index",{
						title: "ユーザーを見つけよう",
						friends: m_friends,
						already_friends: v_friends,
						current_user: current_user,
						users: v_users
					})
				)
			)
		)
	else
		req.flash "info","ログインしてから利用してください"
		res.redirect "/"
)

#次のユーザを順次読み込んでいくためのアクション
app.post("/more",(req,res)->
	data = req.body
	console.log data
	BASE_NUM = 18
	User.findAll(limit: BASE_NUM,order: "created_at desc",offset: (BASE_NUM * data.page_id)).then((users)->
		v_users = []
		for user in users
			v_users.push user.dataValues
		res.json v_users
	).catch((e)->
		console.log e
		data = false
		res.json data
	)
)

#ユーザーをフォローするためのアクション
app.post("/follow",(req,res)->
	data = req.body
	Friend.create({
		user_id: data.user_id,
		friend_id: data.friend_id
	}).then((friend)->
		data = {state: true,flash: "フォローしました！"}
		res.json data
	).catch((err)->
		data = {state: false,flash: "フォローに失敗しました(´・ω・｀)"}
		res.json data
	)
)

#ユーザーのフォローを外すためのコード
app.post("/unfollow",(req,res)->
	data = req.body
	console.log data
	
	Friend.findOne(where: {user_id: data.user_id,friend_id: data.friend_id}).then((friend)->
		friend.destroy()
	)
	data = {state: true,flash: "フォローを解除しました。"}
	res.json(data)
)


module.exports = app
