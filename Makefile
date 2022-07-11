.DEFAULT_GOAL := build

clean:
	echo "clean is enabled" && \
	rm -rf dist

build-web: clean
	echo "build-web is running..." && \
	mkdir dist && \
	cd web && \
	npm i && \
	npm run build && \
	cp -r ./dist/* ../dist/ && \
	echo "build-web is done."

build: build-web
	echo "build is running..."