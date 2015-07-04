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
passport = require("passport")
LocalStrategy = require("passport-local").Strategy
h =require("./helpers/")
require("./lib/models")()


#-----Flash-----#
app.use(session({
    secret: "fhaioehf83cyfiqc9qy4cbre8cyo8fneo8cfg8oac8fwbufbghwcvfi7tcew",
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
app.use cookieParser()
app.use express.static(path.join(__dirname, "public"))




#-----Routings-----#
#



#routes = require("./routes")
#for k,v in routes
#	app.use(k,v)
#
routes = require("./app/controllers")
app.use("/",routes)
#
#app.post("/login",
#	passport.authenticate('local'),
#	(req,res)->
#		req.flash("info","ログインしました")
#		res.redirect("/")
#)
#
#for route in fs.readdirSync("./controllers/")
#	unless (route == "index.coffee") || route.match(/^\./)
#		r = route.split(".")[0]
#		app.use("/#{r}",require("./controllers/#{r}"))
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
	console.log('user connected')
)
#-----SocketIO------#

http.listen(3000,->
	console.log "Server is running!"
)
