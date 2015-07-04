sql = require('../../lib/models/sql')
Timeline = sql.s.define('Timeline',{
	user_id: {
		type: sql.S.INTEGER,
		allowNull: false
	},model_name: {
		type: sql.S.STRING,
		allowNull: false
	},model_id: {
		type: sql.S.INTEGER,
		allowNull: false
	}
})

module.exports = Timeline
