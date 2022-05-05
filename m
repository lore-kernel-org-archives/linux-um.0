Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 00/15] kbuild: yet another series of cleanups (modpost, LTO,
 MODULE_REL_CRCS)
Date: Thu,  5 May 2022 16:22:29 +0900
Message-Id: <20220505072244.1155033-1-masahiroy@kernel.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org
Cc: clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org, Nicolas Schier a <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, linux-s390@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>


This is the third batch of cleanups in this development cycle.

Major changes in v3:

 - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.

Major changes in v2:

 - V1 did not work with CONFIG_MODULE_REL_CRCS.
   I fixed this for v2.

 - Reflect some review comments in v1

 - Refactor the code more

 - Avoid too long argument error


Masahiro Yamada (15):
  modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
  modpost: change the license of EXPORT_SYMBOL to bool type
  modpost: merge add_{intree_flag,retpoline,staging_flag} to add_header
  modpost: move *.mod.c generation to write_mod_c_files()
  kbuild: generate a list of objects in vmlinux
  kbuild: record symbol versions in *.cmd files
  modpost: extract symbol versions from *.cmd files
  kbuild: link symbol CRCs at final link, removing
    CONFIG_MODULE_REL_CRCS
  kbuild: stop merging *.symversions
  genksyms: adjust the output format to modpost
  kbuild: do not create *.prelink.o for Clang LTO or IBT
  modpost: simplify the ->is_static initialization
  modpost: use hlist for hash table implementation
  kbuild: make built-in.a rule robust against too long argument error
  kbuild: make *.mod rule robust against too long argument error

 arch/powerpc/Kconfig         |   1 -
 arch/s390/Kconfig            |   1 -
 arch/um/Kconfig              |   1 -
 include/asm-generic/export.h |  22 +-
 include/linux/export.h       |  30 +--
 include/linux/symversion.h   |  13 +
 init/Kconfig                 |   4 -
 kernel/module.c              |  10 +-
 scripts/Kbuild.include       |   4 +
 scripts/Makefile.build       | 118 +++------
 scripts/Makefile.lib         |   7 -
 scripts/Makefile.modfinal    |   5 +-
 scripts/Makefile.modpost     |   9 +-
 scripts/genksyms/genksyms.c  |  18 +-
 scripts/link-vmlinux.sh      |  46 ++--
 scripts/mod/file2alias.c     |   2 -
 scripts/mod/list.h           |  52 ++++
 scripts/mod/modpost.c        | 449 ++++++++++++++++++++---------------
 scripts/mod/modpost.h        |   2 +
 19 files changed, 402 insertions(+), 392 deletions(-)
 create mode 100644 include/linux/symversion.h

-- 
2.32.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

