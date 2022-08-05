Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK4Mp-000dwQ-KI
	for linux-um@lists.infradead.org; Fri, 05 Aug 2022 20:56:26 +0000
Date: Fri, 5 Aug 2022 22:56:14 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <922167294.69837.1659732974689.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v5.20-rc1
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

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.20-rc1

for you to fetch changes up to af3e16101cee95efaa72095fe06c15ec0b8eb195:

  um: include sys/types.h for size_t (2022-07-17 23:47:18 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- KASAN support for x86_64
- noreboot command line option, just like qemu's -no-reboot
- Various fixes and cleanups

----------------------------------------------------------------
Benjamin Beichler (1):
      um: Remove straying parenthesis

Christopher Obbard (1):
      um: random: Don't initialise hwrng struct with zero

David Gow (2):
      arch: um: Fix build for statically linked UML w/ constructors
      mm: Add PAGE_ALIGN_DOWN macro

Guenter Roeck (1):
      um: Replace to_phys() and to_virt() with less generic function names

Haowen Bai (1):
      um: remove unused variable

Jason A. Donenfeld (3):
      um: include linux/stddef.h for __always_inline
      um: add "noreboot" command line option for PANIC_TIMEOUT=-1 setups
      um: include sys/types.h for size_t

Johannes Berg (1):
      um: x86: print RIP with symbol

Juerg Haefliger (3):
      um: Kconfig: Fix indentation
      um/drivers: Kconfig: Fix indentation
      x86/um: Kconfig: Fix indentation

Patricia Alfonso (1):
      UML: add support for KASAN under x86_64

Peter Zijlstra (1):
      um: Add missing apply_returns()

Tobias Klauser (1):
      um: remove unused mm_copy_segments

 arch/um/Kconfig                         | 17 ++++++++++-
 arch/um/drivers/Kconfig                 | 54 ++++++++++++++++-----------------
 arch/um/drivers/random.c                |  2 +-
 arch/um/include/asm/common.lds.S        |  2 ++
 arch/um/include/asm/kasan.h             | 37 ++++++++++++++++++++++
 arch/um/include/asm/page.h              |  4 +--
 arch/um/include/asm/processor-generic.h |  5 ---
 arch/um/include/asm/xor.h               |  2 +-
 arch/um/include/shared/mem.h            |  4 +--
 arch/um/include/shared/user.h           |  3 +-
 arch/um/kernel/dyn.lds.S                |  6 +++-
 arch/um/kernel/mem.c                    | 19 ++++++++++++
 arch/um/kernel/stacktrace.c             |  2 +-
 arch/um/kernel/um_arch.c                |  4 +++
 arch/um/kernel/uml.lds.S                |  1 +
 arch/um/os-Linux/mem.c                  | 22 ++++++++++++++
 arch/um/os-Linux/skas/process.c         | 23 +++++++++++---
 arch/um/os-Linux/umid.c                 |  3 +-
 arch/um/os-Linux/user_syms.c            |  4 +--
 arch/x86/um/Kconfig                     | 10 +++---
 arch/x86/um/Makefile                    |  3 +-
 arch/x86/um/shared/sysdep/stub_64.h     |  1 +
 arch/x86/um/sysrq_64.c                  |  4 +--
 arch/x86/um/vdso/Makefile               |  3 ++
 include/linux/mm.h                      |  3 ++
 mm/kasan/shadow.c                       | 29 ++++++++++++++++--
 26 files changed, 207 insertions(+), 60 deletions(-)
 create mode 100644 arch/um/include/asm/kasan.h

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

