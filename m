Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kq14c-00060Z-2u
 for linux-um@lists.infradead.org; Thu, 17 Dec 2020 21:44:35 +0000
Date: Thu, 17 Dec 2020 22:44:23 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <841389660.140020.1608241463043.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for 5.11-rc1
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

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.11-rc1

for you to fetch changes up to 1fb1abc83636f5329c26cd29f0f19f3faeb697a5:

  um: Fix build w/o CONFIG_PM_SLEEP (2020-12-14 21:15:32 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- IRQ handling cleanups
- Support for suspend
- Various fixes for UML specific drivers: ubd, vector, xterm

----------------------------------------------------------------
Allen Pais (1):
      um: Convert tasklets to use new tasklet_setup() API

Andy Shevchenko (1):
      um: Increase stack frame size threshold for signal.c

Anton Ivanov (5):
      um: Remove use of asprinf in umid.c
      um: Fetch registers only for signals which need them
      um: Monitor error events in IRQ controller
      um: tty: Fix handling of close in tty lines
      um: chan_xterm: Fix fd leak

Christopher Obbard (2):
      um: random: Register random as hwrng-core device
      um: ubd: Set device serial attribute from cmdline

Gabriel Krisman Bertazi (1):
      um: ubd: Submit all data segments atomically

Jens Axboe (1):
      um: Add support for TIF_NOTIFY_SIGNAL

Johannes Berg (21):
      um: Fix time-travel mode
      um: line: Don't free winch (with IRQ) under spinlock
      um: sigio: Return error from add_sigio_fd()
      um: Support dynamic IRQ allocation
      um: virtio: Use dynamic IRQ allocation
      um: Clean up alarm IRQ chip name
      um: irq: Clean up and rename struct irq_fd
      um: irq: Reduce irq_reg allocation
      um: Remove IRQ_NONE type
      um: Simplify IRQ handling code
      um: Simplify os_idle_sleep() and sleep longer
      um: time: Fix read_persistent_clock64() in time-travel
      um: Allow PM with suspend-to-idle
      um: Support suspend to RAM
      um: time-travel: avoid multiple identical propagations
      um: support some of ARCH_HAS_SET_MEMORY
      um: allocate a guard page to helper threads
      um: time-travel: Actually apply "free-until" optimisation
      um: irq/sigio: Support suspend/resume handling of workaround IRQs
      um: time-travel: Correct time event IRQ delivery
      um: Fix build w/o CONFIG_PM_SLEEP

 arch/um/Kconfig                         |   6 +
 arch/um/drivers/chan_user.c             |   4 +-
 arch/um/drivers/line.c                  |  30 +-
 arch/um/drivers/mconsole_kern.c         |   2 +-
 arch/um/drivers/net_kern.c              |   2 +-
 arch/um/drivers/port_kern.c             |   4 +-
 arch/um/drivers/random.c                | 105 ++-----
 arch/um/drivers/ubd_kern.c              | 273 ++++++++++------
 arch/um/drivers/vector_kern.c           |  10 +-
 arch/um/drivers/virtio_uml.c            |  31 +-
 arch/um/drivers/xterm.c                 |   5 +
 arch/um/drivers/xterm_kern.c            |   2 +-
 arch/um/include/asm/irq.h               |   9 +-
 arch/um/include/asm/pgtable.h           |   3 +
 arch/um/include/asm/set_memory.h        |   1 +
 arch/um/include/asm/thread_info.h       |   2 +
 arch/um/include/linux/time-internal.h   |   4 +-
 arch/um/include/shared/common-offsets.h |   3 +
 arch/um/include/shared/irq_kern.h       |  13 +-
 arch/um/include/shared/irq_user.h       |  21 +-
 arch/um/include/shared/kern_util.h      |   5 +-
 arch/um/include/shared/os.h             |  23 +-
 arch/um/kernel/irq.c                    | 534 +++++++++++++++++---------------
 arch/um/kernel/process.c                |  27 +-
 arch/um/kernel/sigio.c                  |   2 +-
 arch/um/kernel/time.c                   |  97 +++++-
 arch/um/kernel/tlb.c                    |  54 ++++
 arch/um/kernel/um_arch.c                |  67 ++++
 arch/um/os-Linux/Makefile               |   2 +
 arch/um/os-Linux/helper.c               |   4 +-
 arch/um/os-Linux/irq.c                  |   4 +-
 arch/um/os-Linux/sigio.c                |  70 +++--
 arch/um/os-Linux/signal.c               |  22 +-
 arch/um/os-Linux/skas/process.c         |  15 +-
 arch/um/os-Linux/time.c                 |  17 +-
 arch/um/os-Linux/umid.c                 |  17 +-
 drivers/char/hw_random/Kconfig          |  16 +-
 37 files changed, 909 insertions(+), 597 deletions(-)
 create mode 100644 arch/um/include/asm/set_memory.h

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

