$ ->

	w = $(window)
	parallax= $(".parallax-container")
	parallax_height = (parallax.height() * 0.666)
	parallax_img = $(".parallax img")

	w.scroll(->
		sc = $(@).scrollTop()
		if parallax_height < sc
			parallax_img.addClass("blur")
		else
			parallax_img.removeClass("blur")

	)
