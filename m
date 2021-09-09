Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOPiW-00AhW3-Jj
 for linux-um@lists.infradead.org; Thu, 09 Sep 2021 19:28:14 +0000
Date: Thu, 9 Sep 2021 21:27:57 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <547678000.58650.1631215677820.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v5.15
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

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.15-rc1

for you to fetch changes up to adf9ae0d159d3dc94f58d788fc4757c8749ac0df:

  um: fix stub location calculation (2021-08-26 22:28:03 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Support for VMAP_STACK
- Support for splice_write in hostfs
- Fixes for virt-pci
- Fixes for virtio_uml
- Various fixes

----------------------------------------------------------------
Johannes Berg (9):
      um: make PCI emulation driver init/exit static
      lib/logic_iomem: fix sparse warnings
      um: virtio_uml: include linux/virtio-uml.h
      um: virtio_uml: fix memory leak on init failures
      hostfs: support splice_write
      um: virt-pci: don't do DMA from stack
      um: enable VMAP_STACK
      um: virt-pci: fix uapi documentation
      um: fix stub location calculation

 arch/um/Kconfig                     |   1 +
 arch/um/drivers/virt-pci.c          | 108 ++++++++++++++++++++++++++----------
 arch/um/drivers/virtio_uml.c        |   5 +-
 arch/um/kernel/skas/clone.c         |   3 +-
 arch/x86/um/shared/sysdep/stub_32.h |  12 ++++
 arch/x86/um/shared/sysdep/stub_64.h |  12 ++++
 arch/x86/um/stub_segv.c             |   3 +-
 fs/hostfs/hostfs_kern.c             |   1 +
 include/uapi/linux/virtio_pcidev.h  |   5 +-
 lib/logic_iomem.c                   |  16 +++---
 10 files changed, 124 insertions(+), 42 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

