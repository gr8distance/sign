crypto = require("crypto")
Sequelize =  require("sequelize")
sequelize =  new Sequelize("","","",{
  dialect: "sqlite",
  storage: "./db/development.sql"
})

data = {
  s: sequelize,
  S: Sequelize,
  hash: (s) ->
    sh = crypto.createHash('sha512')
    sh.update(s)
    return sh.digest('base64')
}

module.exports = data

