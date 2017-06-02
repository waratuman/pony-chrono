.PHONY: all build test clean

all: build

build:
	ponyc -p chrono -o build chrono

clean:
	rm -rf build

test:
	ponyc -p chrono --debug -o build chrono
	./build/chrono