[![YLEP](https://raw.github.com/kt3k/ylep/master/ylep.png)](https://github.com/kt3k/ylep)

# YLEP: Language Enhancement Pack

[![Build Status](https://travis-ci.org/kt3k/ylep.png?branch=master)](https://travis-ci.org/kt3k/ylep) [![Coverage Status](https://coveralls.io/repos/kt3k/ylep/badge.png?branch=master)](https://coveralls.io/r/kt3k/ylep)

It provides two functionality:

- add syntax for class inheritance
- add syntax for method decoration (similar to python's method decorator)

# Class Inheritance

```
var Klass = Object.branch(); // new class with equal functionality of Object

var Clazz = Object.branch(function (prototype) {

    prototype.say = function () {
        console.log('hello');
    };

});

var a = new Clazz();
a.say() // => prints "hello"
```

# Method Decorator

```
var Clazz = Object.branch(function (prototype) {

    prototype.say = function () {
        console.log('hello! ');
    }
    .E(Chainable);
    // method decoration by E syntax
    //
    // The above means `prototype.say = E(prototype.say);`
    //
    // This is same as python's decorator like:
    //
    // @Chainable
    // def say(): ...

});

var a = new Clazz();
a.say().say().say(); // prints "hello! hello! hello!"
```

# Author

Yosiya Hinosawa [@kt3k](https://twitter.com/kt3k)


# License

MIT License
http://kt3k.mit-license.org/



# Module Spec


```
  YLEP
    ✓ is a function 
    ✓ takes a func and execute it and inside it Function.prototype is extended with E, branchGenerator, setBranchGenerator 
    enable
      ✓ is a function 
      ✓ defines E, branchGenerator and setBranchGenerator methods to Function.prototype 
      ✓ do nothing when called twice 
    disable
      ✓ is a function 
      ✓ deletes E, branchGenerator and setBranchGenerator of Function.prototype 
      ✓ does nothing when called twice 
    executeOnContext
      ✓ is a function 
      ✓ takes a func and execute it and inside it Function.prototype is extended with E, branchGenerator, setBranchGenerator 
      ✓ doesn't disable YLEP context when enabled 

  Object.branch
    ✓ is a function 
    ✓ takes func and creates a class inherits Object. 
    takes function (prototype, parent, decorators) {}
      in which prototype
        ✓ is the prototype of created class 
      in which parent
        ✓ is the prototype of parent class 
      in which decorators
        ✓ equals cls.decorators 
        ✓ will be extended if extended inside branching function 

  inside YLEP(function() {...})
    func.E(decorator)
      ✓ returns decorator(func) 
    func.branchGenerator()
      ✓ returns branch generator 
    func.setBranchGenerator()
      ✓ returns func itself 
      ✓ sets func.branch a branch generator 
```
