REPORTER = spec

test:
	@./node_modules/.bin/mocha --compilers coffee:coffee-script spec.coffee --reporter $(REPORTER)

cov:
	@YLEP_COVERAGE=1 $(MAKE) test REPORTER=html-cov > coverage.html

.PHONY: test
