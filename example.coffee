{bornFromFile} = require './src'

global.opts =
	extAsFile: false

bornFromFile 'a.cson'
.then (cso)->
	console.log 'DONE'
.catch (e)->
	console.error e.stack
