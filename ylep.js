/**
 * YLEP: YGGS Language Enhancement Pack
 */

this.YLEP = {
    enhancementList: ['branchGenerator', 'setBranchGenerator', 'E'],

    __enabled__: false,

    enable: function () {
        'use strict';

        if (this.__enabled__) {
            return;
        }

        this.__enabled__ = true;

        this.enhancementList.forEach(function (keyword) {
            this['__' + keyword] = Function.prototype[keyword];
            Function.prototype[keyword] = this[keyword];
        }, this);
    },

    disable: function () {
        'use strict';

        if (!this.__enabled__) {
            return;
        }

        this.__enabled__ = false;

        this.enhancementList.forEach(function (keyword) {
            Function.prototype[keyword] = this['__' + keyword];
            delete this['__' + keyword];
        }, this);
    },

    E: function (decorator) {
        'use strict';
        return decorator(this);
    },

    executeOnContext: function (func) {
        if (YLEP.__enabled__) {
            func();
        } else {
            YLEP.enable();
            func();
            YLEP.disable();
        }
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

            YLEP.executeOnContext(function () {
                additionals.call(exports, classPrototype, parent.prototype, decorators);
                modifier.call(exports, classPrototype);
            });

            if (classPrototype.constructor !== parent.prototype.constructor) {
                classPrototype.constructor.prototype = classPrototype;
            }

            exports.decorators = decorators;

            return exports;
        };
    }
};

this.YLEP.executeOnContext(function () {
    Object.setBranchGenerator();
});
