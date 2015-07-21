express = require('express')
app = express.Router()
require('../../lib/models')()
fs = require("fs")

app.get("/",(req,res)->

	current_user = req.session.current_user
	if current_user?

		current_user.getSongs().then((songs)->
			v_songs = []
			for song in songs
				v_songs.push song

			res.render("songs/index",{
				title: "楽曲集::Aimerthyst:",
				current_user: req.session.current_user,
				songs: v_songs,
				btn: "song",
				flash: req.flash("info").0
			})
		).catch((err)->
			req.flash("info","曲がみつからないよー")
			res.redirect("/songs")
		)
	else
		req.flash("info","ログインしてください")
		res.redirect("/")
)

app.post("/",(req,res)->
	current_user = req.session.current_user
	if current_user?
		#ファイルの存在を確認する
		#ファイルをimagesから曲を配置するべきディレクトリに移動する
		#移動を確認した後DBにファイルパスを保存する
		#保存に成功したらredirect
		#
		#
		#song = req.files
		#console.log	song
		#req.flash "info","アップロードしました"
		#res.redirect "/songs"
	else
		req.flash "info","ログインしていない場合は楽曲の公開はできません"
		res.redirect "/"
)


module.exports = app
