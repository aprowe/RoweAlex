class @RoweTerm

	constructor: (@element) ->
		$(@element).terminal (cmd, term) ->
			@program.run(cmd, term)
			@scroll()
			,
			greetings: ''
			prompt: ''
			name: 'comments'

		@terminal = $(@element).terminal()


	run: (programName) ->
		@program = eval('new '+programName)
		@program.init(@terminal)
		@terminal.resume()


	scroll: ->
		$("html, body").animate({ scrollTop: $(document).height() }, "fast");
		return false;

class Program

	init: (term) ->
	run: (cmd, term) ->
		term.

class @Poster extends Program

	init: (@term) ->
		@term.set_prompt 'name: '
		@name = ''
		@comment = ''
		@url = 'comment'

	run: (cmd, term) ->

		if cmd != '' and @name == ''
			@name = cmd;
			term.set_prompt 'comment: '
			return
		else if @name == ''
			term.error('error: name required')
			return

		if cmd != '' and @name != ''
			@comment = cmd;
			term.echo('submitting...')
			term.pause();
			@submit(@name, @comment)
			return

		else if @comment == ''
			term.error('error: comment body required')
			return

	@submit: ->
		$.ajax 
			url: 'comment'
			data: 
				name: @name
				comment: @comment
			success: (data)->
				@term.echo('[[;;;highlight1]'+data+']')
			error: (data)->
				@term.error(data)
			complete: (data)->
				@term.echo('process complete')
				@term.echo('')





	$('#comment').click ->
		$('.terminal').show()
		scroll()s
