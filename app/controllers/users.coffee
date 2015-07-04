express = require("express")
app = express.Router()
require("../../lib/models")()

app.get "/", (req, res) ->
  res.send "respond with a resource"
  return


app.get("/new",(req,res)->
	#console.log sql
	f = req.flash("info")

	res.render("users/new",{
		title: "User new",
		pretty: true,
		flash: f[0]
	})
)

#--メールドレスが登録済みかどうかを確認
app.post("/email_check",(req,res)->
	models.user.find(where: {
		email: req.body.email
	}).then((user)->
		console.log "(´・ω・`)`)#{user}"
		if user?
			res.json({ret: true})
		else
			res.json({ret: false})
	)
)

app.post("/logout",(req,res)->
	#req.clearCookie("")
	req.flash("info","ログアウトしました。")
	res.redirect("/")
)

#ユーザーを保存するためのメソッド
app.post("/",(req,res)->
	data = req.body

	user = models.user.build({
		name: data.name,
		email: data.email,
		password: h.hash(data.password)
	})
	
	user.save().then(->
		req.flash("info","作成に成功しました(｀･ω･´)ゞ")
		res.redirect("/")
	).catch((err)->
		req.flash("info","作成に失敗しました(´・ω・`)")
		res.redirect("/users/new")
	)
)
	


module.exports = app
