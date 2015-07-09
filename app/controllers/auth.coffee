express = require("express")
app = express.Router()
_ = require("underscore")
require("../../lib/models")()


#ログインするためのメソッド
#ユーザーコントローラに書いてたら処理が冗長になったからこっちに書く
app.post("/login",(req,res)->

	#送られてきたデータを変数に格納する
	data = req.body
	console.log data
	
	#送信されたデータを元にUSERを探す
	User.find(where: {email: data.email}).then((user)->

		#もしユーザーが見つかればパスワードが一致するかを確認する
		if user.password == User.hash(data.password)
			
			#長期間のログインを記録するためのコード
			#保存期間は48時間
			if data.remember_me?
				res.cookie("_echo_app","#{user.uniq_session_id}",{maxAge: (60*60*48)})
			
			res.cookie("remember_me",user.uniq_session_id)

			#セッションにデータを格納する
			#格納するのはUSERのデータ
			req.session.current_user = user
			
			#トップページに戻る
			req.flash "info","ログインしました(｀･ω･´)ゞ"
			res.redirect "/"

		else
			#パスワードが一致しなかった場合はエラーを投げる
			throw new Error "なんやこれ！"

	).catch((err)->
		#ユーザーが存在しなかったりエラーが飛んできた場合は個々で補足
		#トップページにフラッシュとともに送りつける
		req.flash "info","ユーザーが見つからないかパスワードが正しくありません(´・ω・`)"
		res.redirect("/")
	)
)

#ログアウトのためのメソッド
app.post("/logout",(req,res)->

	#Cookieとセッションのユーザーデータを抹消する
	res.clearCookie("_echo_app")
	res.clearCookie("remember_me")
	req.session.current_user = null
	res.redirect("/")
)

module.exports = app
