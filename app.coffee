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
cluster = require('cluster')
numCPUs = require('os').cpus().length


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


#クッキーをパースしたり
#ビューの中に埋め込む共有プロパティの設定をしている
app.use cookieParser()
app.use express.static(path.join(__dirname, "public"))
app.locals.pretty = true

##全コントローラ共通のメソッドを記述
app.get("/*",(req,res,next)->
	#Cookieに含まれるログイン情報からユーザーがログイン中かどうかを確認する
	if req.cookies._aimerthyst_authenticate_token?
		req.current_user = JSON.parse(req.cookies._aimerthyst_authenticate_token)
		User.findAll(where: {
			email: req.current_user.email,
			token: req.current_user.token,
			name: req.current_user.name
		}).then((users)->
			if users.length == 0
				puts "Did not find"
				User.create({
					name: req.current_user.name,
					email: req.current_user.email,
					token: req.current_user.token,
					uniq_session_id: req.current_user.token
				}).then((user)->
					req.current_user = user.dataValues
				)
			else
				req.current_user = users[0].dataValues
		)
		app.locals.current_user = req.current_user
	app.locals.user_signed_in = req.current_user?
	next()
)



##ルーティングをメタプロしてる
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



#-----SocketIO------#
io.on("connection",(socket)->
	console.log("(・∀・)！User connected")
)
#-----SocketIO------#


