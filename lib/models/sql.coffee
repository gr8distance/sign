app = require("express")()
crypto = require("crypto")
conf = require "config"
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
		sequelize =  new Sequelize(conf.mysql.name,conf.mysql.user,conf.mysql.password)


data = {
  s: sequelize,
  S: Sequelize,
  hash: (s) ->
    sh = crypto.createHash('sha512')
    sh.update(s)
    return sh.digest('base64')
}

module.exports = data

