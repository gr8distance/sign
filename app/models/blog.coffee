sql = require('../../lib/models/sql')
Blog = sql.s.define('Blog',{
	title: {
		type: sql.S.STRING,
	},body: {
		type: sql.S.TEXT,
		allowNull: false
	},thumb_nail: {
		type: sql.S.STRING
	},user_name: {
		type: sql.S.STRING,
		allowNull: false
	},user_image: {
		type: sql.S.STRING
	}
},{underscored: true})
module.exports = Blog
