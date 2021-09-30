Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 1/6] arch_numa: simplify numa_distance allocation
Date: Thu, 30 Sep 2021 21:50:26 +0300
Message-Id: <20210930185031.18648-2-rppt@kernel.org>
In-Reply-To: <20210930185031.18648-1-rppt@kernel.org>
References: <20210930185031.18648-1-rppt@kernel.org>
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

Memory allocation of numa_distance uses memblock_phys_alloc_range() without
actual range limits, converts the returned physical address to virtual and
then only uses the virtual address for further initialization.

Simplify this by replacing memblock_phys_alloc_range() with
memblock_alloc().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 drivers/base/arch_numa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 00fb4120a5b3..f6d0efd01188 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -275,15 +275,13 @@ void __init numa_free_distance(void)
 static int __init numa_alloc_distance(void)
 {
 	size_t size;
-	u64 phys;
 	int i, j;
 
 	size = nr_node_ids * nr_node_ids * sizeof(numa_distance[0]);
-	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0, PFN_PHYS(max_pfn));
-	if (WARN_ON(!phys))
+	numa_distance = memblock_alloc(size, PAGE_SIZE);
+	if (WARN_ON(!numa_distance))
 		return -ENOMEM;
 
-	numa_distance = __va(phys);
 	numa_distance_cnt = nr_node_ids;
 
 	/* fill with the default distances */
-- 
2.28.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

