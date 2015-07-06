sql = require('../../lib/models/sql')

Comment = sql.s.define('Comment',{
	body: {
		type: sql.S.TEXT,
		allowNull: false
	}
},{
	underscored: true
})

module.exports = Comment
