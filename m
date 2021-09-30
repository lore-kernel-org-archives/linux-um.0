Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 0/6] memblock: cleanup memblock_free interface
Date: Thu, 30 Sep 2021 21:50:25 +0300
Message-Id: <20210930185031.18648-1-rppt@kernel.org>
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
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Juergen Gross <jgross@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Shahab Vahedi <Shahab.Vahedi@synopsys.com>, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, kasan-dev@googlegroups.com, kvm@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

Following the discussion on [1] this is the fix for memblock freeing APIs
mismatch. 

The first patch is a cleanup of numa_distance allocation in arch_numa I've
spotted during the conversion.
The second patch is a fix for Xen memory freeing on some of the error
paths.

I agree with Christophe that doing step by step makes the thing easier to
review, so the patches 3-6 do the actual cleanup step by step.

This time I used stricter coccinelle scripts so that only straightforward
uses would get converted.

There still a couple of (void *) castings for the cases when a virtual
address has unsigned long type rather than a pointer type, like e.g
initrd_start.

Since scripts/get_maintainer.pl returned more than 100 addresses I've
trimmed the distribution list only to the relevant lists.

Juergen and Shahab, I didn't keep your Reviewed-by because the patches are
a bit different this time.

v2:
* split changes into several patches
* use stricter coccinelle scripts 

[1] https://lore.kernel.org/all/CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com

Mike Rapoport (6):
  arch_numa: simplify numa_distance allocation
  xen/x86: free_p2m_page: use memblock_free_ptr() to free a virtual pointer
  memblock: drop memblock_free_early_nid() and memblock_free_early()
  memblock: stop aliasing __memblock_free_late with memblock_free_late
  memblock: rename memblock_free to memblock_phys_free
  memblock: use memblock_free for freeing virtual pointers

 arch/alpha/kernel/core_irongate.c         |  2 +-
 arch/arc/mm/init.c                        |  2 +-
 arch/arm/mach-hisi/platmcpm.c             |  2 +-
 arch/arm/mm/init.c                        |  2 +-
 arch/arm64/mm/mmu.c                       |  4 ++--
 arch/mips/mm/init.c                       |  2 +-
 arch/mips/sgi-ip30/ip30-setup.c           |  6 +++---
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  4 ++--
 arch/powerpc/kernel/paca.c                |  8 ++++----
 arch/powerpc/kernel/setup-common.c        |  2 +-
 arch/powerpc/kernel/setup_64.c            |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  2 +-
 arch/powerpc/platforms/pseries/svm.c      |  3 +--
 arch/riscv/kernel/setup.c                 |  4 ++--
 arch/s390/kernel/setup.c                  |  8 ++++----
 arch/s390/kernel/smp.c                    |  4 ++--
 arch/s390/kernel/uv.c                     |  2 +-
 arch/s390/mm/kasan_init.c                 |  2 +-
 arch/sh/boards/mach-ap325rxa/setup.c      |  2 +-
 arch/sh/boards/mach-ecovec24/setup.c      |  4 ++--
 arch/sh/boards/mach-kfr2r09/setup.c       |  2 +-
 arch/sh/boards/mach-migor/setup.c         |  2 +-
 arch/sh/boards/mach-se/7724/setup.c       |  4 ++--
 arch/sparc/kernel/smp_64.c                |  2 +-
 arch/um/kernel/mem.c                      |  2 +-
 arch/x86/kernel/setup.c                   |  4 ++--
 arch/x86/kernel/setup_percpu.c            |  2 +-
 arch/x86/mm/init.c                        |  2 +-
 arch/x86/mm/kasan_init_64.c               |  4 ++--
 arch/x86/mm/numa.c                        |  2 +-
 arch/x86/mm/numa_emulation.c              |  2 +-
 arch/x86/xen/mmu_pv.c                     |  6 +++---
 arch/x86/xen/p2m.c                        |  2 +-
 arch/x86/xen/setup.c                      |  6 +++---
 drivers/base/arch_numa.c                  | 10 ++++------
 drivers/firmware/efi/memmap.c             |  2 +-
 drivers/macintosh/smu.c                   |  2 +-
 drivers/of/kexec.c                        |  3 +--
 drivers/of/of_reserved_mem.c              |  5 +++--
 drivers/s390/char/sclp_early.c            |  2 +-
 drivers/usb/early/xhci-dbc.c              | 10 +++++-----
 drivers/xen/swiotlb-xen.c                 |  2 +-
 include/linux/memblock.h                  | 23 +++--------------------
 init/initramfs.c                          |  2 +-
 init/main.c                               |  2 +-
 kernel/dma/swiotlb.c                      |  2 +-
 kernel/printk/printk.c                    |  4 ++--
 lib/bootconfig.c                          |  2 +-
 lib/cpumask.c                             |  2 +-
 mm/cma.c                                  |  2 +-
 mm/memblock.c                             | 22 +++++++++++-----------
 mm/memory_hotplug.c                       |  2 +-
 mm/percpu.c                               |  8 ++++----
 mm/sparse.c                               |  2 +-
 54 files changed, 99 insertions(+), 119 deletions(-)


base-commit: 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
-- 
2.28.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

