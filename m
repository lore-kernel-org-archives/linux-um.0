Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDuvv-0006Qz-0J
 for linux-um@lists.infradead.org; Sun, 21 Feb 2021 20:02:24 +0000
Date: Sun, 21 Feb 2021 21:02:21 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1264486228.14901.1613937741621.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for 5.12
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
Cc: linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

Linus,

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linux-5.12-rc1

for you to fetch changes up to ddad5187fc2a12cb84c9d1ac8ecb816708a2986b:

  um: irq.h: include <asm-generic/irq.h> (2021-02-12 21:40:14 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Many cleanups and fixes for our virtio code
- Add support for a pseudo RTC
- Fix for a possible jailbreak
- Minor fixes (spelling, header files)

----------------------------------------------------------------
Christophe Leroy (1):
      mm: Remove arch_remap() and mm-arch-hooks.h

Colin Ian King (1):
      um: fix spelling mistake in Kconfig "privleges" -> "privileges"

Johannes Berg (15):
      um: virtio: clean up a comment
      um: virtio: fix handling of messages without payload
      um: virtio: disable VQs during suspend
      um: time-travel: rework interrupt handling in ext mode
      um: virtio: allow devices to be configured for wakeup
      um: hostfs: use a kmem cache for inodes
      um: print register names in wait_for_stub
      um: mm: check more comprehensively for stub changes
      um: defer killing userspace on page table update failures
      um: separate child and parent errors in clone stub
      um: rework userspace stubs to not hard-code stub location
      um: remove process stub VMA
      um: add a pseudo RTC
      um: io.h: include <linux/types.h>
      um: irq.h: include <asm-generic/irq.h>

 arch/um/drivers/Kconfig                 |  13 +-
 arch/um/drivers/Makefile                |   2 +
 arch/um/drivers/rtc.h                   |  15 +++
 arch/um/drivers/rtc_kern.c              | 211 ++++++++++++++++++++++++++++++++
 arch/um/drivers/rtc_user.c              |  80 ++++++++++++
 arch/um/drivers/virtio_uml.c            | 145 +++++++++++++++-------
 arch/um/include/asm/Kbuild              |   2 +-
 arch/um/include/asm/io.h                |   1 +
 arch/um/include/asm/irq.h               |   1 +
 arch/um/include/asm/mmu_context.h       |  29 +----
 arch/um/include/linux/time-internal.h   |  17 +++
 arch/um/include/shared/as-layout.h      |  17 +--
 arch/um/include/shared/common-offsets.h |   6 +
 arch/um/include/shared/irq_kern.h       |  60 +++++++++
 arch/um/include/shared/skas/mm_id.h     |   1 +
 arch/um/include/shared/skas/stub-data.h |   2 +-
 arch/um/kernel/exec.c                   |   4 +-
 arch/um/kernel/irq.c                    | 171 ++++++++++++++++++++++----
 arch/um/kernel/skas/clone.c             |  28 ++---
 arch/um/kernel/skas/mmu.c               |  87 -------------
 arch/um/kernel/time.c                   |  17 ++-
 arch/um/kernel/tlb.c                    |  14 +--
 arch/um/kernel/um_arch.c                |   5 +
 arch/um/os-Linux/skas/mem.c             |   2 +
 arch/um/os-Linux/skas/process.c         |  86 ++++++++++---
 arch/x86/um/os-Linux/task_size.c        |   2 +-
 arch/x86/um/shared/sysdep/stub_32.h     |  33 +++--
 arch/x86/um/shared/sysdep/stub_64.h     |  36 ++++--
 arch/x86/um/stub_32.S                   |  17 ++-
 arch/x86/um/stub_64.S                   |   5 +-
 arch/x86/um/stub_segv.c                 |   5 +-
 fs/hostfs/hostfs_kern.c                 |  10 +-
 include/asm-generic/Kbuild              |   1 -
 include/asm-generic/mm-arch-hooks.h     |  16 ---
 include/linux/mm-arch-hooks.h           |  22 ----
 mm/mremap.c                             |   3 -
 36 files changed, 841 insertions(+), 325 deletions(-)
 create mode 100644 arch/um/drivers/rtc.h
 create mode 100644 arch/um/drivers/rtc_kern.c
 create mode 100644 arch/um/drivers/rtc_user.c
 delete mode 100644 include/asm-generic/mm-arch-hooks.h
 delete mode 100644 include/linux/mm-arch-hooks.h

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

