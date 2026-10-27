CC ?= cc
CFLAGS ?= -std=c11 -Wall -Wextra -g -O2

all: main

main: main.c
	$(CC) $(CFLAGS) -o $@ $<

test: main
	./main

clean:
	rm -f main

.PHONY: all test clean
