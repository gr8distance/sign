fs = require("fs")
crypto = require("crypto")
sql = require("./sql")


#大文字化
cap= (s) ->
	return "#{s[0].toUpperCase()}#{s.slice(1)}"

hash = (s) ->
	sha512 = crypto.createHash('sha512')
	sha512.update(s)
	return sha512.digest('hex')


path = "./app/models/"
createModels = ->
	models = {}
	for i in fs.readdirSync(path)
		unless i.match(/^\./)
			r = i.split(".")[0]
			eval("#{cap(r)} = require('../../app/models/#{r}')")
			eval("#{cap(r)}.hash = hash")
	

	User.hasMany(Post)
	User.hasMany(Timeline)
	
	Post.belongsTo(User)
	Timeline.belongsTo(User)
	
	User.hasMany(Comment)
	Post.hasMany(Comment)
	Comment.belongsTo(User)
	Comment.belongsTo(Post)

	User.hasMany(Session)
	Session.belongsTo(User)
	
	
#sql.s.sync({force: true})
#sql.s.sync()
module.exports = createModels
