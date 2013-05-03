chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
chai.use sinonChai

if process.env.YLEP_COVERAGE
  dir = './ylep-cov'
else
  dir = './ylep'

YLEP = require(dir).YLEP

describe 'YLEP', ->

  it 'is a function', ->
    expect(YLEP).to.be.a 'function'

  it 'takes a func and execute it and inside it Function.prototype is extended with E, branchGenerator, setBranchGenerator', ->
    YLEP ->
      a = ->
      expect(a.E).to.be.a 'function'
      expect(a.branchGenerator).to.be.a 'function'
      expect(a.setBranchGenerator).to.be.a 'function'

  describe 'enable', ->

    it 'is a function', ->
      expect(YLEP.enable).to.be.a 'function'

    it 'defines E, branchGenerator and setBranchGenerator methods to Function.prototype', ->
      expect(Function.prototype.E).to.not.exist
      expect(Function.prototype.branchGenerator).to.not.exist
      expect(Function.prototype.setBranchGenerator).to.not.exist
      YLEP.enable()
      expect(Function.prototype.E).to.be.a 'function'
      expect(Function.prototype.branchGenerator).to.be.a 'function'
      expect(Function.prototype.setBranchGenerator).to.be.a 'function'

    it 'do nothing when called twice', ->
      expect(Function.prototype.E).to.be.a 'function'
      expect(Function.prototype.branchGenerator).to.be.a 'function'
      expect(Function.prototype.setBranchGenerator).to.be.a 'function'
      YLEP.enable()
      expect(Function.prototype.E).to.be.a 'function'
      expect(Function.prototype.branchGenerator).to.be.a 'function'
      expect(Function.prototype.setBranchGenerator).to.be.a 'function'

  describe 'disable', ->

    it 'is a function', ->
      expect(YLEP.disable).to.be.a 'function'

    it 'deletes E, branchGenerator and setBranchGenerator of Function.prototype', ->
      expect(Function.prototype.E).to.exist
      expect(Function.prototype.branchGenerator).to.exist
      expect(Function.prototype.setBranchGenerator).to.exist
      YLEP.disable()
      expect(Function.prototype.E).to.not.exist
      expect(Function.prototype.branchGenerator).to.not.exist
      expect(Function.prototype.setBranchGenerator).to.not.exist

    it 'does nothing when called twice', ->
      expect(Function.prototype.E).to.not.exist
      expect(Function.prototype.branchGenerator).to.not.exist
      expect(Function.prototype.setBranchGenerator).to.not.exist
      YLEP.disable()
      expect(Function.prototype.E).to.not.exist
      expect(Function.prototype.branchGenerator).to.not.exist
      expect(Function.prototype.setBranchGenerator).to.not.exist

  describe 'executeOnContext', ->

    it 'is a function', ->
      expect(YLEP.executeOnContext).to.be.a 'function'

    it 'takes a func and execute it and inside it Function.prototype is extended with E, branchGenerator, setBranchGenerator', ->
      YLEP.executeOnContext ->
        a = ->
        expect(a.E).to.be.a 'function'
        expect(a.branchGenerator).to.be.a 'function'
        expect(a.setBranchGenerator).to.be.a 'function'

    it "doesn't disable YLEP context when enabled", ->
      YLEP.enable()

      YLEP.executeOnContext ->

      expect(Function.prototype.E).to.exist
      expect(Function.prototype.branchGenerator).to.exist
      expect(Function.prototype.setBranchGenerator).to.exist

describe 'Object.branch', ->

  it 'is a function', ->
    expect(Object.branch).to.be.a 'function'

  it 'takes func and creates a class inherits Object.', ->
    cls = Object.branch(->)
    expect(cls).to.be.a 'function'
    expect(new cls()).to.be.instanceof cls
    expect(cls()).to.be.instanceof cls
    expect(new cls()).to.be.instanceof Object
    expect(cls()).to.be.instanceof Object

  describe 'takes function (prototype, parent, decorators) {}', ->

    describe 'in which prototype', ->

      it 'is the prototype of created class', ->

        x = null

        cls = Object.branch (prototype, parent, decorators) ->

          x = prototype
          prototype.constructor = ->

        expect(cls.prototype).to.equals x
        expect(new cls()).to.be.instanceof cls
        expect(cls()).to.be.instanceof cls
        expect(new cls.prototype.constructor).to.be.instanceof cls

    describe 'in which parent', ->

      it 'is the prototype of parent class', ->

        Object.branch (prototype, parent, decorators) ->
          expect(parent).to.equals Object.prototype

    describe 'in which decorators', ->

      it 'equals cls.decorators', ->

        x = null

        cls = Object.branch (prototype, parent, decorators) ->
          x = decorators

        expect(x).to.equals cls.decorators

      it 'will be extended if extended inside branching function', ->

        x = ->

        cls = Object.branch (prototype, parent, decorators) ->
          decorators.abc = x

        expect(cls.decorators.abc).to.equals x

      it 'inherits parent decorators if parent have decorators', ->

        y = ->

        parent = Object.branch (prototype, parent, decorators) ->
          decorators.abc = y
          this.setBranchGenerator()

        parent.branch (prototype, parent, decorators) ->
          expect(decorators.abc).to.equals y

describe 'inside YLEP(function() {...})', ->

  describe 'func.E(decorator)', ->

    it 'returns decorator(func)', ->

      func = ->
      dummy = {}
      spy = sinon.spy(sinon.stub().returns dummy)

      YLEP ->
        expect(func.E(spy)).to.equals dummy

      expect(spy).to.have.been.calledWith func

  describe 'func.branchGenerator()', ->

    it 'returns branch generator', ->

      YLEP ->
        expect((->).branchGenerator()).to.be.a 'function'

  describe 'func.setBranchGenerator()', ->

    it 'returns func itself', ->

      func = ->

      YLEP ->
        expect(func.setBranchGenerator()).to.equals func

    it 'sets func.branch a branch generator', ->

      func = ->

      YLEP ->
        func.setBranchGenerator()

      expect(func.branch).to.be.a 'function'
