fs = require("fs")
routes = require("../app/controllers/")

index= ->
	console.log "Called index"
	
routes = {
	
	"/": {
		func: index,
		path: "/home/index",
		method: "get"
	},
	"/users/": {
		func: index,
		path: "/users/index",
		method: "get"
	}
}



module.exports = routes
