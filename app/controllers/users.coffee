express = require("express")
app = express.Router()
easyimg = require("easyimage")
_ = require("underscore")
require("../../lib/models")()
fs = require("fs")

app.get("/new",(req,res)->
	#console.log sql
	f = req.flash("info")

	res.render("users/new",{
		title: "User new",
		pretty: true,
		flash: f[0]
	})
)

#ユーザーを保存するためのメソッド
app.post("/",(req,res)->
	data = req.body

	user = User.build({
		name: data.name,
		email: data.email,
		password: User.hash(data.password),
		uniq_session_id: User.make_session(data.name,data.email)
	})
	
	user.save().then((user)->
		req.session.current_user = user
		res.cookie("remember_me",user.uniq_session_id)

		req.flash("info","ユーザー登録が完了しました(・∀・)！ようこそAimethystへ")
		res.redirect("/")
	).catch((err)->
		req.flash("info","作成に失敗しました(´・ω・`)")
		res.redirect("/users/new")
	)
)


#USERの詳細情報とかいろいろ表示する
#来訪者向けの項目
app.get("/:id",(req,res)->
	id = req.params.id
	User.findById(id).then((user)->

		if req.session.current_user?
			User.findById(req.session.current_user.id).then((c_user)->
				c_user.getFriends().then((friends)->
					
					v_friends = []
					for friend in friends
						v_friends.push friend.dataValues.friend_id

					user.getPosts(order: "updated_at desc",limit: 18).then((posts)->
						res.render("users/show",{
							title: user.name,
							user: user,
							posts: posts,
							current_user: req.session.current_user,
							friends: v_friends
						})
					)
				)
			)
		else
			user.getPosts(order: "updated_at desc").then((posts)->
				res.render("users/show",{
					title: user.name,
					user: user,
					posts: posts,
					current_user: req.session.current_user
				})
			)
	).catch((err)->
		req.flash("info","ユーザーが見つかりません(´・ω・)")
		res.redirect("/")
	)
)


app.post("/:id",(req,res)->
	id = req.params.id
	data = req.body
	
	User.findById(id).then((user)->
		user.updateAttributes(data)
	).then((user)->
		data.state = true
		data.flash = "ユーザー情報を更新しました"
		res.json data

	).catch((err)->
		#console.log "Failed update in user info"
		#console.log err
		data.state = false
		data.flash = "情報の保存に失敗した(´・ω・｀)"
		res.json data
	)
)

app.post("/:id/image",(req,res)->
	id = req.params.id
	file = req.files
	path = "public/uploads/images/#{file.image.name}"
	
	try
		if file.image.size >= 100001
			easyimg.resize({
				src: path,
				dst: path,
				width: 1200,
				height: 1200,
				fill: true
			}).then((image)->
				#console.log "#{image}(・∀・)！！"
			).catch((err)->
				console.log err
			)

		#console.log "(・∀・)！！#{file.image.size}"

		fs.stat(path,(err,stats)->
			if err
				console.log "(´・ω・｀)"
			else
				#console.log stats
				easyimg.rescrop({
					src: path,
					dst: "public/thumb/uploads/images/#{file.image.name}",
					width: 250,
					height: 250,
					fill: true
				}).then((image)->
					#console.log "(・∀・)！！#{image}"
				).catch((err)->
					console.log "(´・ω・｀)#{err}"
				)
		)
	catch(e)->
		console.log e

	User.findById(id).then((user)->
		user.updateAttributes({
			image: "/uploads/images/#{file.image.name}"
		}).then((user)->
			req.flash("info","画像をアップロードしました。")
			res.redirect("/users/#{id}/edit")
		).catch((err)->
			console.log err
			req.flash("info","ファイルのアップロードに失敗しました")
			res.redirect("/")
		)
	)
)

#編集ページ
app.get("/:id/edit",(req,res)->
	if req.session.current_user?
		res.render("users/edit",{
			titiel: "プロフィールの編集",
			current_user: req.session.current_user,
			flash: req.flash("info")[0]
		})
	else
		req.flash("info","ログインして下さい")
		res.redirect("/")
)

#--メールドレスが登録済みかどうかを確認
app.post("/email_check",(req,res)->
	User.find(where: {
		email: req.body.email
	}).then((user)->
		console.log "(´・ω・`)`)#{user}"
		if user?
			res.json({ret: true})
		else
			res.json({ret: false})
	)
)


module.exports = app
