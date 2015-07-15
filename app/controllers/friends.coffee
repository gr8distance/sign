express = require('express')
app = express.Router()
require('../../lib/models')()


#他のユーザー一覧を表示するためのアクション
app.get("/",(req,res)->
	
	User.findAll(limit: 18,order: "created_at desc").then((users)->
		v_users = []
		for user in users
			if user.dataValues.id != req.session.current_user.id
				v_users.push user
		
		req.session.current_user.getFriends().then((friends)->
			my_friends = []
			all_friends = ""
			
			for friend in friends
				my_friends.push friend.dataValues.friend_id
				all_friends += "#{friend.dataValues.friend_id}_"

			res.render("friend/index",{
				users: v_users,
				friends: my_friends,
				current_user: req.session.current_user,
				flash: req.flash("info")[0],
				title: "アメジストに登録しているユーザーを探す",
				all_friends: all_friends
			})
		)
	).catch((err)->
		console.log err
		console.log "(´・ω・｀)"
	)
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
