Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lilium.sigma-star.at ([109.75.188.150])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUcQp-0007hb-20
 for linux-um@lists.infradead.org; Mon, 19 Oct 2020 21:11:07 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb()
Date: Mon, 19 Oct 2020 23:10:49 +0200
Message-Id: <20201019211049.22524-1-richard@nod.at>
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
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, willy@infradead.org, anton.ivanov@cambridgegreys.com

Commit b2b29d6d0119 ("mm: account PMD tables like PTE tables") uncovered
a bug in uml, we forgot to call the destructor.
While we are here, give x a sane name.

Reported-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Co-developed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/pgalloc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 5393e13e07e0..2bbf28cf3aa9 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -33,7 +33,13 @@ do {							\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
-#define __pmd_free_tlb(tlb,x, address)   tlb_remove_page((tlb),virt_to_page(x))
+
+#define __pmd_free_tlb(tlb, pmd, address)		\
+do {							\
+	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
+	tlb_remove_page((tlb),virt_to_page(pmd));	\
+} while (0)						\
+
 #endif
 
 #endif
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

