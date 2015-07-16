express = require('express')
app = express.Router()
require('../../lib/models')()


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
				btn: "song"
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
		
	else
		req.flash "info","ログインしていない場合は楽曲の公開はできません"
		res.redirect "/"
)



module.exports = app
