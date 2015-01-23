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
	dirTree = (new Parser opts).parse str
	make dirTree.root

bornFromFile = (path, opts)->
	kit.readFile path
	.then (cson)->
		born cson + ''

module.exports = {
	born
	bornFromFile
	config: Parser.set
}
