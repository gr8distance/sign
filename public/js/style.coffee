$ ->
	$('.parallax').parallax()
	$(".dropdown-button").dropdown()
	$(".button-collapse").sideNav()
	$('.modal-trigger').leanModal()
	$(".dropdown-button").dropdown()
	$('.tooltipped').tooltip({delay: 50})
	$('.materialboxed').materialbox()
	$('.datepicker').pickadate({
		selectMonths: true, #Creates a dropdown to control month
		selectYears: 15 #Creates a dropdown of 15 years to control year
	})
	$('ul.tabs').tabs()

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
		#console.log "clicked"
		d = $("#dammy").val() || "stone"
		#console.log d
		data = {}
		data.send = d

		$.post("/users/ajax",data,(data)->
			#console.log "Return data"

		)
	)
	
	#友達を順次AJAXで取得する時にローディングする######################
	loading_friend = $("#loading_friend")
	load_more_friend = $("#load_more_friend")
	loading_friend.hide()
	friend_box = $("#friend_place")

	load_more_friend.on("click",->
		all_friends = $("#all_friends_id").val().split("_")

		$(@).hide()
		loading_friend.show()
		page_id = $(".page_id")
		p = parseInt(page_id.val())
		page_id.val("#{p+1}")

		$.post("/friends/more",{
			page_id: p
		},(data)->
			current_user_id = $("#current_user_id").val()

			friend_btn = (all_friends,friend) ->
				if all_friends.indexOf(friend.id) >= 0
					return "<button id='be_friend_form_103_3 friend_follow_submit' data-friend-id='be_friend_form_103_3' action='/friends/unfollow' class='btn-flat pink white-text waves-effect waves-light be_friend_form'>
					<i class='fa fa-heart'/>
					</button>"
				else
					return "<button id='be_friend_form_98_3 friend_follow_submit' data-friend-id='be_friend_form_98_3' action='/friends/follow' class='btn-flat blue white-text waves-effect waves-light be_friend_form'>
				<i class='fa fa-heart-o'/>	
				</button>"

			setTimeout(->
				for user in data
					post_card = "<li class='collection-item avatar'><img src='#{if user.image? then user.image else "/images/colorfull2.jpg"}' class='circle'>
						<span class='title'><a href='/users/#{user.id}'>#{user.name}</a></span>
						<div class='secondary-content'>
						#{friend_btn(all_friends,user)}
						</div>
						</li>"
					friend_box.append(post_card)
				loading_friend.hide()
				load_more_friend.fadeIn()
			,666)
		)
	)
	#########################
	

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
		
		
		create_delete_form = (post,current_user_id)->
			if post.user_id == parseInt(current_user_id)
				return "<a href='/posts/#{post.id}/edit'>編集</a><i id='delete_post_#{post.id}_#{post.user_id}' class='mdi-action-delete red-text tiny delete_post_form right'></i>"
			else
				return ""

		current_user_id = $("#current_user_id").val()
		$.post("/posts/more",{page_id: p},(data)->
			setTimeout(->
				for post in data
					post_card = "<article id='posted_card_#{post.id}' class='col s12 m6'>
						<div class='card'>
						<div class='card-content'>
						<div class='row'>
						<div class='col s2 m3 l2'>
						<img src='#{if post.user_image? then post.user_image else "/images/amethyst_flat.png"}' class='circle responsive-img'>
						</div>
						<div class='col s10 m9 l10'><span class='card-title cyan-text'>#{post.user_name}</span></div>
						</div>
						<p>#{post.body.replace(/\n/g,'<br/>')}</p>
						<span class='font_size_10 right'>#{post.created_at}</span>
						</div>
						<div class='card-action'>
						<a href='/posts/#{post.id}' class='teal-text'>コメント</a>
						#{create_delete_form(post,current_user_id)}
						</div>
						</div>
						</article>"
					card_box.append(post_card)
				loading.hide()
				load_more.fadeIn()
			,666)
		)
	)
	###################################################################
	###################################################################
	
	#友だち追加と削除のボタンをAJAX対応にした
	#まずはボタンが押されたことを検知する
	$(document).on("click",".be_friend_form",->

		#友達のIDを取得
		form_id = $(@).attr("data-friend-id")
		#console.log form_id

		#2重送信を防ぐためにボタンを削除
		this_form = $(@)
		this_form.hide()

		#URLと送信しないと行けないデータを取得
		url = $(@).attr("action")

		fs = form_id.split("_")
		data = {}
		data.user_id = fs[4]
		data.friend_id = fs[3]
		
		#AJAXで送信する
		$.post(url,data,(data)->
			#戻りのデータから処理を開始
			Materialize.toast(data.flash,3330)

			if data.state
				BASE = "/friends"
				path = url.split("/")[2]

				switch path
					when "follow"
						this_form.attr("action","#{BASE}/unfollow").empty().append("<i class='fa fa-heart'/>").removeClass("blue").addClass("pink").show()
					when "unfollow"
						this_form.attr("action","#{BASE}/follow").empty().append("<i class='fa fa-heart-o'/>").removeClass("pink").addClass("blue").show()
		)
	)

	########################
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
	

	####サークルへの参加申請
	$(".commit_cotery").submit((e)->
		e.preventDefault()
		url = $(@).attr("action")
		id = $(".commit_btn").attr("id")
		data = {
			user_id: id.split("_")[3]
			cotery_id: id.split("_")[2]
		}
		t = $(@)
		$.post(url,data,(data)->
			if data.state
				$(t).append("<p>サークルに参加希望をだしました</p>")
				$("##{id}").hide()
				Materialize.toast data.flash,3330
			else
				Materialize.toast data.flash,3330
		)
	)

	#####サークルへの参加権限を与えるたり奪ったりするコード
	$(".change_permit").submit((e)->
		e.preventDefault()
		#console.log "clocked"

		url = $(@).attr("action")
		id = $(@).attr("id")
		ids = id.split("_")
		data = {
			cotery_id: ids[1],
			user_id: ids[2],
			permit_user_id: ids[3]
		}
		$.post(url,data,(data)->
			#console.log data
			if data.state
				Materialize.toast data.flash,3330
				$("#waiting_user_#{data.user_id}").fadeOut()
			else
				Materialize.toast data.flash,3330
		)
	)

	#投稿を削除するためのコード
	#書きなおした
	#このコードなら動的に追加されてもイベントが白化する
	$(document).on("click",".delete_post_form",->
		console.log "cliecled"
		id = $(@).attr("id")
		data = {post: id.split("_")[2],user: id.split("_")[3]}
		url = "/posts/#{data.post}/delete"
		$("#posted_card_#{data.post}").fadeOut()

		$.post(url,data,(data)->
			if data.state
				Materialize.toast(data.flash,3330)
			else
				Materialize.toast(data.flash,3330)
		)
	)
	
	#掲示板の表示をいい感じにする
	#header_h = $("header").height()
	#menu_h =  $("#make_margin_top").height()
	#over_head = menu_h + header_h
	#win_blank = h - over_head - 18
	#

	#$("#talk_place").css({
	#	height: win_blank,
	#	overflow: "scroll",
	#	" -webkit-overflow-scrolling": "touch"
	#}).animate({scrollTop: $("#sc_end").offset().top},10)


