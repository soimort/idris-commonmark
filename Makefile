IDRIS := idris
PKG   := commonmark

build:
	$(IDRIS) --build ${PKG}.ipkg

install:
	$(IDRIS) --install ${PKG}.ipkg

clean:
	$(IDRIS) --clean ${PKG}.ipkg
	make -C src -f stmd.mk clean

rebuild: clean build

linecount:
	find . -name '*.idr' | xargs wc -l

doc:
	$(IDRIS) --mkdoc ${PKG}.ipkg

doc_clean:
	rm -rf ${PKG}_doc

.PHONY: build install clean rebuild linecount doc
