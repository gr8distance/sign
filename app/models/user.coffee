crypto = require("crypto")
sql = require("../../lib/models/sql")

User = sql.s.define("User",{
	name: {
		type: sql.S.STRING,
		allowNull: false
	},
	email: {
		type: sql.S.STRING,
		unique: true
	},
	password: {
		type: sql.S.STRING,
		allowNull: false
	},
	image: {
		type: sql.S.STRING,
	},
	uniq_session_id: {
		type: sql.S.STRING,
		allowNull: false
	},last_login: {
		type: sql.S.DATE,
		defaultValue: new Date
	}
},{
	paranoid: true,
	underscored: true
})
User.make_session = (name,email)->
	s = "#{name}#{email}"
	sha512 = crypto.createHash('sha512')
	sha512.update(s)
	return sha512.digest('hex')

#sql.s.sync({force: true})
module.exports = User
