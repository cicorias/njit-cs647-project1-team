SOURCES=caesar.s
OBJECTS=caesar.o
PRODUCT=caesar

all: $(PRODUCT)

$(PRODUCT) : $(OBJECTS)
	ld -o $(PRODUCT) $(OBJECTS)
# ld -m elf_i386 -o $(PRODUCT) $(OBJECTS)

$(OBJECTS) : $(SOURCES)
	as -g -o $(OBJECTS) $(SOURCES)

clean:
	rm -f $(PRODUCT) $(OBJECTS)
