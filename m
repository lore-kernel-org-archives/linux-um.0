Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gepNP-000865-CB
 for linux-um@lists.infradead.org; Wed, 02 Jan 2019 22:52:41 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML changes for 4.21
Date: Wed, 02 Jan 2019 23:52:26 +0100
Message-ID: <1590974.xBRWhrZ5gH@blindfold>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: torvalds@linux-foundation.org
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Linus,

The following changes since commit 8fe28cb58bcb235034b64cbbb7550a8a43fd88be:

  Linux 4.20 (2018-12-23 15:55:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.21-r=
c1

for you to fetch changes up to 940b241d9050fc354f68c182e99fc3da1ff36bc0:

  um: Remove obsolete reenable_XX calls (2018-12-27 22:48:35 +0100)

----------------------------------------------------------------
Thiss pull requests contains UML updates for 4.21:

- DISCARD support for our block device driver
- Many TLB flush optimizations
- Various smaller fixes
- And most important, Anton agreed to help me maintaining UML

----------------------------------------------------------------
Anton Ivanov (11):
      um: Switch to block-mq constants in the UML UBD driver
      um: Clean-up command processing in UML UBD driver
      um: Remove unsafe printks from the io thread
      um: Add support for DISCARD in the UBD Driver
      um: Remove unnecessary faulted check in uaccess.c
      um: Optimize TLB operations v2
      um: Skip TLB flushing where not needed
      um: Avoid marking pages with "changed protection"
      um: Optimize Flush TLB for force/fork case
      Add Anton Ivanov to UML maintainers
      um: Remove obsolete reenable_XX calls

Christoph Hellwig (1):
      um: writev needs <sys/uio.h>

Hern=E1n Gonzalez (1):
      um: Add HAVE_DEBUG_BUGVERBOSE

Masahiro Yamada (1):
      um: remove redundant generic-y

Richard Weinberger (3):
      um: Update maintainers file entry
      um: Include sys/uio.h to have writev()
      um: Make GCOV depend on !KCOV

 MAINTAINERS                       |   3 +-
 arch/um/Kconfig                   |   1 +
 arch/um/Kconfig.debug             |   1 +
 arch/um/drivers/chan_kern.c       |  10 --
 arch/um/drivers/line.c            |  10 --
 arch/um/drivers/mconsole_kern.c   |   2 -
 arch/um/drivers/net_kern.c        |   2 -
 arch/um/drivers/port_kern.c       |   1 -
 arch/um/drivers/random.c          |   1 -
 arch/um/drivers/ubd_kern.c        | 231 ++++++++++++++++++++++++----------=
----
 arch/um/drivers/vector_user.c     |   2 +
 arch/um/include/asm/Kbuild        |   2 -
 arch/um/include/asm/pgtable.h     |   9 +-
 arch/um/include/shared/irq_user.h |   1 -
 arch/um/include/shared/os.h       |   1 +
 arch/um/kernel/irq.c              |   6 -
 arch/um/kernel/sigio.c            |   1 -
 arch/um/kernel/skas/uaccess.c     |  23 ++--
 arch/um/kernel/tlb.c              | 115 ++++++++++++-------
 arch/um/os-Linux/file.c           |  10 ++
 20 files changed, 259 insertions(+), 173 deletions(-)




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

