sql = require('../../lib/models/sql')
Talk = sql.s.define('Talk',{
	room_id: {
		type: sql.S.STRING,
		allowNull: false
	},body: {
		type: sql.S.TEXT,
		allowNull: false
	},image: {
		type: sql.S.STRING
	},user_name: {
		type: sql.S.STRING,
		allowNull: false
	},user_image: {
		type: sql.S.STRING
	}
},{underscored: true})
module.exports = Talk
