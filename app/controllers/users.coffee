express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()


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
		req.session.current_user = user.dataValues
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
		user.getPosts().then((posts)->
			res.render("users/show",{
				title: user.name,
				user: user,
				posts: posts
			})
		)
	).catch((err)->
		req.flash("info","ユーザーが見つかりません(´・ω・)")
		res.redirect("/")
	)
)


app.post("/:id",(req,res)->
	id = req.params
	console.log id

	data = req.body
	console.log data

	res.redirect("/users/#{id.id}")
	User.update(data,where: {
		id: id.id
	},data)
)


#編集ページ
app.get("/:id/edit",(req,res)->
	if req.session.current_user?
		res.render("users/edit",{
			titiel: "プロフィールの編集",
			current_user: req.session.current_user
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
