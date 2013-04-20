/**
 * YLEP: YGGS Language Enhancement Pack
 */

window.YLEP = {
    enhancementList: ['branchGenerator', 'setBranchGenerator', 'E'],

    enable: function () {
        this.enhancementList.forEach(function (keyword) {
            Function.prototype[keyword] = this[keyword];
        }, this);
    },

    disable: function () {
        this.enhancementList.forEach(function (keyword) {
            delete Function.prototype[keyword];
        });
    },

    E: function (decorator) {
        return decorator(this);
    },

    setBranchGenerator: function (modifier, branchName) {
        if (branchName == null) {
            branchName = 'branch';
        }

        this[branchName] = this.branchGenerator(modifier);
    },

    branchGenerator: function (modifier) {

        var parent = this;
        modifier = typeof modifier === 'function' ? modifier : function () {};

        // implement inheritance factory method pattern
        return function (additionals) {

            return (function () {
                var exports = function () {
                    return new ProxyConstructor(arguments);
                };

                var ProxyConstructor = function (args) {
                    constructor.apply(this, args);
                };

                var constructor = additionals.constructor || parent;
                delete additionals.constructor;

                constructor.parent = parent;

                var classPrototype = ProxyConstructor.prototype = exports.prototype = new parent();

                classPrototype.constructor = constructor;

                Object.keys(additionals).forEach(function (key) {
                    classPrototype[key] = additionals[key];
                });

                modifier(classPrototype);

                return exports;
            }());
        };
    }
};
