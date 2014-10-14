
@linkHover = (element1, element2, parent = false) ->

	$(element1).hover ->
		$(element2).show()
	, -> 
		$(element2).hide()
