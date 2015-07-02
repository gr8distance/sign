express = require("express")
router = express.Router()

# GET home page. 
router.get("/", (req, res) ->
	f = req.flash("info")

	res.render("home/index",{
		title: "Aimerthyst",
		flash: f[0]
	})
)


router.get("/company",(req,res)->
	res.render("home/company",{
		title: "Company",
		pretty: true
	})
)


module.exports = router
