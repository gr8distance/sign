sql = require('../../lib/models/sql')
Friend = sql.s.define('Friend',{
	friend_id: {
		type: sql.S.INTEGER,
		allowNull: false
	}
},{underscored: true})
module.exports = Friend
