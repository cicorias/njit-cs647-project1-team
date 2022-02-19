SOURCES=caesar.s
OBJECTS=caesar.o
PRODUCT=caesar

uname_m := $(shell uname -m)
$(info uname_m=$(uname_m))
# 32 bit
LDFLAGS.i686=
ASFLAGS.i686=
# 64 bit
LDFLAGS.x86_64=-m elf_i386
ASFLAGS.x86_64=-32

# set for run
LDFLAGS += $(LDFLAGS.$(uname_m))
ASFLAGS += $(ASFLAGS.$(uname_m))


all: $(PRODUCT)

$(PRODUCT) : $(OBJECTS)
# ld -o $(PRODUCT) $(OBJECTS)
	ld $(LDFLAGS) -o $(PRODUCT) $(OBJECTS)

$(OBJECTS) : $(SOURCES)
	as $(ASFLAGS) -g -o $(OBJECTS) $(SOURCES)

clean:
	rm -f $(PRODUCT) $(OBJECTS)
