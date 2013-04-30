REPORTER = nyan

test:
	./node_modules/mocha/bin/mocha --compilers coffee:coffee-script spec.coffee --reporter $(REPORTER)

.PHONY: test
