Return-Path: <rppt@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 13/21] unicore32: simplify detection of memory zone boundaries
Date: Sun, 12 Apr 2020 22:48:51 +0300
Message-Id: <20200412194859.12663-14-rppt@kernel.org>
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-um.lists.infradead.org>

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init() function only requires the definition of maximal PFN
for each of the supported zone rater than calculation of actual zone sizes
and the sizes of the holes between the zones.

After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP the free_area_init() is
available to all architectures.

Using this function instead of free_area_init_node() simplifies the zone
detection.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/unicore32/include/asm/memory.h  |  2 +-
 arch/unicore32/include/mach/memory.h |  6 ++--
 arch/unicore32/kernel/pci.c          | 14 ++-------
 arch/unicore32/mm/init.c             | 43 ++++++----------------------
 4 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/arch/unicore32/include/asm/memory.h b/arch/unicore32/include/asm/memory.h
index 23c93105f98f..66285178dd9b 100644
--- a/arch/unicore32/include/asm/memory.h
+++ b/arch/unicore32/include/asm/memory.h
@@ -60,7 +60,7 @@
 #ifndef __ASSEMBLY__
 
 #ifndef arch_adjust_zones
-#define arch_adjust_zones(size, holes) do { } while (0)
+#define arch_adjust_zones(max_zone_pfn) do { } while (0)
 #endif
 
 /*
diff --git a/arch/unicore32/include/mach/memory.h b/arch/unicore32/include/mach/memory.h
index 2b527cedd03d..b4e6035cb9a3 100644
--- a/arch/unicore32/include/mach/memory.h
+++ b/arch/unicore32/include/mach/memory.h
@@ -25,10 +25,10 @@
 
 #if !defined(__ASSEMBLY__) && defined(CONFIG_PCI)
 
-void puv3_pci_adjust_zones(unsigned long *size, unsigned long *holes);
+void puv3_pci_adjust_zones(unsigned long *max_zone_pfn);
 
-#define arch_adjust_zones(size, holes) \
-	puv3_pci_adjust_zones(size, holes)
+#define arch_adjust_zones(max_zone_pfn) \
+	puv3_pci_adjust_zones(max_zone_pfn)
 
 #endif
 
diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index efa04a94dcdb..0d098aa05b47 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -133,21 +133,11 @@ static int pci_puv3_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
  * This is really ugly and we need a better way of specifying
  * DMA-capable regions of memory.
  */
-void __init puv3_pci_adjust_zones(unsigned long *zone_size,
-	unsigned long *zhole_size)
+void __init puv3_pci_adjust_zones(unsigned long max_zone_pfn)
 {
 	unsigned int sz = SZ_128M >> PAGE_SHIFT;
 
-	/*
-	 * Only adjust if > 128M on current system
-	 */
-	if (zone_size[0] <= sz)
-		return;
-
-	zone_size[1] = zone_size[0] - sz;
-	zone_size[0] = sz;
-	zhole_size[1] = zhole_size[0];
-	zhole_size[0] = 0;
+	max_zone_pfn[ZONE_DMA] = sz;
 }
 
 /*
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 6cf010fadc7a..52425d383cea 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -61,46 +61,21 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 	}
 }
 
-static void __init uc32_bootmem_free(unsigned long min, unsigned long max_low,
-	unsigned long max_high)
+static void __init uc32_bootmem_free(unsigned long max_low)
 {
-	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
-	struct memblock_region *reg;
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
-	/*
-	 * initialise the zones.
-	 */
-	memset(zone_size, 0, sizeof(zone_size));
-
-	/*
-	 * The memory size has already been determined.  If we need
-	 * to do anything fancy with the allocation of this memory
-	 * to the zones, now is the time to do it.
-	 */
-	zone_size[0] = max_low - min;
-
-	/*
-	 * Calculate the size of the holes.
-	 *  holes = node_size - sum(bank_sizes)
-	 */
-	memcpy(zhole_size, zone_size, sizeof(zhole_size));
-	for_each_memblock(memory, reg) {
-		unsigned long start = memblock_region_memory_base_pfn(reg);
-		unsigned long end = memblock_region_memory_end_pfn(reg);
-
-		if (start < max_low) {
-			unsigned long low_end = min(end, max_low);
-			zhole_size[0] -= low_end - start;
-		}
-	}
+	max_zone_pfn[ZONE_DMA] = max_low;
+	max_zone_pfn[ZONE_NORMAL] = max_low;
 
 	/*
 	 * Adjust the sizes according to any special requirements for
 	 * this machine type.
+	 * This might lower ZONE_DMA limit.
 	 */
-	arch_adjust_zones(zone_size, zhole_size);
+	arch_adjust_zones(max_zone_pfn);
 
-	free_area_init_node(0, zone_size, min, zhole_size);
+	free_area_init(max_zone_pfn);
 }
 
 int pfn_valid(unsigned long pfn)
@@ -176,11 +151,11 @@ void __init bootmem_init(void)
 	sparse_init();
 
 	/*
-	 * Now free the memory - free_area_init_node needs
+	 * Now free the memory - free_area_init needs
 	 * the sparse mem_map arrays initialized by sparse_init()
 	 * for memmap_init_zone(), otherwise all PFNs are invalid.
 	 */
-	uc32_bootmem_free(min, max_low, max_high);
+	uc32_bootmem_free(max_low);
 
 	high_memory = __va((max_low << PAGE_SHIFT) - 1) + 1;
 
-- 
2.25.1


