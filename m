Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7OCx-0003TZ-Ih
 for linux-um@lists.infradead.org; Wed, 03 Feb 2021 19:53:00 +0000
Date: Wed, 3 Feb 2021 20:52:54 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <2021686242.358980.1612381974638.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for 5.11-rc7
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

The following changes since commit 4992eb41ab1b5d08479193afdc94f9678e5ded13:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2021-01-26 11:10:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.11-rc7

for you to fetch changes up to 7f3414226b58b0df0426104c8ab5e8d50ae71d11:

  um: time: fix initialization in time-travel mode (2021-01-26 22:11:38 +0100)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Make sure to set a default console, otherwise ttynull is selected.
- Revert initial ARCH_HAS_SET_MEMORY support, this needs more work.
- Fix a regression due to ubd refactoring.
- Various small fixes.

----------------------------------------------------------------
Hajime Tazaki (1):
      um: ubd: fix command line handling of ubd

Johannes Berg (6):
      um: return error from ioremap()
      um: virtio: free vu_dev only with the contained struct device
      Revert "um: allocate a guard page to helper threads"
      Revert "um: support some of ARCH_HAS_SET_MEMORY"
      um: fix os_idle_sleep() to not hang
      um: time: fix initialization in time-travel mode

Thomas Meyer (2):
      um: stdio_console: Make preferred console
      um: kmsg_dumper: always dump when not tty console

 arch/um/Kconfig                    |  1 -
 arch/um/drivers/ubd_kern.c         |  6 ++---
 arch/um/drivers/virtio_uml.c       |  3 ++-
 arch/um/include/asm/io.h           |  2 +-
 arch/um/include/asm/pgtable.h      |  3 ---
 arch/um/include/asm/set_memory.h   |  1 -
 arch/um/include/shared/kern_util.h |  2 +-
 arch/um/kernel/kmsg_dump.c         |  9 +++++--
 arch/um/kernel/process.c           | 11 +++-----
 arch/um/kernel/time.c              | 50 +++++++++++++++++++++--------------
 arch/um/kernel/tlb.c               | 54 --------------------------------------
 arch/um/kernel/um_arch.c           | 22 +++++++++++++---
 arch/um/os-Linux/helper.c          |  4 +--
 arch/um/os-Linux/time.c            | 15 ++++++++++-
 14 files changed, 84 insertions(+), 99 deletions(-)
 delete mode 100644 arch/um/include/asm/set_memory.h

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

