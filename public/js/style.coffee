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

	#次の投稿をAJAXで取得する時にローディングする
	loading = $("#loading")
	load_more = $("#load_more")
	loading.hide()
	card_box = $("#card_box")

	load_more.on("click",->
		$(@).hide()
		loading.show()
		page_id = $(".page_id").attr("id")

		$.post("/posts/more",{
			page_id: page_id
		},(data)->
			#ページネーション用のIDを更新する
			id = data.page_id
			$(".page_id")
			
			for post in data.posts
				post_card = "<article id='posted_card_#{post.id}' class='col s12 m6 l4'>
					<div class='card'>
					<div class='card-content'>
					<div class='row'>
					<div class='col s2 m3 l2'><img src='#{if post.user_image? then post.user_image else "/images/amethyst_flat.png"}' class='circle responsive-img'></div>
					<div class='col s10 m9 l10'><span class='card-title cyan-text'>#{post.user_name}</span></div>
					</div>
					<p>#{post.body.replace(/\n/g,'<br/>')}</p>
					<span class='font_size_10 right'>#{post.created_at}</span>
					</div>
					<div class='card-action'><a href='/posts/#{post.id}' class='teal-text'>コメント</a></div>
					</div>
					</article>"
				card_box.prepend(post_card)

			loading.hide()
			load_more.fadeIn()
		)
	)

