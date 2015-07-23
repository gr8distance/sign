data = require("./socket")
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

