express = require('express')
app = express.Router()
_ = require("underscore")
require('../../lib/models')()

app.get("/",(req,res)->
	res.render("company/index",{
		title: "Aimerthyst運営チームについて"
		pretty: true
	})
)

app.post("/",(req,res)->
	data = req.body
	Contact.build(data.contact).save().then((d)->
		req.flash("info","保存に成功しました")
		res.redirect("/")
	).catch((err)->
		req.flash("info","問い合わせに失敗")
		res.redirect("/company/contact")
	)

)

app.get("/contact",(req,res)->
	res.render("company/contact",{
		title: "お問い合わせAimerthyst",
		pretty: true
	})
)

app.get("/privacy_policy",(req,res)->
	
	Policy.findAll().then((p)->
		res.render("company/privacy",{
			title: "プライバシーポリシーAimerthyst",
			policies: p,
			pretty: true
		})
	)
)



module.exports = app
