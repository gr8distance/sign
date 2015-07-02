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


# Set flash messages
app.use(session({
    secret: "fhaioehf83cyfiqc9qy4cbre8cyo8fneo8cfg8oac8fwbufbghwcvfi7tcew",
    resave: true,
    saveUninitialized: true
}))
app.use(flash())



# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"
app.use favicon()
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use express.static(path.join(__dirname, "public"))

#-----Routings-----#
routes = require("./routes/index")
users = require("./routes/users")
auth = require("./routes/auth")
app.use "/", routes
app.use "/users", users
app.use "/auth", auth
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





app.set('port', process.env.PORT || 3000)
server = app.listen(app.get('port'),->
	debug('Express server listening on port ' + server.address().port)
)
console.log "Server is running!"
#module.exports = app
