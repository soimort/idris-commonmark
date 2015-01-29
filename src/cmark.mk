
CFLAGS		= -g -O3 -Wall -Wextra -std=c99 $(OPTFLAGS)
LDFLAGS		= -g -O3 -Wall -Werror -shared

CMARKDIR	= ../cmark
SRCDIR		= $(CMARKDIR)/src

.PHONY		= all clean

all: cmark.h buffer.h chunk.h references.h scanners.c cmark.o

clean:
	@make -C $(CMARKDIR) clean &>/dev/null
	rm -f cmark.h buffer.h chunk.h references.h scanners.c cmark.o

cmark.h:
	cp $(SRCDIR)/cmark.h .

buffer.h:
	cp $(SRCDIR)/buffer.h .

chunk.h:
	cp $(SRCDIR)/chunk.h .

references.h:
	cp $(SRCDIR)/references.h .

scanners.c:
	make -C $(CMARKDIR) ./cmark
	cp $(SRCDIR)/scanners.c .

cmark.o:
	make -C $(CMARKDIR) ./cmark
	$(LD) -r $(SRCDIR)/inlines.o $(SRCDIR)/buffer.o $(SRCDIR)/blocks.o $(SRCDIR)/print.o $(SRCDIR)/utf8.o $(SRCDIR)/references.o $(SRCDIR)/html/html.o $(SRCDIR)/html/houdini_href_e.o $(SRCDIR)/html/houdini_html_e.o $(SRCDIR)/html/houdini_html_u.o -o $@

# libcmark.so:
# 	@make -C $(CMARKDIR) clean &>/dev/null
# 	OPTFLAGS=-fpic make -C $(CMARKDIR) ./cmark
# 	$(CC) $(LDFLAGS) $(SRCDIR)/inlines.o $(SRCDIR)/buffer.o $(SRCDIR)/blocks.o $(SRCDIR)/print.o $(SRCDIR)/utf8.o $(SRCDIR)/references.o $(SRCDIR)/html/html.o $(SRCDIR)/html/houdini_href_e.o $(SRCDIR)/html/houdini_html_e.o $(SRCDIR)/html/houdini_html_u.o -o $@
