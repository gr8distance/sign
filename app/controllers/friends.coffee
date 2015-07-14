express = require('express')
app = express.Router()
require('../../lib/models')()


#他のユーザー一覧を表示するためのアクション
app.get("/",(req,res)->
	
	User.findAll().then((users)->
		
		v_users = []
		for user in users
			if user.dataValues.id != req.session.current_user.id
				v_users.push user
		
		req.session.current_user.getFriends().then((friends)->
			my_friends = []
			for friend in friends
				my_friends.push friend.dataValues.friend_id

			res.render("friend/index",{
				users: v_users,
				friends: my_friends,
				current_user: req.session.current_user,
				flash: req.flash("info")[0],
				title: "アメジストに登録しているユーザーを探す"
			})
		)
	).catch((err)->
		console.log err
		console.log "(´・ω・｀)"
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
