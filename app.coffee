puts = (s) ->
	console.log s

express = require("express")
session = require('express-session')
path = require("path")
favicon = require("static-favicon")
logger = require("morgan")
cookieParser = require("cookie-parser")
bodyParser = require("body-parser")
debug = require('debug')('echo')
flash = require("connect-flash")
app = express()
http = require('http').Server(app)
io = require('socket.io')(http)
fs = require("fs")
_ = require("underscore")
require("./lib/models")()
multer = require("multer")
conf = require('config')
Log4js = require('log4js')


#------Logファイルの設定-----#
Log4js.configure('./config/log-config.json')
systemLogger = Log4js.getLogger('system')
accessLogger = Log4js.getLogger('access')
errorLogger = Log4js.getLogger('error')

systemLogger.info("システムログやで(・∀・)！！")
accessLogger.info("アクセスログやで(・∀・)！！")
errorLogger.info("エラーログやで(・∀・)！！")
#-------------------------------###

#-----Flash-----#
app.use(session({
    secret: conf.secrets.pass,
    resave: true,
    saveUninitialized: true
}))
app.use(flash())
#-----flash-----#


# view engine setup
app.set "views", path.join(__dirname, "app/views")
app.set "view engine", "jade"
app.use favicon()
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded()

#画像のアップロードについていろいろ！
app.use(multer({
	dest: './public/uploads/images',
	rename: (fieldname, filename, req, res)->
		d = new Date
		return "#{d.getTime()*18}"
}))

app.use cookieParser()
app.use express.static(path.join(__dirname, "public"))
app.locals.pretty = true

##全コントローラ共通のメソッドを記述
##クッキーからログイン中かどうかを判別する
app.get("/*",(req,res,next)->
	s_id = req.cookies.remember_me
	User.find(where: {uniq_session_id: s_id}).then((user)->
		user.getNotifications().then((notifications)->
			v_notifs = []
			for notification in notifications
				v_notifs.push notification.dataValues
			req.session.current_user = user
			res.session.notifications = v_notifs
			next()
		)
	).catch((err)->
		console.log "This cookie is unknown!"
		next()
	)
)

for route in fs.readdirSync("./app/controllers/")
	unless route.match(/^\./)
		r = route.split(".")[0]
		r = if r == "index" then "/" else r
		app.use("/#{r}",require("./app/controllers/#{r}"))
#-----Routings-----#


#/ catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error("Not Found")
  err.status = 404
  next err
  return


#/ error handlers

# development error handler
# will print stacktrace
if app.get("env") is "development"
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render "error",
      message: err.message
      error: err

    return


# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render "error",
    message: err.message
    error: {}
  return






#-----SocketIO------#
io.on("connection",(socket)->
	console.log("(・∀・)！User connected")
	
	#楽曲の再生を実現するためのコード
	socket.on("play_song",(data)->
		console.log data
		Song.findById(data.song_id).then((song)->
			s = song.dataValues
			fs.readFile(s.data,(err,data)->
				if err
					console.log err
				else
					socket.emit("send_song_data",data)
			)
		)
	)

	#新しいコメントを書くためのコード
	socket.on("create_new_comment",(data)->
		if data.first_check
			socket.join(data.room_id)
		else
			io.sockets.to(data.room_id).emit("sent_create_new_comment",data)
			Comment.create({
				body: data.body,
				user_id: data.user_id,
				post_id: data.post_id,
				user_name: data.user_name,
				user_image: "thumb/#{data.user_image}"
			}).then((comment)->
				
				Post.findById(data.post_id).then((post)->
					post.getUser().then((user)->
						Notification.create({
							user_name: data.user_name,
							user_id: user.dataValues.id,
							user_image: "thumb/#{data.user_image}",
							model_name: "posts",
							model_id: data.post_id,
							message: "#{data.user_name}さんがあなたの書き込みにコメントしました。"
						})
					)
				)
			).catch((e)->
				console.log e
			)
	)


	#サークルでトークするためのコード
	socket.on("send_circle_talk",(data)->
		#最初のアクセスでROOM分けを行う
		#次のアクセスからは通常通りの運用を行う
		if data.firsr_check
			socket.join(data.room_id)
		else
			io.sockets.to(data.room_id).emit("sent_talk_from_server",data)
			Talk.create({
				body: data.body,
				room_id: data.room_id,
				user_name: data.user_name,
				user_image: "/thumb/#{data.user_image}",
				user_id: data.user_id
			}).then((talk)->
				#サークルの参加権限持つユーザーを割り出しすべてのユーザーに通知を送る
				Cotery.findById(data.circle_id).then((cotery)->
					
					
					#さらに通知を逃した人のためにDBにも保存する
					unless cotery.dataValues.permit
						Permit.findAll(where: {model_name: "Cotery",model_id: data.circle_id}).then((users)->
							for user in users
								#DBに保存するためのコード
								#DBに保存する。ただし掲示板への参加権限を持ち合わせてい人のみ
								u = user.dataValues
								if u.user_id != parseInt(data.user_id)
									if u.permit

										##誰かが掲示板に書き込んだら全員に通知が行くようにする
										#notif = {
										#	id: data.user_id,
										#	cotery_id: data.circle_id,
										#	flash: "#{data.user_name}さんが掲示板に書き込みしました"
										#}
										#return_notification = "notification_#{u.user_id}"
										#socket.emit(return_notification,notif)

										Notification.create({
											user_name: data.user_name,
											user_image: "/thumb/#{data.user_image}",
											model_id: data.circle_id,
											model_name: "coteries",
											message: "#{data.user_name}さんがサークルに書き込みしました",
											user_id: u.user_id
										}).catch((e)->
											console.log e
										)
						)
				)
			)
	)

	############ここまで！###########

	#トップページからのPOSTアクセスを管理する
	socket.on("send_post_card",(data)->
		console.log data
		socket_id = data.socket_id

		User.findById(data.user_id).then((user)->
			#d = new Date()
			##ひとまずすべてのユーザーにデータをEmitする
			#data.user_id = user.id
			#data.user_name = user.name
			#data.user_image = user.image
			#data.created_at = "#{d.getFullYear()}-#{d.getMonth()+1}-#{d.getDate()} #{d.getHours()}:#{d.getMinutes()} "
			#io.sockets.emit("hand_out_post_card",data)

			#エミットした後にDBに保存する
			Post.create({
				body: data.body,
				user_id: data.user_id,
				user_name: user.name,
				user_image: "/thumb/#{user.image}"
			}).then((post)->
				d = new Date()
				#ひとまずすべてのユーザーにデータをEmitする
				data = post.dataValues
				data.created_at = "#{d.getFullYear()}-#{d.getMonth()+1}-#{d.getDate()} #{d.getHours()}:#{d.getMinutes()} "
				io.sockets.emit("hand_out_post_card",data)
			).catch((err)->
				console.log err
			)
		).catch((err)->
			console.log "Cant find user #{err}"
			io.to(data.socket_id).emit("failed_save_data",err)
		)
	)
	
)
#-----SocketIO------#

try
	switch app.get("env")
		when "development"
			http.listen(3000,->
				console.log "Server is running!"
				console.log "development"
			)
		when "production"
			http.listen(80,->
				console.log "Server is running!"
				console.log "Production"
			)
catch err
	console.log err

