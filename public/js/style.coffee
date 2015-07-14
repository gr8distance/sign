$ ->
	$('.parallax').parallax()
	#$(".nav-wrapper").pushpin({top: 0});
	$(".dropdown-button").dropdown()
	$(".button-collapse").sideNav()
	$('.modal-trigger').leanModal()
	$(".dropdown-button").dropdown()
	$('.materialboxed').materialbox()
	$('.datepicker').pickadate({
		selectMonths: true, #Creates a dropdown to control month
		selectYears: 15 #Creates a dropdown of 15 years to control year
	})

	#必要があればパララックス・ビューの高さを画面の高さと同じにする
	w = $(window)
	h = w.height()
	$("#before_login_page").css({
		height: h
	})
	

	wrf = $(".show_write_rep")
	wrf.on("click",->
		this_id =  $(this).attr("id")
		form_id = "#{this_id}_form"
		$("##{form_id}").slideToggle()
	)
	
	#スクロールすればパララックス・ビューにぶらーをかける
	w = $(window)
	parallax= $(".parallax-container")
	parallax_height = (parallax.height() * 0.666)
	parallax_img = $(".parallax img")

	w.scroll(->
		sc = $(@).scrollTop()
		if parallax_height < sc
			parallax_img.addClass("blur")
		else
			parallax_img.removeClass("blur")

	)
	
	$("#sub").on("click",->
		console.log "clicked"
		d = $("#dammy").val() || "stone"
		console.log d
		data = {}
		data.send = d

		$.post("/users/ajax",data,(data)->
			console.log "Return data"

		)
	)

	##ログインする時AJAXでログインする
	#$("#login_submit").on("click",()->
	#	email = $("#login_email").val()
	#	password = $("#login_pass").val()
	#	remember_me = $("#remember_me").val()

	#	$.post("/auth/login",{
	#		email: email,
	#		password: password,
	#		remember_me: remember_me
	#	})
	#)


	#次の投稿をAJAXで取得する時にローディングする######################
	loading = $("#loading")
	load_more = $("#load_more")
	loading.hide()
	card_box = $("#card_box")

	load_more.on("click",->
		$(@).hide()
		loading.show()
		page_id = $(".page_id")
		p = parseInt(page_id.val())
		page_id.val("#{p+1}")

		$.post("/posts/more",{
			page_id: p
		},(data)->
			setTimeout(->
				for post in data
					post_card = "<article id='posted_card_#{post.id}' class='col s12 m6 l4'>
						<div class='card'>
						<div class='card-content'>
						<div class='row'>
						<div class='col s2 m3 l2'>
						<img src='#{if post.user_image? then post.user_image else "/images/amethyst_flat.png"}' class='circle responsive-img'>i
						</div>
						<div class='col s10 m9 l10'><span class='card-title cyan-text'>#{post.user_name}</span></div>
						</div>
						<p>#{post.body.replace(/\n/g,'<br/>')}</p>
						<span class='font_size_10 right'>#{post.created_at}</span>
						</div>
						<div class='card-action'><a href='/posts/#{post.id}' class='teal-text'>コメント</a></div>
						</div>
						</article>"
					card_box.append(post_card)
				loading.hide()
				load_more.fadeIn()
			,1800)
		)
	)
	###################################################################
	###################################################################
	
	#友だち追加と削除のボタンをAJAX対応にした
	#まずはボタンが押されたことを検知する
	$(".be_friend_form").submit((e)->
		#とりあえずフォームの送信を停止
		e.preventDefault()

		#2重送信を防ぐためにボタンを削除
		fr_sub = $("#friend_follow_submit")
		fr_sub.hide()
		
		#友達のIDを取得
		form_id = $(@).attr("id")
		
		#URLと送信しないと行けないデータを取得
		url = $(@).attr("action")
		data = {}
		data.user_id = $("#user_id").val()
		data.friend_id = $("#friend_id").val()

		#AJAXで送信する
		$.post(url,data,(data)->
			#戻りのデータから処理を開始
			Materialize.toast(data.flash,3330)

			if data.state
				fr_sub.show()
				BASE = "/friends"
				path = url.split("/")[2]
				switch path
					when "follow"
						$("##{form_id}").attr("action","#{BASE}/unfollow")
						$("##{form_id} #friend_follow_submit").text("フォロー中").removeClass("blue").addClass("pink")
					when "unfollow"
						$("##{form_id}").attr("action","#{BASE}/follow")
						$("##{form_id} #friend_follow_submit").text("フォロー").removeClass("pink").addClass("blue")
		)
	)
	########################
	#
	#####ユーザー情報の編集を行う
	$("#edit_user_profile_form").submit((e)->
		#自動送信を解除
		e.preventDefault()

		#送信用のデータを作成
		data = {}
		data.name = $("#user_name").val()
		data.email = $("#user_email").val()
		data.description = $("#user_profile").val()
		
		#URLを取得
		url = $(@).attr("action")

		#AJAXで送信
		$.post(url,data,(data)->
			if data.state
				Materialize.toast(data.flash,3330)
				$("#usr_name").text(data.name)
				$("#usr_email").text(data.email)
				$("#usr_prof").text(data.description)
				$("#user_name").text(data.name)
				$("#user_email").text(data.email)
				$("#user_profile").text(data.description)
				
				$("#edit_user_profile").closeModal()
			else
				Materialize.toast(data.flash,3330)
		)
	)


