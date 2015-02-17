# Idris-CommonMark

This is a direct [Idris](http://www.idris-lang.org/) wrapper of jgm's [cmark](https://github.com/jgm/cmark) library, a C implementation of [CommonMark](http://commonmark.org/).

**WARNING**: This baby never works the way you want it to. Basically you'll be eaten up by all the `segmentation fault` things.

Installation:

    $ git submodule init
    $ git submodule update
    $ make install

If you are lucky, you can get the provided demo running: (if you are not, you will get a segfault then!)

    $ idris -p commonmark -o Demo Demo.idr
    $ ./Demo > Demo.html
