fs = require("fs")

#大文字化
cap= (s) ->
	return "#{s[0].toUpperCase()}#{s.slice(1)}"

puts= (s)->
	console.log s

path = "./app/models/"

createModels = ->
	for i in fs.readdirSync(path)
		unless i.match(/^\./)
			r = i.split(".")[0]
			eval("#{cap(r)} = require('../../app/models/#{r}')")

module.exports = createModels
