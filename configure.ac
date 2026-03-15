AC_PREREQ([2.71])
AC_INIT(
    [the_silver_searcher],
    [2.2.0],
    [https://github.com/ggreer/the_silver_searcher/issues],
    [the_silver_searcher],
    [https://github.com/ggreer/the_silver_searcher])
AC_CONFIG_HEADERS([src/config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build-aux])

AC_CANONICAL_HOST

AM_INIT_AUTOMAKE([foreign subdir-objects])
AM_SILENT_RULES([yes])

AC_PROG_CC
AC_PROG_GREP
AC_CHECK_PROGS(
    [CLANG_FORMAT],
    [clang-format-3.8 clang-format-3.7 clang-format-3.6 clang-format],
    [no]
)
AM_CONDITIONAL([HAS_CLANG_FORMAT], [test x$CLANG_FORMAT != xno])

AX_PTHREAD(
    [AC_DEFINE([HAVE_PTHREAD_H], [1], [Define to 1 if you have the <pthread.h> header file.])],
    [AC_MSG_WARN([No pthread support. Ag will be slower due to running single-threaded.])]
)

AS_CASE(
    [host],
    [*mingw*],
        [AC_CHECK_LIB([shlwapi], [main], [], [AC_MSG_ERROR([libshlwapi missing])])],
    []
)

PKG_CHECK_MODULES([PCRE], [libpcre])

use_zlib=no
PKG_WITH_MODULES([ZLIB], [zlib],
    [
        use_zlib=yes
        AC_DEFINE([HAVE_ZLIB_H], [1], [Define to 1 if you have the <zlib.h> header file.])
    ],
    [
        use_zlib="not found"
    ],
    [Enable zlib compressed search support.],
    [yes]
)

use_lzma=no
PKG_WITH_MODULES([LZMA], [liblzma],
    [
        use_lzma=yes
        AC_DEFINE([HAVE_LZMA_H], [1], [Define to 1 if you have the <lzma.h> header file.])
    ],
    [
        use_lzma="not found"
    ],
    [Enable lzma compressed search support.],
    [yes]
)

AC_CHECK_DECL([PCRE_CONFIG_JIT],
              [AC_DEFINE([USE_PCRE_JIT], [], [Use PCRE JIT])],
              [],
              [#include <pcre.h>])

AC_CHECK_DECL([CPU_ZERO, CPU_SET],
              [AC_DEFINE([USE_CPU_SET], [], [Use CPU_SET macros])],
              [],
              [#include <sched.h>])

AC_CHECK_HEADERS([sys/cpuset.h err.h])

AC_CHECK_MEMBER([struct dirent.d_type],
                [AC_DEFINE([HAVE_DIRENT_DTYPE], [], [Have dirent struct member d_type])],
                [],
                [#include <dirent.h>])
AC_CHECK_MEMBER([struct dirent.d_namlen],
                [AC_DEFINE([HAVE_DIRENT_DNAMLEN], [], [Have dirent struct member d_namlen])],
                [],
                [#include <dirent.h>])

AC_FUNC_LSTAT_FOLLOWS_SLASHED_SYMLINK
AC_FUNC_MALLOC
AC_FUNC_MMAP
AC_FUNC_REALLOC

AC_CHECK_FUNCS([fgetln fopencookie getline realpath strlcpy strndup vasprintf madvise posix_fadvise pthread_setaffinity_np pledge])

AC_CONFIG_FILES([Makefile
                the_silver_searcher.spec])
AC_OUTPUT

AS_VAR_IF([CLANG_FORMAT], [no],
    [AC_MSG_WARN([clang-format not found. 'make test' will NOT detect improperly-formatted files.])])

AC_MSG_NOTICE([ZLIB support: $use_zlib])
AC_MSG_NOTICE([LZMA support: $use_lzma])
