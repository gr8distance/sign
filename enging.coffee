data = require("./socket")
cluster = require('cluster')
numCPUs = require('os').cpus().length


if cluster.isMaster
	for i in [0...numCPUs]
		cluster.fork()
else
	try
		switch data.env
			when "development"
				data.http.listen(3000,->
					console.log "Server is running!"
					console.log "development"
				)
			when "production"
				data.http.listen(80,->
					console.log "Server is running!"
					console.log "Production"
				)
	catch err
		console.log err
	
