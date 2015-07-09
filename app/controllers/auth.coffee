express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()


#ログインするためのメソッド
#ユーザーコントローラに書いてたら処理が冗長になったからこっちに書く
app.post("/login",(req,res)->
	data = req.body
	console.log data

	User.find(where: {email: data.email}).then((user)->
		if user.password == User.hash(data.password)
			
			#長期間のログインを記録するためのコード
			if data.remember_me?
				res.cookie("_echo_app","#{user.uniq_session_id}",{maxAge: (60*60*48)})

			req.session.current_user = user.dataValues
			
			req.flash "info","ログインしました(｀･ω･´)ゞ"
			res.redirect "/"

		else

			throw new Error "なんやこれ！"

	).catch((err)->
		req.flash "info","ユーザーが見つからないかパスワードが正しくありません(´・ω・`)"
		res.redirect("/")
	)
)

#ログアウトのためのメソッド
app.post("/logout",(req,res)->
	res.clearCookie("_echo_app")
	req.session.current_user = null
	res.redirect("/")
)

module.exports = app
