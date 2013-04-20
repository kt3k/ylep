#
# YLEP: YGGS Language Enhancement Pack
#

window.YLEP =
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
            constructor.apply(this, args)
            return

        parent = this
        additionals or= {}

        constructor = additionals.constructor ? parent
        delete additionals.constructor

        constructor.parent = parent

        classPrototype = ProxyConstructor.prototype = exports.prototype = new parent()

        classPrototype.constructor = constructor

        modifier?(additionals)

        for key, property of additionals
            classPrototype[key] = property

        return exports
