.PHONY: test
test:
	NODE_PATH=/usr/local/share/npm/lib/node_modules mocha --compilers coffee:coffee-script spec.coffee --reporter spec
