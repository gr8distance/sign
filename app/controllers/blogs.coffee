express = require('express')
app = express.Router()
require('../../lib/models')()

app.post("/",(req,res)->
	data = req.body
	Blog.create(data).then((blog)->
		req.flash "info","ブログを投稿しました",
		res.redirect "/users/#{data.user_id}/edit"
	).catch((e)->
		console.log e
		req.flash "info","投稿に失敗しました"
		res.redirect "/users/#{data.user_id}/edit"
	)
)



module.exports = app
