sql = require('../../lib/models/sql')

Policy = sql.s.define('Policy',{
	title: {
		type: sql.S.STRING,
		allowNull: false
	},
	description: {
		type: sql.S.TEXT,
		allowNull: false
	}
})

#sql.s.sync({force: true})
module.exports = Policy
