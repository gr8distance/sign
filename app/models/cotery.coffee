sql = require('../../lib/models/sql')
Cotery = sql.s.define('Cotery',{
	name: {
		type: sql.S.STRING,
		allowNull: false
	},description: {
		type: sql.S.TEXT
	},image: {
		type: sql.S.STRING
	},permit: {
		type: sql.S.BOOLEAN,
		defaultValue: false
	}




},{underscored: true})
module.exports = Cotery
