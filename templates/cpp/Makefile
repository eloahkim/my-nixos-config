CXX ?= c++
CXXFLAGS ?= -std=c++20 -Wall -Wextra -g -O2

all: main

main: main.cpp
	$(CXX) $(CXXFLAGS) -o $@ $<

test: main
	./main

clean:
	rm -f main

.PHONY: all test clean
