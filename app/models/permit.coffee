sql = require('../../lib/models/sql')
Permit = sql.s.define('Permit',{
	model_id: {
		type: sql.S.INTEGER,
		allowNull: false
	},model_name: {
		type: sql.S.STRING,
		allowNull: false
	},permit: {
		type: sql.S.BOOLEAN,
		allowNull: false,
		defaultValue: false
	},user_name: {
		type: sql.S.STRING,
		allowNull: false
	},user_image: sql.S.STRING
},{underscored: true})
module.exports = Permit
