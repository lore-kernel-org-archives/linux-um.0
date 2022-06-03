Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nx6iC-007Tui-K6
	for linux-um@lists.infradead.org; Fri, 03 Jun 2022 12:47:34 +0000
Date: Fri, 3 Jun 2022 14:47:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1471475855.130153.1654260450880.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for v5.19-rc1
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

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.19-rc1

for you to fetch changes up to 2a4a62a14be1947fa945c5c11ebf67326381a568:

  um: Fix out-of-bounds read in LDT setup (2022-05-27 09:03:41 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Various cleanups and fixes: xterm, serial line, time travel
- Set ARCH_HAS_GCOV_PROFILE_ALL

----------------------------------------------------------------
Johannes Berg (6):
      um: xterm: Make default terminal emulator configurable
      um: daemon: Make default socket configurable
      um: Use asm-generic/dma-mapping.h
      um: line: Use separate IRQs per line
      um: virtio_uml: Fix broken device handling in time-travel
      um: chan_user: Fix winch_tramp() return value

Vincent Whitchurch (2):
      um: Enable ARCH_HAS_GCOV_PROFILE_ALL
      um: Fix out-of-bounds read in LDT setup

 arch/um/Kconfig                 |  1 +
 arch/um/drivers/Kconfig         | 15 +++++++++++++++
 arch/um/drivers/Makefile        |  2 ++
 arch/um/drivers/chan_kern.c     | 10 +++++-----
 arch/um/drivers/chan_user.c     |  9 +++++----
 arch/um/drivers/daemon_kern.c   |  2 +-
 arch/um/drivers/line.c          | 22 +++++++++++++---------
 arch/um/drivers/line.h          |  4 ++--
 arch/um/drivers/ssl.c           |  2 --
 arch/um/drivers/stdio_console.c |  2 --
 arch/um/drivers/virtio_uml.c    | 33 +++++++++++++++++++++++----------
 arch/um/drivers/xterm.c         |  7 ++++---
 arch/um/include/asm/Kbuild      |  1 +
 arch/um/include/asm/irq.h       | 22 +++++++++-------------
 arch/x86/um/ldt.c               |  6 ++++--
 15 files changed, 85 insertions(+), 53 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

