CC = gcc
CFLAGS = -g -Wall
OBJ = ultrasonic.o
LIBS = -lm

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

ultrasonic: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f *.o