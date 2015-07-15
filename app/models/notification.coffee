sql = require('../../lib/models/sql')
Notification = sql.s.define('Notification',{
	user_name: {
		type: sql.S.STRING,
		allowNull: false
	},user_image: {
		type: sql.S.STRING
	},message: { ##通知する通知内容
		type: sql.S.STRING,
		allowNull: false
	},model_name: {
		type: sql.S.STRING,
		allowNull: false
	},model_id: {
		type: sql.S.INTEGER,
		allowNull: false
	},pushed: {
		type: sql.S.BOOLEAN,
		allowNull: false,
		defaultValue: false
	}
},{underscored: true})
module.exports = Notification
