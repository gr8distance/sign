fs = require("fs")


routes = {}

for route in fs.readdirSync("./controllers")
	unless route.match(/^\./)
		r = route.split("_")[0]
		routes["#{r}"] = require("../controllers/#{r}")

