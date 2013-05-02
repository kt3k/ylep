REPORTER = spec

test:
	@./node_modules/.bin/mocha --compilers coffee:coffee-script spec.coffee --reporter $(REPORTER)

ylep-cov.js:
	@./node_modules/.bin/jscoverage ylep.js ylep-cov.js

cov: ylep-cov.js
	@YLEP_COVERAGE=1 $(MAKE) test REPORTER=html-cov > coverage.html
	@rm ylep-cov.js

test-coveralls: ylep-cov.js
	echo TRAVIS_JOB_ID $(TRAVIS_JOB_ID)
	@YLEP_COVERAGE=1 $(MAKE) test REPOTER=mocha-lcov-reporter | ./node_modules/.bin/coveralls
	@rm ylep-cov.js

.PHONY: test
