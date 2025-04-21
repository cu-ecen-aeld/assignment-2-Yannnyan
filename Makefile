SRC := finder-app/writer.c
TARGET = finder-app/writer
OBJS := $(SRC:.c=.o)
CC := gcc
LDFLAGS := -Wl,-V
all: $(TARGET)

$(TARGET) : $(OBJS)
	$(CROSS_COMPILE)$(CC) finder-app/writer.c -o finder-app/writer

example: 
	$(CROSS_COMPILE)$(CC) example.c -o example 

clean:
	-rm -f *.o $(TARGET) *.elf *.map finder-app/*.o writer example
