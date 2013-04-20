/**
 * YLEP: YGGS Language Enhancement Pack
 */

window.YLEP = {
    enhancementList: ['branchGenerator', 'setBranchGenerator', 'E'],

    enable: function () {
        'use strict';
        this.enhancementList.forEach(function (keyword) {
            Function.prototype[keyword] = this[keyword];
        }, this);
    },

    disable: function () {
        'use strict';
        this.enhancementList.forEach(function (keyword) {
            delete Function.prototype[keyword];
        });
    },

    E: function (decorator) {
        'use strict';
        return decorator(this);
    },

    setBranchGenerator: function (modifier, branchName) {
        'use strict';

        if (branchName == null) {
            branchName = 'branch';
        }

        this[branchName] = this.branchGenerator(modifier);
    },

    branchGenerator: function (modifier) {
        'use strict';

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
