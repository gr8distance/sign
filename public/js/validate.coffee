$ ->
	
	#User form validation
	user = $("#user")
	user.validationEngine()
		
	u_email = $("#new_user_email")
	atn = $("#attention_new_user_email")
	
	#もしメールアドレスが過去に登録されたものだった場合はエラーで警告を出す
	u_email.keyup((e)->
		t = $(@).val()
		
		#入力文字数が６文字未満なら何もしない
		if t.length > 6
			$.post("/users/email_check",{
				email: t
			},(data)->
				#console.log data
				if data.ret
					atn.text("このメールアドレスは既に登録済みです(´・ω・)")
			)
	)
