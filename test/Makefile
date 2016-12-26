GCC=gcc
CFLAGS=-I../
LDFLAGS=

test: test_compute
	@echo "test_compute generated"

test_compute: test_compute.o ../libuECC.a
	$(GCC) $(LDFLAGS) -o $@ $^
	
	
%.o: %.c
	gcc -c $(CFLAGS) $< -o $@

clean:
	rm -rf *.o
