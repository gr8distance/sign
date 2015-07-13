express = require('express')
app = express.Router()
require('../../lib/models')()

app.get("/",(req,res)->
	
	Cotery.findAll(order: "updated_at desc").then((coteries)->
		v_coteries = []
		for cotery in coteries
			v_coteries.push cotery.dataValues

		res.render("coteries/index",{
			title: "サークル::Aimerthyst",
			current_user: req.session.current_user,
			coteries: v_coteries,
			btn: "cotery",
			flash: req.flash("info")[0]
		})
	)
)

##Show
app.get("/:id",(req,res)->
	id = req.params.id
	room_id = Cotery.hash("cotery_#{id}")
	
	Cotery.findById(id).then((cotery)->
		talks = []
		Talk.findAll(where: {room_id: room_id}).then((talks)->

			res.render("coteries/show",{
				title: "#{cotery.name}::Aimerthyst",
				cotery: cotery.dataValues,
				current_user: req.session.current_user,
				room_id: room_id,
				talks: talks
			})
		)
	).catch((err)->
		req.flash("info","サークルが見つからないよ(´・ω・｀)")
		res.redirect "/coteries"
	)
)

##Create
app.post("/",(req,res)->
	data = req.body
	Cotery.create({
		name: data.name,
		description: data.description,
		image: data.image,
		permit: data.permit
	}).then((cotery)->
		req.flash("info","Created")
		res.redirect("/coteries")
	).catch((err)->
		console.log err
		req.flash("info","何かが起こって失敗#{err}")
		res.redirect "/coteries"
	)
)



module.exports = app
