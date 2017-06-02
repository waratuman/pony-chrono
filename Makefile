.PHONY: all build test clean

all: build

build:
	stable env ponyc -p chrono -o build chrono

clean:
	rm -rf build

test:
	stable env ponyc -p chrono --debug -o build chrono
	./build/chrono