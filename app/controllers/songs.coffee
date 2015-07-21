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
				flash: req.flash("info")[0]
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
		file = req.files

		fs.stat(file.data.path,(err,stat)->
			if err
				console.log err
				req.flash "info","アップロードに失敗しました(´・ω・｀)"
				res.redirect "/songs"
			else

				new_path = "../data/songs/#{file.data.name}"
				fs.rename(file.data.path,new_path,->
					data = req.body
					Song.create({
						name: data.name,
						data: new_path,
						image: "/uploads/images/#{file.image.name}",
						user_id: req.session.current_user.id,
						user_name: req.session.current_user.name,
						user_image: req.session.current_user.image
					}).then((song)->
						req.flash "info","音源をアップロードしました"
						res.redirect "/songs"
					).catch((e)->
						console.log e
						req.flash "info","楽曲の情報を登録できませんでした(´・ω・｀)"
						res.redirect "/songs"
					)
				)
		)
	else
		req.flash "info","ログインしていない場合は楽曲の公開はできません"
		res.redirect "/songs"
)


module.exports = app
