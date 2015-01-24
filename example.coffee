{bornFromFile} = require './src'

global.opts =
	extAsFile: false

bornFromFile 'example.ash'
.then (cso)->
	console.log 'DONE'
.catch (e)->
	console.error e
