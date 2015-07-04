socket = io()



$ ->
	
	post = $("#post")
	body = $("#post_body")
	card_box = $("#card_box")

	post.on("click",()->
		post.hide()
		data = body.val()
		if data.length >= 1
			socket.emit("send_post_card",data)
			body.val("")
		post.fadeIn()
	)

	
	socket.on("hand_out_post_card",(data)->
		console.log data
		post_card = "<div id='posted_126 timeline_id_' class='col s12 m6'><article id='126' class='card'><div class='card-content'><div class='row'><div class='col s2 m3 l2'><img src='/images/colorfull2.jpg' alt='' class='responsive-img circle'></div><div class='col s10 m9 l10'><span class='card-title'><a href='' class='cyan-text'>Yuuji</a></span></div></div></div><div class='card-content'><p class='font_size_15'>#{data}</p><p class='right-align font_size_10'>07/04 18:16</p></div><div class='card-action'><a href='' class='orange-text'>編集</a><a href='' class='teal-text'>コメント</a><a class='right red-text'><i class='mdi-action-delete'></i></a></div></article></div>"
		card_box.prepend(post_card).hide().fadeIn(1800)
	)
