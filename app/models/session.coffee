sql = require("../../lib/models/sql")

Session = sql.s.define("Session",{
	session_id: {
		type: sql.S.STRING,
		allowNull: false
	},logout: {
		type: sql.S.BOOLEAN,
		allowNull: false,
		defaultValue: false
	}
},{
	underscored: true
})

module.exports = Session
