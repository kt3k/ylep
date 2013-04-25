/**
 * YLEP: YGGS Language Enhancement Pack
 */

this.YLEP = {
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

        return this;
    },

    branchGenerator: function (modifier) {
        'use strict';

        var parent = this;
        modifier = typeof modifier === 'function' ? modifier : function () {};

        // implement inheritance factory method pattern
        return function (additionals) {

            var exports = function () {
                return new ProxyConstructor(arguments);
            };

            var ProxyConstructor = function (args) {
                classPrototype.constructor.apply(this, args);
            };

            var classPrototype = ProxyConstructor.prototype = exports.prototype = new parent();

            var decorators = {};

            Object.keys(parent.decorators || {}).forEach(function (key) {
                decorators[key] = parent.decorators[key];
            });

            additionals(classPrototype, parent.prototype, decorators);

            modifier(classPrototype);

            exports.decorators = decorators;

            return exports;
        };
    }
};
