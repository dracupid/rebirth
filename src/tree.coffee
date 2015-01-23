class TreeNode
	constructor: (@path, @level)->
		@children = []
		@parent = null
		@
	setParent: (@parent)->
		@
	addChild: (child)->
		@children.push child
		@

class Tree
	constructor: (@root)->
		@lastOfLevel = [@root]
		@

module.exports = {
	TreeNode
	Tree
}