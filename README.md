YLEP: YGGS Language Enhancement Pack
------------------------------------

[![Build Status](https://travis-ci.org/kt3k/ylep.png?branch=master)](https://travis-ci.org/kt3k/ylep)
[![Coverage Status](https://coveralls.io/repos/kt3k/ylep/badge.png?branch=master)](https://coveralls.io/r/kt3k/ylep)

It provides Function.prototype enhancement. See source code for detail.


```
  YLEP
    enable
      ✓ exists 
      ✓ is a function 
      ✓ defines E, branchGenerator and setBranchGenerator methods to Function.prototype 
    disable
      ✓ exists 
      ✓ is a function 
      ✓ deletes E, branchGenerator and setBranchGenerator of Function.prototype 
    E
      ✓ exists 
      ✓ is a function 
      E.call(obj, func)
        ✓ returns func(obj) (this means `func.E(decorator)` returns decorator(func).) 
    branchGenerator
      ✓ exists 
      ✓ is a function 
    setBranchGenerator
      ✓ exists 
      ✓ is a function
```
