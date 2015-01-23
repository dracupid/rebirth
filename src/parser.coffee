{_} = require 'nokit'

{TreeNode, Tree} = require './tree'

kit = require 'nokit'

defaultOptions =
    extAsFile: false
    tab: 4
    indent: 4
    cwd: process.cwd()

set = (opt, value)->
    if arguments.length is 1 and _.isObject opt
        _.assign options, opt
    else if arguments.length is 2 and _.isString opt
        options[opt] = value
    null

class Parser
    constructor: (@options = {})->
        _.defaults @options, defaultOptions
        @dirTree = new Tree new TreeNode @options.cwd, 0

    isOption: (l)->
        /^#+[\w\d]+=[\w\d]+$/.test l.replace /\s|;/g, ''

    isComment: (l)->
        l.trim()[0] is '#'

    parseOption: (l)->
        kv = (@isOption(l) and l.replace(/\s|;/g, '')[1...].split '=')
        if kv and kv[1]
            if /^true|yes$/i.test kv[1] then kv[1] = yes
            if /^false|no$/i.test kv[1] then kv[1] = no
        kv

    isDir: (p)->
        p = p.trim()
        (p[p.length - 1] is '/') or (@options.extAsFile and p.lastIndexOf('.') < 0)

    parseStruc: (path, lineNum)->
        path = path.replace /\t/g, (new Array(1 + parseInt @options.tab)).join ' '
        space = path.length - path.replace(/^ */g, '').length

        if space % @options.indent isnt 0
            console.error "Wrong Indent in line: #{lineNum}, #{space}"
            process.exit 1

        level = 1 + space / @options.indent

        node = new TreeNode path.trim(), level
        node.isDir = @isDir path

        node.parent = @dirTree.lastOfLevel[level - 1]
        node.parent.addChild(node).isDir = true
        node.path = kit.path.join node.parent.path, node.path
        @dirTree.lastOfLevel[level] = node

        node

    parseLine: (l, lineNum)->
        if not l then return
        if @isComment l
            [k, v] = @parseOption l
            @options[k] = v
        else
            @parseStruc l, lineNum + 1

    parse: (str)->
        str.split('\n').forEach (line, index)=>
            @parseLine line, index
        @dirTree

Parser.set = set

module.exports = Parser
