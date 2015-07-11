sql = require('../../lib/models/sql')
Song = sql.s.define('Song',{
	name: {
		type: sql.S.STRING,
		allowNull: false
	},data: {
		type: sql.S.STRING,
		allowNull: false
	},description: {
		type: sql.S.STRING
	},image: {
		type: sql.S.STRING
	},user_name: {
		type: sql.S.STRING,
		allowNull: false
	},user_image: {
		type: sql.S.STRING
	}
},{underscored: true})
module.exports = Song
