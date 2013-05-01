REPORTER = spec

test:
	./node_modules/.bin/mocha --compilers coffee:coffee-script spec.coffee --reporter $(REPORTER)

.PHONY: test
