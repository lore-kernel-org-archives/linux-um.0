Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1Sr-004FJB-LW
 for linux-um@lists.infradead.org; Tue, 04 May 2021 20:16:19 +0000
Date: Tue, 4 May 2021 22:16:08 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1774500012.55581.1620159368372.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for 5.13
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
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>

Linus,

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.13-rc1

for you to fetch changes up to ed102bf2afed226703eaf85a704755bdbea34583:

  um: Fix W=1 missing-include-dirs warnings (2021-04-15 23:10:57 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Disable CONFIG_GCOV when built with modules
- Many fixes for W=1 related warnings
- Code cleanup

Due to lack of time I was unable to prepare a bigger pull request.
PR for the next merge window will contain more interesting material, I promise. :-)

----------------------------------------------------------------
Johannes Berg (3):
      um: Fix tag order in stub_32.h
      um: Mark all kernel symbols as local
      um: Disable CONFIG_GCOV with MODULES

Randy Dunlap (4):
      um: Add 2 missing libs to fix various build errors
      um: pgtable.h: Fix W=1 warning for empty body in 'do' statement
      um: elf.h: Fix W=1 warning for empty body in 'do' statement
      um: Fix W=1 missing-include-dirs warnings

Yang Li (3):
      um: Remove unneeded variable 'ret'
      um: Replace if (cond) BUG() with BUG_ON()
      um: Remove unused including <linux/version.h>

 arch/um/Kconfig.debug               |  1 +
 arch/um/drivers/hostaudio_kern.c    |  4 +---
 arch/um/drivers/vector_kern.c       |  1 -
 arch/um/include/asm/pgtable.h       |  2 +-
 arch/um/include/uapi/asm/Kbuild     |  1 +
 arch/um/kernel/Makefile             |  1 -
 arch/um/kernel/dyn.lds.S            |  6 ++++++
 arch/um/kernel/gmon_syms.c          | 16 ----------------
 arch/um/kernel/mem.c                |  3 +--
 arch/um/kernel/uml.lds.S            |  6 ++++++
 arch/x86/um/Makefile                |  1 +
 arch/x86/um/asm/elf.h               |  2 +-
 arch/x86/um/shared/sysdep/stub_32.h |  2 +-
 13 files changed, 20 insertions(+), 26 deletions(-)
 create mode 100644 arch/um/include/uapi/asm/Kbuild
 delete mode 100644 arch/um/kernel/gmon_syms.c

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

