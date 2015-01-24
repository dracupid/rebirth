kit = require 'nokit'
Promise = kit.Promise
Parser = require './parser'

make = (node)->
	maker = if node.isDir then 'mkdirs' else 'touch'
	kit[maker] node.path
	.then ->
		Promise.all node.children.map (n)->
			make n

born = (str, opts)->
	parser = new Parser opts
	dirTree = parser.parse str
	make dirTree.root
	.then ->
		process.chdir parser.options.cwd
		kit.log "Start to execute hook: ".green
		kit.exec parser.hook
	.then ({stdout})->
		stdout and console.log stdout
		kit.log "Finished...".green
	.catch (err)->
		kit.err "ERROR: ".red + err.stderr.red  # + "[code: #{err.code}, signal: #{err.signal}]".cyan
		Promise.reject err

bornFromFile = (path, opts)->
	kit.readFile path
	.then (cson)->
		born cson + ''

module.exports = {
	born
	bornFromFile
	config: Parser.set
}
