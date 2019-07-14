Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hmjl7-00030R-7P
 for linux-um@lists.infradead.org; Sun, 14 Jul 2019 19:02:06 +0000
Date: Sun, 14 Jul 2019 21:02:00 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1979519421.38685.1563130920671.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for 5.3-rc1
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

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.3-rc1

for you to fetch changes up to b482e48d29f1461fd0d059a17f32bcfa274127b3:

  um: fix build without CONFIG_UML_TIME_TRAVEL_SUPPORT (2019-07-04 09:52:18 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- A new timer mode, time travel, for testing with UML
- Many bugfixes/improvements for the serial line driver
- Various bugfixes

----------------------------------------------------------------
Johannes Berg (9):
      um: fix os_timer_one_shot()
      um: Timer code cleanup
      um: Remove locking in deactivate_all_fds()
      um: Silence lockdep complaint about mmap_sem
      um: Don't garbage collect in deactivate_all_fds()
      um: Remove drivers/ssl.h
      um: Pass nsecs to os timer functions
      um: Support time travel mode
      um: fix build without CONFIG_UML_TIME_TRAVEL_SUPPORT

Jouni Malinen (1):
      um: Fix IRQ controller regression on console read

Krzysztof Kozlowski (1):
      um: configs: Remove useless UEVENT_HELPER_PATH

Marek Majkowski (1):
      um: Fix kcov crash during startup

 arch/um/Kconfig                         |  12 +++
 arch/um/configs/i386_defconfig          |   1 -
 arch/um/configs/x86_64_defconfig        |   1 -
 arch/um/drivers/chan_kern.c             |  52 +++++++++++--
 arch/um/drivers/ssl.c                   |   1 -
 arch/um/drivers/ssl.h                   |  13 ----
 arch/um/include/asm/mmu_context.h       |   2 +-
 arch/um/include/shared/os.h             |  10 +--
 arch/um/include/shared/timer-internal.h |  48 ++++++++++++
 arch/um/kernel/irq.c                    |   9 ++-
 arch/um/kernel/process.c                |  42 +++++++++-
 arch/um/kernel/skas/Makefile            |   2 +
 arch/um/kernel/skas/syscall.c           |  11 +++
 arch/um/kernel/time.c                   | 131 ++++++++++++++++++++++++++++++--
 arch/um/os-Linux/time.c                 | 127 +++++++------------------------
 15 files changed, 320 insertions(+), 142 deletions(-)
 delete mode 100644 arch/um/drivers/ssl.h

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

