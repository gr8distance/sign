app = require("express")()
crypto = require("crypto")
Sequelize =  require("sequelize")

switch app.get("env")
	when "development"
		console.log "Start at development mode"
		sequelize =  new Sequelize("","","",{
		  dialect: "sqlite",
		  storage: "./db/development.sql"
		})
	when "production"
		console.log "Start at development mode"
		sequelize =  new Sequelize("radio","suzaku","Lancelot183")


data = {
  s: sequelize,
  S: Sequelize,
  hash: (s) ->
    sh = crypto.createHash('sha512')
    sh.update(s)
    return sh.digest('base64')
}

module.exports = data

