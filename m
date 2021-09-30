Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 4/6] memblock: stop aliasing __memblock_free_late with
 memblock_free_late
Date: Thu, 30 Sep 2021 21:50:29 +0300
Message-Id: <20210930185031.18648-5-rppt@kernel.org>
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

memblock_free_late() is a NOP wrapper for __memblock_free_late(), there is
no point to keep this indirection.

Drop the wrapper and rename __memblock_free_late() to memblock_free_late().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/memblock.h | 7 +------
 mm/memblock.c            | 8 ++++----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index fc8183be340c..e25f964fdd60 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -133,7 +133,7 @@ void __next_mem_range_rev(u64 *idx, int nid, enum memblock_flags flags,
 			  struct memblock_type *type_b, phys_addr_t *out_start,
 			  phys_addr_t *out_end, int *out_nid);
 
-void __memblock_free_late(phys_addr_t base, phys_addr_t size);
+void memblock_free_late(phys_addr_t base, phys_addr_t size);
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 static inline void __next_physmem_range(u64 *idx, struct memblock_type *type,
@@ -441,11 +441,6 @@ static inline void *memblock_alloc_node(phys_addr_t size,
 				      MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 }
 
-static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
-{
-	__memblock_free_late(base, size);
-}
-
 /*
  * Set the allocation direction to bottom-up or top-down.
  */
diff --git a/mm/memblock.c b/mm/memblock.c
index 184dcd2e5d99..603f4a02be9b 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -366,14 +366,14 @@ void __init memblock_discard(void)
 		addr = __pa(memblock.reserved.regions);
 		size = PAGE_ALIGN(sizeof(struct memblock_region) *
 				  memblock.reserved.max);
-		__memblock_free_late(addr, size);
+		memblock_free_late(addr, size);
 	}
 
 	if (memblock.memory.regions != memblock_memory_init_regions) {
 		addr = __pa(memblock.memory.regions);
 		size = PAGE_ALIGN(sizeof(struct memblock_region) *
 				  memblock.memory.max);
-		__memblock_free_late(addr, size);
+		memblock_free_late(addr, size);
 	}
 
 	memblock_memory = NULL;
@@ -1586,7 +1586,7 @@ void * __init memblock_alloc_try_nid(
 }
 
 /**
- * __memblock_free_late - free pages directly to buddy allocator
+ * memblock_free_late - free pages directly to buddy allocator
  * @base: phys starting address of the  boot memory block
  * @size: size of the boot memory block in bytes
  *
@@ -1594,7 +1594,7 @@ void * __init memblock_alloc_try_nid(
  * down, but we are still initializing the system.  Pages are released directly
  * to the buddy allocator.
  */
-void __init __memblock_free_late(phys_addr_t base, phys_addr_t size)
+void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t cursor, end;
 
-- 
2.28.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

