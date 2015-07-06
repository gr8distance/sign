sql = require("../../lib/models/sql")

Session = sql.s.define("Session",{
	session_id: {
		type: sql.S.STRING,
		allowNull: false
	}
})

#s.seq.sync({force: true})
module.exports = Session
