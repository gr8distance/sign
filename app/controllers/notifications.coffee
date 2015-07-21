express = require('express')
app = express.Router()
require('../../lib/models')()

#通知を確認する
app.get("/",(req,res)->
	if req.session.current_user?
		user = req.session.current_user
		Notification.findAll(where: {user_id: user.id},order: "updated_at desc",limit: 18).then((notifications)->
			v_notif = []
			for notif in notifications
				v_notif.push notif.dataValues

			res.render("notifications/index",{
				notifications: v_notif,
				current_user: req.session.current_user,
				user: user
			})
		)
	else
		req.flash "info","ログインしてから確認して下さい(´・ω・｀)"
		res.redirect "/"
)



module.exports = app
