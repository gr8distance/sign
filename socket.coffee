express = require("express")
app = express()
http = require('http').Server(app)
io = require('socket.io')(http)


do_socket = ->
	io.on("connection",(socket)->
		console.log("(・∀・)！User connected")
		
		#サークルでトークするためのコード
		socket.on("send_circle_talk",(data)->
			
			if data.firsr_check
				socket.join(data.room_id)
			else
				console.log data
	
				io.sockets.to(data.room_id).emit("sent_talk_from_server",data)
		
				Talk.create({
					body: data.body,
					room_id: data.room_id,
					user_name: data.user_name,
					user_image: data.user_image,
					user_id: data.user_id
				})
		)
	
		############ここまで！###########
	
		#トップページからのPOSTアクセスを管理する
		socket.on("send_post_card",(data)->
			console.log data
			socket_id = data.socket_id
	
			User.findById(data.user_id).then((user)->
				#ひとまずすべてのユーザーにデータをEmitする
				data.user_id = user.id
				data.user_name = user.name
				data.user_image = user.image
				data.created_at = new Date()
				io.sockets.emit("hand_out_post_card",data)
	
				#エミットした後にDBに保存する
				Post.create({
					body: data.body,
					user_id: data.user_id,
					user_name: user.name,
					user_image: user.image
				}).catch((err)->
					console.log err
				)
			).catch((err)->
				console.log "Cant find user #{err}"
				io.to(data.socket_id).emit("failed_save_data",err)
			)
		)
	)
	#-----SocketIO------#
	
module.exports = do_socket
