class @Theme
	constructor: ->

		@themes = []

		#Vitamin C
		@themes.push
			background: '#004358'
			text: 'white'
			highlight1: '#FFE11A'
			highlight2: '#FFE11A'
			bold: '#FD7400'
			link: '#BEDB39'


		#Red and Smooth
		@themes.push
			background: '#191919'
			text: '#FBF7E4'
			highlight1: '#14CED3'
			highlight2: '#E8D069'
			bold: '#8E001C'
			link: '#E8D069'

		#Cote Azur
		@themes.push
			background: '#FFFCC4'
			text: '#00585F'
			highlight1: '#FF3800'
			highlight2: '#009393'
			bold: '#996C3D'
			link: '#14CC2F'

		#Cote Azur
		@themes.push
			background: '#221526'
			text: 'white'
			highlight1: '#911146'
			highlight2: '#ED8C2B'
			bold: '#CF4A30'
			link: '#ED8C2B'

		#BlackBoard
		@themes.push
			background: 'rgb(12, 16, 34)'
			text: 'rgb(248, 248, 248)'
			highlight1: 'rgb(92, 208, 46)'
			highlight2: 'rgb(140, 168, 208)'
			bold: 'rgb(252, 244, 0)'
			link: 'rgb(255,100,0)'
			
		# @themeCounter = Math.floor(Math.random()*@themes.length)
		@themeCounter = 0

	addTheme: (theme) ->
		@themes.push(theme)

	nextTheme: ->
		@themeCounter++
		if @themeCounter == @themes.length
			@themeCounter = 0

		@apply @themes[@themeCounter] 

	apply: (colors)->
		@applyColor(key, value) for key, value of colors 


	applyColor: (key, value)->
		console.log(key+' ')
		if key == 'background'
			$('body').css('background', value)	

		if key == 'text'
			$('body').css('color', value)

		$('.'+key).css('color', value)