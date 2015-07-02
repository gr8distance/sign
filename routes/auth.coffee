express = require("express")
router = express.Router()

router.post("/process",(req,res)->
	req.flash('info', 'Flash is back!')
	res.redirect("/")
)



module.exports = router
