CROSS_COMPILE?=avr-
MCU=-mmcu=atmega328p

CFLAGS=$(MCU) -std=c99

