sql = require("../../lib/models/sql")

User = sql.s.define("User",{
	name: {
		type: sql.S.STRING,
		allowNull: false
	},email: {
		type: sql.S.STRING,
		unique: true
	},password: {
		type: sql.S.STRING,
		allowNull: false
	},image: sql.S.STRING
},{
	paranoid: true,
	underscored: true
})

#s.seq.sync()
module.exports = User
