express = require("express")
router = express.Router()
require("../../lib/models")()

# GET home page. 
router.get("/", (req, res) ->
	f = req.flash("info")
	
	res.render("home/index",{
		title: "Aimerthyst",
		pretty: true,
		flash: f[0]
	})
)

#会社概要のページ
router.get("/company",(req,res)->
	res.render("home/company",{
		title: "Company",
		pretty: true
	})
)


module.exports = router

