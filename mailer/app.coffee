mailer = require("nodemailer")

#Mail sessings
setting = {
	host: "",
	auth: {
		user: "ユーザ名",
		pass: "パスワード",
		port: "SMTPポート番号"
	}
}

#mail送信時の送信先などの設定・
#この設定はアプリケーションのコントローラ内部で設定すると良いかもしれない
mail_options = {
	from: "送信者のメールアドレス",
	to: "送信先メールアドレス",
	subject: "メールの件名",
	html: "メールの内容"
}

##Edit
