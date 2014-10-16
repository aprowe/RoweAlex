class @RoweTerm

	constructor: (@element) ->
		$(@element).terminal (cmd, term) =>
			@program.run(cmd, term)
			@scroll()
		,
			greetings: ''
			prompt: ''
			name: 'comments'
			height: 'auto'

		@terminal = $(@element).terminal()


	run: (programName) ->
		@program = eval('new '+programName)
		@program.init(@terminal)
		@terminal.focus()
		@terminal.resume()
		@scroll()


	scroll: ->
		$("html, body").animate({ scrollTop: $(document).height() }, "fast");
		return

class Program

	init: (@term) ->
		@complete = false
	run: (cmd, term) ->

	finish: ->
		@complete = true
		@term.echo('process complete')
		@term.echo('')
		@term.pause()


class Poster extends Program

	init: (@term) ->
		super
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
			console.log(this)
			@comment = cmd;
			term.echo('submitting...')
			term.pause();
			@submit(@name, @comment)
			@finish
			return

		else if @comment == ''
			term.error('error: comment body required')
			return

	submit: ->
		$.ajax 
			url: 'comment'
			data: 
				name: @name
				comment: @comment
			success: (data) =>
				@term.echo('[[;;;highlight1]'+data+']')
			error: (data) =>
				@term.error(data)
			complete: (data) =>
				@term.echo('process complete')
				@term.echo('')

class Viewer extends Program

	init: (@term)->
		super
		@term.set_prompt('>')
		@view = 0
		@amount = 10
		@term.echo('Fetching Comments...')
		@fetchComments()

	fetchComments: ->
		$.ajax
			url: 'viewComments'
			data: 
				start: @view += @amount
				amount: @amount
			dataType: 'json'
			success: (data) =>
				if @view == @amount
					@term.echo "#{data.count} comments found" 

				@printComment comment for key, comment of data.comments
				
				if data.done
					@finish()
				else
					@term.set_prompt 'enter to view more, q to quit '

	printComment: (comment) ->
		console.log(comment)
		# str = comment.id+' '
		str = '  [[;;;highlight1]'+comment.name+']: '
		str += '[[;;;bold]'+comment.body+'] '
		@term.echo str

	run: (cmd,term)->
		if cmd == 'DELETE ALL COMMENTS PLEASE'
			$.ajax
				url: 'deleteComments'
				data:
					all: true
				success: (data)=>
					term.echo data
					@finish()
			return

		if cmd != 'q' && cmd != 'Q'
			@fetchComments()
			return
		else
			@finish()
			return
