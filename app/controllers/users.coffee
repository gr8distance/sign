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
		req.redirect("/")
	)
)


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


#ログアウトするためのメソッド
app.post("/logout",(req,res)->
	req.session.current_user = null
	res.clearCookie("_echo_app")

	if (req.session.current_user?) && (req.cookies._echo_app?)
		req.flash("info","ログアウトに失敗しました")
		res.redirect("/")
	else
		#console.log "(*´∀｀*) #{req.session.user}"
		#console.log "(・∀・)！ #{req.cookies._echo_app}"
		req.flash("info","ログアウトしました。")
		res.redirect("/")
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
		req.flash("info","ユーザー登録に成功しました(*´∀｀*)")
		req.user = user
		res.cookie("_echo_app",user.uniq_session_id,{maxAge: (60 * 60 * 48)})

		res.redirect("/")
	).catch((err)->
		req.flash("info","作成に失敗しました(´・ω・`)")
		res.redirect("/users/new")
	)
)

#ログインするときに使うやで
app.post("/login",(req,res)->
	data = req.body

	user = User.find(where: {
		email: data.email
	}).then((u)->
		user = u.dataValues
		#console.log	user.password
		pass = User.hash(data.password)
		if pass == user.password
			req.session.user = user
			req.flash("info","ログインしました(*´∀｀*)")
			
			res.cookie("_echo_app",user.uniq_session_id,{maxAge: 66600})
			res.redirect("/")
		else
			req.flash("info","ログインに失敗しました(´・ω・`)`)")
			req.redirect("/")

	).catch((err)->
		console.log err
		req.flash("info","ログインに失敗しました(´・ω・`)`)")
		res.redirect("/")
	)
)


module.exports = app
