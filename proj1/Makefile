CC = gcc
CFLAGS = -std=c99 -Wall -pedantic -g

all: proj1

proj1: proj1.o
	${CC} -o $@ ${CFLAGS} $^ -lm

proj1.o: proj1.c proj1.h
