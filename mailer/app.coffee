nodemailer = require "nodemailer"

transporter = nodemailer.createTransport({
	service: 'Gmail',
	auth: {
		user: "info@aimerthyst.co",
		pass: "Lancelot183"
	}
})

mailOptions = {
	from: 'Fred Foo ✔ <foo@blurdybloop.com>',
	to: "suzaku622@gmail.com",
	subject: 'Hello ✔',
	text: 'Hello world ✔',
	html: '<b>Hello world ✔</b>'
}

transporter.sendMail(mailOptions,(error, info)->
	if error
		console.log "Message sent"
)


