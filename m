Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML updates for 4.15-rc1
Date: Thu, 23 Nov 2017 15:36:44 +0100
Message-ID: <3587814.WJtjhAiasP@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,


The following changes since commit bebc6082da0a9f5d47a1ea2edc099bf671058bd4:

  Linux 4.14 (2017-11-12 10:46:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.15-rc1

for you to fetch changes up to 02eb0b11eab56b47bcc36aa04dd522786c8faab9:

  um: Add missing EXPORT for free_irq_by_fd() (2017-11-22 15:20:56 +0100)

----------------------------------------------------------------
This pull request contains updates for UML:
- A new and faster epoll based IRQ controller and NIC driver
- Misc fixes and janitorial updates

----------------------------------------------------------------
Anton Ivanov (3):
      Epoll based IRQ controller
      High Performance UML Vector Network Driver
      um: Add missing EXPORT for free_irq_by_fd()

Arnd Bergmann (1):
      um: time: Use timespec64 for persistent clock

Geert Uytterhoeven (1):
      um: Restore symbol versions for __memcpy and memcpy

Kees Cook (1):
      um: net: Convert timers to use timer_setup()

Krzysztof Mazur (1):
      um: Use POSIX ucontext_t instead of struct ucontext

 arch/um/Kconfig.net                  |   11 +
 arch/um/drivers/Makefile             |    4 +-
 arch/um/drivers/chan_kern.c          |   53 +-
 arch/um/drivers/line.c               |    2 +-
 arch/um/drivers/net_kern.c           |   13 +-
 arch/um/drivers/random.c             |   11 +-
 arch/um/drivers/ubd_kern.c           |    4 +-
 arch/um/drivers/vector_kern.c        | 1630 +++++++++++++++++++++++++++++++++
+
 arch/um/drivers/vector_kern.h        |  129 +++
 arch/um/drivers/vector_transports.c  |  458 ++++++++++
 arch/um/drivers/vector_user.c        |  586 ++++++++++++
 arch/um/drivers/vector_user.h        |   99 +++
 arch/um/include/asm/asm-prototypes.h |    1 +
 arch/um/include/asm/irq.h            |   12 +
 arch/um/include/shared/irq_user.h    |   12 +-
 arch/um/include/shared/net_kern.h    |    2 +
 arch/um/include/shared/os.h          |   17 +-
 arch/um/kernel/irq.c                 |  461 ++++++----
 arch/um/kernel/time.c                |    6 +-
 arch/um/os-Linux/irq.c               |  202 +++--
 arch/um/os-Linux/signal.c            |    2 +-
 arch/x86/um/stub_segv.c              |    2 +-
 22 files changed, 3387 insertions(+), 330 deletions(-)
 create mode 100644 arch/um/drivers/vector_kern.c
 create mode 100644 arch/um/drivers/vector_kern.h
 create mode 100644 arch/um/drivers/vector_transports.c
 create mode 100644 arch/um/drivers/vector_user.c
 create mode 100644 arch/um/drivers/vector_user.h
 create mode 100644 arch/um/include/asm/asm-prototypes.h


