
CFLAGS		= -g -O3 -Wall -Wextra -std=c99 $(OPTFLAGS)
LDFLAGS		= -g -O3 -Wall -Werror -shared

STMDDIR		= ../stmd
SRCDIR		= $(STMDDIR)/src

.PHONY		= all clean

all: bstrlib.h stmd.h uthash.h stmd.o libstmd.so

clean:
	@make -C $(STMDDIR) clean &>/dev/null
	rm -f bstrlib.h stmd.h uthash.h stmd.o libstmd.so

bstrlib.h:
	cp $(SRCDIR)/bstrlib.h .

stmd.h:
	cp $(SRCDIR)/stmd.h .

uthash.h:
	cp $(SRCDIR)/uthash.h .

stmd.o:
	@make -C $(STMDDIR) clean &>/dev/null
	make -C $(STMDDIR) all
	$(LD) -r $(SRCDIR)/inlines.o $(SRCDIR)/blocks.o $(SRCDIR)/detab.o $(SRCDIR)/bstrlib.o $(SRCDIR)/scanners.o $(SRCDIR)/print.o $(SRCDIR)/html.o $(SRCDIR)/utf8.o -o $@

libstmd.so:
	@make -C $(STMDDIR) clean &>/dev/null
	OPTFLAGS=-fpic make -C $(STMDDIR) all
	$(CC) $(LDFLAGS) $(SRCDIR)/inlines.o $(SRCDIR)/blocks.o $(SRCDIR)/detab.o $(SRCDIR)/bstrlib.o $(SRCDIR)/scanners.o $(SRCDIR)/print.o $(SRCDIR)/html.o $(SRCDIR)/utf8.o -o $@
