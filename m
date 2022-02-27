Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 0/7] Convert overflow and stackinit to KUnit
Date: Sun, 27 Feb 2022 10:45:10 -0800
Message-Id: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vitor Massaru Iha <vitor@massaru.org>, Daniel Latypov <dlatypov@google.com>, David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, kunit-dev@googlegroups.com, llvm@lists.linux.dev, x86@kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Hi,

These changes all build on each other, so I'm sending this as a series
to hopefully reduce confusion. I chose "v3" because it seemed the least
confusing of various options.

The um changes are needed to get Clang building with um to test the
stackinit KUnit test more easily (i.e. needing neither GCC 12 nor QEMU).

-Kees

David Gow (2):
  um: Cleanup syscall_handler_t definition/cast, fix warning
  um: Remove unused timeval_to_ns() function

Kees Cook (5):
  overflow: Provide constant expression struct_size
  lib: overflow: Convert to Kunit
  um: Allow builds with Clang
  lib: stackinit: Convert to KUnit
  UAPI: Introduce KUnit userspace compatibility

 arch/um/os-Linux/execvp.c                   |   1 +
 arch/um/os-Linux/time.c                     |   6 -
 arch/x86/um/shared/sysdep/syscalls_64.h     |   5 +-
 arch/x86/um/user-offsets.c                  |   9 +-
 include/linux/overflow.h                    |  10 +-
 include/uapi/misc/kunit.h                   | 181 +++++++
 lib/Kconfig.debug                           |  38 +-
 lib/Makefile                                |   6 +-
 lib/{test_overflow.c => overflow_kunit.c}   | 562 +++++++++-----------
 lib/{test_stackinit.c => stackinit_kunit.c} | 268 ++++------
 scripts/Makefile.clang                      |   1 +
 11 files changed, 593 insertions(+), 494 deletions(-)
 create mode 100644 include/uapi/misc/kunit.h
 rename lib/{test_overflow.c => overflow_kunit.c} (54%)
 rename lib/{test_stackinit.c => stackinit_kunit.c} (67%)

-- 
2.32.0


