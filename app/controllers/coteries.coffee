express = require('express')
app = express.Router()
require('../../lib/models')()

app.get("/",(req,res)->
	
	if req.session.current_user?
		Cotery.findAll(order: "updated_at desc").then((coteries)->
			v_coteries = []
			for cotery in coteries
				v_coteries.push cotery.dataValues
			
			Permit.findAll(where: {model_name: "Cotery",user_id: req.session.current_user.id}).then((permits)->
				permits_array = []
				v_permits = []
				for permit in permits
					v_permits.push permit.dataValues.model_id
					permits_array.push permit.dataValues

				console.log v_permits
				res.render("coteries/index",{
					title: "サークル::Aimerthyst",
					current_user: req.session.current_user,
					coteries: v_coteries,
					btn: "cotery",
					flash: req.flash("info")[0],
					permits_array: permits_array,
					permits: v_permits
				})
			)
		)
	else
		req.flash "info","ログインになにか問題が発生しました"
		res.redirect "/"
)

##Show
app.get("/:id",(req,res)->
	id = req.params.id
	room_id = Cotery.hash("cotery_#{id}")
	
	Cotery.findById(id).then((cotery)->


		#管理者権限が必要な掲示板かどうかを確認する
		#必要なければそのまま表記
		if cotery.permit
			users = []
			Permit.findAll(where: {model_name: "Cotery",model_id: cotery.id}).then((permits)->
				#for permit in permits
				#	users.push permit.dataValues
				Talk.findAll(where: {room_id: room_id},limit: 54,order: "updated_at desc").then((talks)->
					res.render("coteries/show",{
						title: "#{cotery.name}::Aimerthyst",
						cotery: cotery.dataValues,
						current_user: req.session.current_user,
						room_id: room_id,
						talks: talks,
						users: users
					})
				)
			)
			#このコードは事実上完成
			#
		else
			#管理者権限が必要な場合は下記
			#まずは自分に参加権限が存在するかをテストする
			Permit.findOne(where: {model_name: "Cotery",model_id: cotery.id,user_id: req.session.current_user.id}).then((permit)->
				if permit.permit
					#参加権限がある場合のコード
					users = []
					Permit.findAll(where: {model_name: "Cotery",model_id: cotery.id}).then((permits)->
						for permit in permits
							unless permit.dataValues.permit
								users.push permit.dataValues
						Talk.findAll(where: {room_id: room_id},limit: 54,order: "updated_at desc").then((talks)->
							res.render("coteries/show",{
								title: "#{cotery.name}::Aimerthyst",
								cotery: cotery.dataValues,
								current_user: req.session.current_user,
								room_id: room_id,
								talks: talks,
								users: users
							})
						)
					)
				else
					#参加権限がない場合はトップへリダイレクト　
					req.flash "info","参加権限がありません"
					res.redirect "/coteries/"
			).catch((e)->
				req.flash "info","参加権限を確認中にエラーが発生しました(´・ω・｀)"
				res.redirect "/coteries"
			)
	).catch((err)->
		req.flash "info","サークルが見つかりません"
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
		User.findById(data.user_id).then((user)->
			Permit.create({
				model_name: "Cotery",
				model_id: cotery.dataValues.id,
				user_id: data.user_id,
				permit: true,
				user_name: user.dataValues.name,
				user_image: user.dataValues.image
			}).then((p)->
				req.flash("info","Created")
				res.redirect("/coteries")
			)
		)
	).catch((err)->
		console.log err
		req.flash("info","何かが起こって失敗#{err}")
		res.redirect "/coteries"
	)
)

#permitカラムをtrueにする
app.post("/add_permit",(req,res)->
	data = req.body
	Permit.findOne(where: {user_id: data.permit_user_id,model_name: "Cotery",model_id: data.cotery_id}).then((permit)->
		#管理者権限を持っていることを確認する
		if permit? && permit.permit
			Permit.findOne(where: {user_id: data.user_id,model_id: data.cotery_id,model_name: "Cotery"}).then((perm)->
				perm.updateAttributes({permit: true}).then((pp)->
					data.state = true
					data.flash = "#{data.user_name}さんに参加権限を与えました"
					res.json data
				).catch((e)->
					data.state = false
					data.flash = "参加権限の取得に失敗しました。"
					console.log e
					res.json data
				)
			)
		else
			#管理者権限を持っていないのでサークルに戻す
			data.state = false
			data.flash = "管理者権限がありません "
			res.json data
	)
)

#permitカラムを抹消する
app.post("/remove_permit",(req,res)->
	data = req.body

	Permit.find(where: {user_id: data.permit_user_id,model_name: "Cotery",model_id: data.cotery_id}).then((permit)->
		if permit? && permit.permit
			console.log "He has permit"
			Permit.findOne(where: user_id: data.user_id,model_id: data.cotery_id,model_name: "Cotery").then((permit)->
				if permit? && permit.permit
					permit.destroy()
					data.state = true
					data.flash = "参加権限を剥奪しました"
					res.json data
					#console.log "Destroyed"
					#res.redirect "/coteries/#{data.cotery_id}"
				else
					data.state = false
					data.flash = "参加権限の剥奪に失敗しました"
					res.json data
					#console.log "Undeleted"
					#res.redirect "/coteries/#{data.cotery_id}"
			)
		else
			data.state = false
			data.flash = "権限を削除する権限を持っていません。"
			res.json data
			#req.flash "info","He has not permit!"
			#res.redirect "/coteries/#{data.cotery_id}"
	)
)

#パーミッションを取得する
app.post("/get_permit",(req,res)->
	data =req.body
	Permit.findAll(where: {model_id: data.cotery_id,user_id: data.user_id,model_name: "Cotery"}).then((permits)->
		if permits.length >= 1
			d = {
				state: false,
				flash: "すでに参加申請済みです"
			}
			res.json d
		else
			User.findById(data.user_id).then((user)->
				Permit.create({
					model_name: "Cotery",
					model_id: data.cotery_id,
					user_id: data.user_id,
					user_name: user.dataValues.name,
					user_image: user.dataValues.image
				}).then((cotery)->
					d = {
						state: true,
						flash: "参加権を申請しました"
					}
					res.json d
					
					Permit.findAll(where: {model_name: "Cotery",model_id: data.cotery_id, permit: true}).then((permits)->
						for u in permits
							console.log u.dataValues

							Notification.create({
								user_name: user.name,
								user_image: user.image,
								message: "#{user.name}さんがサークルに参加を申請しました",
								model_name: "coteries",
								model_id: data.cotery_id,
								pushed: false,
								user_id: u.user_id
							})
					)
				).catch((e)->
					d = {
						state: false,
						flash: "参加申請に失敗しました。"
					}
					res.json d
				)
			)
	)
)


module.exports = app
