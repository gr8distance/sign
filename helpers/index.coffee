crypto = require("crypto")


module.exports = {
	
	#クッキーを設定する
	set_cookie: (res,k,v,time=66600) ->
		res.cookie(k,v,{maxAge: time})
	
	#クッキーを解析する
	get_cookie: (req,k) ->
		return req.cookies[k]

	#HASHを生成する
	hash: (val) ->
		sha = crypto.createHash("sha512")
		sha.update(val)
		return sha.digest("hex")

	
	


}
