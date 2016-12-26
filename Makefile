
PROJ=uECC

## Compilers
GCC=gcc
AR=ar
CFLAGS= -fPIC

all: shared static

## Libraries 
shared: lib$(PROJ).so
	@echo "Shared lib $^ created."

static: lib$(PROJ).a
	@echo "Static lib $< created."

lib$(PROJ).so: uECC.o
	$(GCC) -shared $^ -o $@

lib$(PROJ).a: uECC.o
	$(AR) crv $@ $^

## Build rules
%.o: %.c
	$(GCC) $< -c $(CFLAGS) -o $@

## Clean up
clean:
	rm -rf *.o


