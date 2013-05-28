/**
 * YLEP: YGGS Language Enhancement Pack
 */

var YLEP = this.YLEP = (function () {

    var YLEP = function (func) {
        YLEP.executeOnContext(func);
    };

    YLEP.__enabled__ = false;

    YLEP.enhancementList = ['branchGenerator', 'setBranchGenerator', 'E'];

    YLEP.enable = function () {
        if (this.__enabled__) {
            return;
        }

        this.__enabled__ = true;

        this.enhancementList.forEach(function (keyword) {
            this['__' + keyword] = Function.prototype[keyword];
            Function.prototype[keyword] = this.extensions[keyword];
        }, this);
    },

    YLEP.disable = function () {
        if (!this.__enabled__) {
            return;
        }

        this.__enabled__ = false;

        this.enhancementList.forEach(function (keyword) {
            Function.prototype[keyword] = this['__' + keyword];
            delete this['__' + keyword];
        }, this);
    };

    YLEP.executeOnContext = function (func) {
        if (YLEP.__enabled__) {
            func();
        } else {
            YLEP.enable();
            func();
            YLEP.disable();
        }
    };

    var extensions = YLEP.extensions = {};

    extensions.E = function (decorator) {
        return decorator(this);
    };

    extensions.setBranchGenerator = function (modifier, branchName) {
        if (branchName == null) {
            branchName = 'branch';
        }

        this[branchName] = this.branchGenerator(modifier);

        return this;
    };

    extensions.branchGenerator = function (modifier) {
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
    };

    return YLEP;
}());

YLEP(function () {
    Object.setBranchGenerator();

    Object.decorators = {};

    Object.decorators.Chainable = function (func) {
        return function () {
            func.apply(this, arguments);

            return this;
        };
    };
});
