sql = require('../../lib/models/sql')
Timeline = sql.s.define('Timeline',{
	model_name: {
		type: sql.S.STRING,
		allowNull: false
	},model_id: {
		type: sql.S.INTEGER,
		allowNull: false
	}
})

module.exports = Timeline
