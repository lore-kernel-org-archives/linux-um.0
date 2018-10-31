Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHxwq-00013g-2G
 for linux-um@lists.infradead.org; Wed, 31 Oct 2018 21:22:45 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML changes for 4.20-rc1
Date: Wed, 31 Oct 2018 22:22:33 +0100
Message-ID: <1829585.6m1bt7BjAO@blindfold>
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
To: torvalds@linux-foundation.org
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Linus,

First of all, welcome back!

Please note that the vast majority of these changes have
been in -next since 4.18.
Due to vacation and other troubles I didn't send a pull request
back then.
I rebased them a few days ago on top of 4.19.

The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.20-rc1

for you to fetch changes up to 917e2fd2c53eb3c4162f5397555cbd394390d4bc:

  um: Make line/tty semantics use true write IRQ (2018-10-29 22:34:16 +0100)

----------------------------------------------------------------
This pull request contains the following updates for UML:

- Removal of old and dead code
- A bug fix for our tty driver
- Other minor cleanups across the code base
----------------------------------------------------------------

Anton Ivanov (1):
      um: Make line/tty semantics use true write IRQ

Christoph Hellwig (1):
      um: remove unused AIO code

Colin Ian King (1):
      um: trap: fix spelling mistake, EACCESS -> EACCES

Richard Weinberger (3):
      um: Drop own definition of PTRACE_SYSEMU/_SINGLESTEP
      um: Remove update_debugregs()
      um: Give start_idle_thread() a return code

Ritesh Raj Sarraf (1):
      um: Don't hardcode path as it is architecture dependent

YueHaibing (1):
      um: NULL check before kfree is not needed

 arch/um/drivers/line.c                |   4 +-
 arch/um/drivers/port_user.c           |   2 +-
 arch/um/drivers/vector_kern.c         |  15 +-
 arch/um/drivers/vector_user.c         |   6 +-
 arch/um/include/shared/aio.h          |  28 ---
 arch/um/kernel/irq.c                  |   3 +-
 arch/um/kernel/trap.c                 |   2 +-
 arch/um/os-Linux/Makefile             |   8 +-
 arch/um/os-Linux/aio.c                | 390 ----------------------------------
 arch/um/os-Linux/skas/process.c       |   5 +
 arch/x86/um/shared/sysdep/ptrace_32.h |  12 --
 11 files changed, 19 insertions(+), 456 deletions(-)
 delete mode 100644 arch/um/include/shared/aio.h
 delete mode 100644 arch/um/os-Linux/aio.c




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

