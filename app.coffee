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



#HTTPのデータを外部ファイル（SOCKETとENGING)に移動するため
#HTTPプロパティにはHTTPオブジェクトを
#ENVプロパティには実行時の環境（DEV,PRODUCTION)などを書き出す
data = {
	http: http,
	env: app.get("env")
}
module.exports = data
