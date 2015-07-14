sql = require('../../lib/models/sql')

Comment = sql.s.define('Comment',{
	body: {
		type: sql.S.TEXT,
		allowNull: false
	},user_name: {
		type: sql.S.STRING,
		allowNull: false
	},user_image: sql.S.STRING
},{
	underscored: true
})

module.exports = Comment
