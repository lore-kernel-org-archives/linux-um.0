Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <richard@nod.at>) id 1f60rN-0008Ra-0p
 for user-mode-linux-devel@lists.sourceforge.net;
 Tue, 10 Apr 2018 21:31:25 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f60rJ-002tai-GB for user-mode-linux-devel@lists.sourceforge.net;
 Tue, 10 Apr 2018 21:31:24 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 10 Apr 2018 23:31:12 +0200
Message-ID: <1785113.iBXbRI6JsH@blindfold>
MIME-Version: 1.0
Subject: [uml-devel] [GIT PULL] UML changes for 4.17-rc1
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Linus,

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git 

for you to fetch changes up to e40238dedb484c8a19f8257e4ef5d77d038f9ad8:

  Fix vector raw inintialization logic (2018-03-29 22:18:02 +0200)

----------------------------------------------------------------
This pull request contains:
- A new and faster epoll based IRQ controller and NIC driver
- Misc fixes and janitorial updates

----------------------------------------------------------------
Anton Ivanov (5):
      Epoll based IRQ controller
      High Performance UML Vector Network Driver
      um: Add missing EXPORT for free_irq_by_fd()
      Migrate vector timers to new timer API
      Fix vector raw inintialization logic

Arnd Bergmann (1):
      um: time: Use timespec64 for persistent clock

Christophe JAILLET (2):
      um: vector: Fix a memory allocation check
      um: vector: Fix an error handling path in 'vector_parse()'

Geert Uytterhoeven (1):
      um: Restore symbol versions for __memcpy and memcpy

Jason A. Donenfeld (1):
      um: Compile with modern headers

Krzysztof Mazur (1):
      um: Use POSIX ucontext_t instead of struct ucontext

Wei Yongjun (1):
      um: vector: fix missing unlock on error in vector_net_open()

 arch/um/Kconfig.net                  |   11 +
 arch/um/drivers/Makefile             |    4 +-
 arch/um/drivers/chan_kern.c          |   53 +-
 arch/um/drivers/line.c               |    2 +-
 arch/um/drivers/net_kern.c           |    4 +-
 arch/um/drivers/random.c             |   11 +-
 arch/um/drivers/ubd_kern.c           |    4 +-
 arch/um/drivers/vector_kern.c        | 1633 ++++++++++++++++++++++++++++++++++
 arch/um/drivers/vector_kern.h        |  130 +++
 arch/um/drivers/vector_transports.c  |  458 ++++++++++
 arch/um/drivers/vector_user.c        |  590 ++++++++++++
 arch/um/drivers/vector_user.h        |  100 +++
 arch/um/include/asm/asm-prototypes.h |    1 +
 arch/um/include/asm/irq.h            |   12 +
 arch/um/include/shared/irq_user.h    |   12 +-
 arch/um/include/shared/net_kern.h    |    2 +
 arch/um/include/shared/os.h          |   17 +-
 arch/um/kernel/irq.c                 |  461 ++++++----
 arch/um/kernel/time.c                |    6 +-
 arch/um/os-Linux/file.c              |    1 +
 arch/um/os-Linux/irq.c               |  202 +++--
 arch/um/os-Linux/signal.c            |    3 +-
 arch/x86/um/stub_segv.c              |    3 +-
 23 files changed, 3395 insertions(+), 325 deletions(-)
 create mode 100644 arch/um/drivers/vector_kern.c
 create mode 100644 arch/um/drivers/vector_kern.h
 create mode 100644 arch/um/drivers/vector_transports.c
 create mode 100644 arch/um/drivers/vector_user.c
 create mode 100644 arch/um/drivers/vector_user.h
 create mode 100644 arch/um/include/asm/asm-prototypes.h


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

