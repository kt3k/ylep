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

    enableEFunction: function () {
        'use strict';
        Function.prototype.E = YLEP.E;
    },

    disableEFunction: function () {
        'use strict';
        delete Function.prototype.E;
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

            YLEP.enableEFunction();

            additionals.call(exports, classPrototype, parent.prototype, decorators);

            modifier.call(exports, classPrototype);

            YLEP.disableEFunction();

            if (classPrototype.constructor !== parent.prototype.constructor) {
                classPrototype.constructor.prototype = classPrototype;
            }

            exports.decorators = decorators;

            return exports;
        };
    }
};

YLEP.enable();
Object.setBranchGenerator();
YLEP.disable();