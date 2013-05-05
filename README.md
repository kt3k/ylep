[![YLEP](https://raw.github.com/kt3k/ylep/master/ylep.png)](https://github.com/kt3k/ylep)

YLEP: YGGS Language Enhancement Pack
------------------------------------

[![Build Status](https://travis-ci.org/kt3k/ylep.png?branch=master)](https://travis-ci.org/kt3k/ylep)
[![Coverage Status](https://coveralls.io/repos/kt3k/ylep/badge.png?branch=master)](https://coveralls.io/r/kt3k/ylep)

It provides Function.prototype enhancement. See source code for detail.


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
