chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
chai.use sinonChai

YLEP = require('./ylep').YLEP

describe 'YLEP', ->
  describe 'enable', ->
    it 'exists', ->
      expect(YLEP.enable).to.exist

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

  describe 'disable', ->
    it 'exists', ->
      expect(YLEP.disable).to.exist

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

  describe 'E', ->
    it 'exists', ->
      expect(YLEP.E).to.exist

    it 'is a function', ->
      expect(YLEP.E).to.be.a 'function'

    describe 'E.call(obj, func)', ->
      it 'returns func(obj) (this means `func.E(decorator)` returns decorator(func).)', ->
        a = {}
        b = {}
        spy = sinon.spy -> a

        expect(YLEP.E.call b, spy).to.equal a
        expect(spy).have.been.calledOnce
        expect(spy).have.been.calledWith b

  describe 'branchGenerator', ->
    it 'exists', ->
      expect(YLEP.branchGenerator).to.exist

    it 'is a function', ->
      expect(YLEP.branchGenerator).to.be.a 'function'

  describe 'setBranchGenerator', ->
    it 'exists', ->
      expect(YLEP.setBranchGenerator).to.exist

    it 'is a function', ->
      expect(YLEP.setBranchGenerator).to.be.a 'function'
