Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture part 0
Date: Wed, 13 Feb 2019 17:00:14 -0500
Message-Id: <1550095217-12047-1-git-send-email-longman@redhat.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Waiman Long <longman@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, linux-arm-kernel@lists.infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

v4:
 - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.

v3:
 - Optimize __down_read_trylock() for the uncontended case as suggested
   by Linus.

v2:
 - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
 - Update performance test data in patch 1.

The goal of this patchset is to remove the architecture specific files
for rwsem-xadd to make it easer to add enhancements in the later rwsem
patches. It also removes the legacy rwsem-spinlock.c file and make all
the architectures use one single implementation of rwsem - rwsem-xadd.c.

Waiman Long (3):
  locking/rwsem: Remove arch specific rwsem files
  locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
    archs
  locking/rwsem: Optimize down_read_trylock()

 MAINTAINERS                     |   1 -
 arch/alpha/Kconfig              |   7 -
 arch/alpha/include/asm/rwsem.h  | 211 -------------------------
 arch/arc/Kconfig                |   3 -
 arch/arm/Kconfig                |   4 -
 arch/arm/include/asm/Kbuild     |   1 -
 arch/arm64/Kconfig              |   3 -
 arch/arm64/include/asm/Kbuild   |   1 -
 arch/c6x/Kconfig                |   3 -
 arch/csky/Kconfig               |   3 -
 arch/h8300/Kconfig              |   3 -
 arch/hexagon/Kconfig            |   6 -
 arch/hexagon/include/asm/Kbuild |   1 -
 arch/ia64/Kconfig               |   4 -
 arch/ia64/include/asm/rwsem.h   | 172 --------------------
 arch/m68k/Kconfig               |   7 -
 arch/microblaze/Kconfig         |   6 -
 arch/mips/Kconfig               |   7 -
 arch/nds32/Kconfig              |   3 -
 arch/nios2/Kconfig              |   3 -
 arch/openrisc/Kconfig           |   6 -
 arch/parisc/Kconfig             |   6 -
 arch/powerpc/Kconfig            |   7 -
 arch/powerpc/include/asm/Kbuild |   1 -
 arch/riscv/Kconfig              |   3 -
 arch/s390/Kconfig               |   6 -
 arch/s390/include/asm/Kbuild    |   1 -
 arch/sh/Kconfig                 |   6 -
 arch/sh/include/asm/Kbuild      |   1 -
 arch/sparc/Kconfig              |   8 -
 arch/sparc/include/asm/Kbuild   |   1 -
 arch/unicore32/Kconfig          |   6 -
 arch/x86/Kconfig                |   3 -
 arch/x86/include/asm/rwsem.h    | 237 ----------------------------
 arch/x86/lib/Makefile           |   1 -
 arch/x86/lib/rwsem.S            | 156 ------------------
 arch/x86/um/Kconfig             |   6 -
 arch/x86/um/Makefile            |   1 -
 arch/xtensa/Kconfig             |   3 -
 arch/xtensa/include/asm/Kbuild  |   1 -
 include/asm-generic/rwsem.h     | 140 -----------------
 include/linux/rwsem-spinlock.h  |  47 ------
 include/linux/rwsem.h           |   9 +-
 kernel/Kconfig.locks            |   2 +-
 kernel/locking/Makefile         |   4 +-
 kernel/locking/percpu-rwsem.c   |   2 +
 kernel/locking/rwsem-spinlock.c | 339 ----------------------------------------
 kernel/locking/rwsem.h          | 130 +++++++++++++++
 48 files changed, 135 insertions(+), 1447 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rwsem.h
 delete mode 100644 arch/ia64/include/asm/rwsem.h
 delete mode 100644 arch/x86/include/asm/rwsem.h
 delete mode 100644 arch/x86/lib/rwsem.S
 delete mode 100644 include/asm-generic/rwsem.h
 delete mode 100644 include/linux/rwsem-spinlock.h
 delete mode 100644 kernel/locking/rwsem-spinlock.c

-- 
1.8.3.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

