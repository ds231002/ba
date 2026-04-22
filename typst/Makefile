START = yes '-' | tr -d '\n' | head -c 80 ; echo
END = $(START)

all: thesis

thesis:
	$(START)
	./compile_thesis.sh
	$(END)

watch:
	$(START)
	./compile_thesis_watch.sh
	$(END)

.PHONY: all thesis watch
