nodemailer = require "nodemailer"
conf = require("config")

auth_develop = {
	user: conf.mail.address,
	pass: conf.mail.pass
}
transporter = nodemailer.createTransport({
	service: 'Gmail',
	auth: auth_develop
})


module.exports = send_mail = (email,subject,text) ->
	mailOptions = {
		from: "info@aimerthyst.co",
		to: email,
		subject: subject,
		text: text
	}
	transporter.sendMail(mailOptions,(error, info)->
		if error
			console.log "Message sent"
	)
