sql = require('../../lib/models/sql')
Contact = sql.s.define('Contact',{
	name: sql.S.STRING,
	email: {
		type: sql.S.STRING,
		allowNull: false
	},
	body: {
		type: sql.S.STRING,
		allowNull: false
	}
})

module.exports = Contact
