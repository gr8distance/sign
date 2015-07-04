sql = require('../../lib/models/sql')
Post = sql.s.define('Post',{
	
	body: {
		type: sql.S.TEXT,
		allowNull: false
	},
	user_id: {
		type: sql.S.INTEGER,
		allowNull: false
	}

},{
	underscored: true
})

module.exports = Post
