CC = $(PTHREAD_CC)

AM_CPPFLAGS = -D_GNU_SOURCE

AM_CFLAGS = \
	-Wall \
	-Wextra \
	-Wpointer-arith \
	-Wcast-qual \
	-Wmissing-prototypes \
	-Wformat=2 \
	-Wshadow \
	-std=gnu89 \
	$(PTHREAD_CFLAGS) \
	$(PCRE_CFLAGS) \
	$(LZMA_CFLAGS) \
	$(ZLIB_CFLAGS)

LDADD = \
	$(PCRE_LIBS) \
	$(LZMA_LIBS) \
	$(ZLIB_LIBS) \
	$(PTHREAD_LIBS)

bin_PROGRAMS = ag
ag_SOURCES = \
	src/decompress.c \
	src/decompress.h \
	src/ignore.c \
	src/ignore.h \
	src/lang.c \
	src/lang.h \
	src/log.c \
	src/log.h \
	src/main.c \
	src/options.c \
	src/options.h \
	src/print.c \
	src/print.h \
	src/print_w32.c \
	src/scandir.c \
	src/scandir.h \
	src/search.c \
	src/search.h \
	src/uthash.h \
	src/util.c \
	src/util.h \
	src/zfile.c

dist_man_MANS = doc/ag.1

bashcompdir = $(pkgdatadir)/completions
dist_bashcomp_DATA = ag.bashcomp.sh
zshcompdir = $(datadir)/zsh/site-functions
dist_zshcomp_DATA = _the_silver_searcher

EXTRA_DIST = \
	bootstrap \
	LICENSE \
	Makefile.w32 \
	NOTICE \
	README.md \
	the_silver_searcher.spec


test: ag
	cram -v tests/*.t
if HAS_CLANG_FORMAT
	CLANG_FORMAT=${CLANG_FORMAT} ./format.sh test
else
	$(info clang-format is not available. Skipped clang-format test.)
endif

test_big: ag
	cram -v tests/big/*.t

test_fail: ag
	cram -v tests/fail/*.t

rpm: the_silver_searcher.spec
	rpmbuild --build-in-place -bb $<

.PHONY: test test_big test_fail rpm
