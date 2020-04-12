Return-Path: <rppt@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 12/21] sparc32: simplify detection of memory zone boundaries
Date: Sun, 12 Apr 2020 22:48:50 +0300
Message-Id: <20200412194859.12663-13-rppt@kernel.org>
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
 arch/sparc/mm/srmmu.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b7c94de70cca..cc071dd7d8da 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1008,24 +1008,13 @@ void __init srmmu_paging_init(void)
 	kmap_init();
 
 	{
-		unsigned long zones_size[MAX_NR_ZONES];
-		unsigned long zholes_size[MAX_NR_ZONES];
-		unsigned long npages;
-		int znum;
+		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
-		for (znum = 0; znum < MAX_NR_ZONES; znum++)
-			zones_size[znum] = zholes_size[znum] = 0;
+		max_zone_pfn[ZONE_DMA] = max_low_pfn;
+		max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
+		max_zone_pfn[ZONE_HIGHMEM] = highend_pfn;
 
-		npages = max_low_pfn - pfn_base;
-
-		zones_size[ZONE_DMA] = npages;
-		zholes_size[ZONE_DMA] = npages - pages_avail;
-
-		npages = highend_pfn - max_low_pfn;
-		zones_size[ZONE_HIGHMEM] = npages;
-		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
-
-		free_area_init_node(0, zones_size, pfn_base, zholes_size);
+		free_area_init(max_zone_pfn);
 	}
 }
 
-- 
2.25.1


