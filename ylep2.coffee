#
# YLEP: YGGS Language Enhancement Pack
#

@YLEP =
    enhancementList: ['E', 'branchGenerator', 'setBranchGenerator']

    enable: ->
        @enhancementList.forEach (keyword) =>
            Function.prototype[keyword] = @[keyword]

        return

    disable: ->
        @enhancementList.forEach (keyword) =>
            delete Function.prototype[keyword]

        return

    E: (decorator) ->
        decorator(this)

    setBranchGenerator: (modifier) ->
        @branch = @branchGenerator(modifier)
        return

    branchGenerator: (modifier) -> (additionals) =>
        exports = ->
            new ProxyConstructor(arguments)

        ProxyConstructor = (args) ->
            classPrototype.constructor.apply(this, args)
            return

        classPrototype = ProxyConstructor.prototype = exports.prototype = new this()

        additionals(classPrototype, @prototype)

        modifier?(additionals)

        return exports
