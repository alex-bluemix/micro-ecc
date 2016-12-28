include atmega328p.mk
#include bbb.mk

PROJ=uECC

##
CC=$(CROSS_COMPILE)gcc
AR=$(CROSS_COMPILE)ar
OBJCOPY=$(CROSS_COMPILE)objcopy

ECC_SELECTION=-DuECC_SUPPORTS_secp160r1=0 \
							-DuECC_SUPPORTS_secp192r1=0 \
							-DuECC_SUPPORTS_secp224r1=0 \
							-DuECC_SUPPORTS_secp256r1=0 \
							-DuECC_SUPPORTS_secp256k1=1 \
							-DuECC_SUPPORT_COMPRESSED_POINT=1

CFLAGS+=-O1 $(ECC_SELECTION) -I.

all: static
	@echo "Finished."

## Libraries 
shared: lib$(PROJ).so
	@echo "Shared lib $^ created."

static: lib$(PROJ).a
	@echo "Static lib $< created."

lib$(PROJ).so: uECC.o
	$(GCC) -shared $^ -o $@

lib$(PROJ).a: uECC.o
	$(AR) crv $@ $^

test: test/test_compute.hex

%.hex: %.elf                                                                    
	$(OBJCOPY) -Oihex -R .eeprom $< $@
	
test/test_compute.elf: test/test_compute.o libuECC.a                                   
	$(CC) $(CFLAGS) -o $@ $^

## Build rules
%.o: %.c
	$(CC) $< -c $(CFLAGS) -o $@

## Clean up
clean:
	rm -rf *.o *.so *.a *.hex *.elf



