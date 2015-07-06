sql = require('../../lib/models/sql')
Post = sql.s.define('Post',{
	
	body: {
		type: sql.S.TEXT,
		allowNull: false
	},user_name: {
		type: sql.S.STRING,
		allowNull: false
	},user_image: {
		type: sql.S.STRING
	}
},{
	underscored: true
})

module.exports = Post
