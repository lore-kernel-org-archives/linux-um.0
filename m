Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM6TQ-000L5G-W7
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 09:58:50 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: implement arch_sync_kernel_mappings
Date: Tue, 16 Mar 2021 09:58:41 +0000
Message-Id: <20210316095841.5837-1-anton.ivanov@cambridgegreys.com>
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
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

This improves the tlb flushing behavior by syncing modified
ranges out of map_kernel_range_noflush in a way which is
similar to x86.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/asm/page.h | 2 ++
 arch/um/kernel/tlb.c       | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 95af12e82a32..f4c66689f039 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -9,6 +9,8 @@
 
 #include <linux/const.h>
 
+#define ARCH_PAGE_TABLE_SYNC_MASK PGTBL_PMD_MODIFIED
+
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..b27c4457cc72 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -602,3 +602,8 @@ void force_flush_all(void)
 		vma = vma->vm_next;
 	}
 }
+
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	flush_tlb_kernel_range_common(start, end);
+}
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

