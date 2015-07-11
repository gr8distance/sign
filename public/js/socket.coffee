socket = io()
$ ->

	post = $("#post")
	card_box = $("#card_box")
	u_id = $("#user_id")

	post.on("click",()->
		body = $("#post_body")
		post.hide()

		data = {}
		data.body = body.val()
		data.user_id = u_id.val()
		data.socket_id = socket.id

		socket.emit("send_post_card",data)
		$("#create_post").closeModal()
		body.val("")
		post.fadeIn()
	)

	socket.on("failed_save_data",(data)->
		if data
			console.log "unsaved!"
	)

	socket.on("hand_out_post_card",(data)->

		post_card = "<article id='posted_card_#{data.id}' class='col s12 m6 l4'>
			<div class='card'>
			<div class='card-content'>
			<div class='row'>
			<div class='col s2 m3 l2'><img src='#{if data.user_image? then data.user_image else "/images/amethyst_flat.png"}' class='circle responsive-img'></div>
			<div class='col s10 m9 l10'><span class='card-title cyan-text'>#{data.user_name}</span></div>
			</div>
			<p>#{data.body.replace(/\n/g,'<br/>')}</p>
			<span class='font_size_10 right'>#{data.created_at}</span>
			</div>
			<div class='card-action'><a href='/posts/#{data.id}' class='teal-text'>コメント</a></div>
			</div>
			</article>"
		card_box.prepend(post_card)
	)
