Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVC5R-0007Wm-Qm
 for linux-um@lists.infradead.org; Fri, 07 Dec 2018 09:06:19 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Optimize Flush TLB for force/fork case
Date: Fri,  7 Dec 2018 09:05:53 +0000
Message-Id: <20181207090553.26251-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

When UML handles a fork the page tables need to be brought up
to date. That was done using brute force - full tlb flush.

This is actually unnecessary, because the mapped-in mappings are
all correct and the only mappings which need to be updated
after a flush are any unmaps (so that paging works) as well as
any pending protection changes.

This optimization squeezes out up to 3% from a full kernel rebuild
time under memory pressure.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/tlb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 9ca902df243a..8347161c2ae0 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -242,10 +242,11 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 		prot = ((r ? UM_PROT_READ : 0) | (w ? UM_PROT_WRITE : 0) |
 			(x ? UM_PROT_EXEC : 0));
 		if (hvc->force || pte_newpage(*pte)) {
-			if (pte_present(*pte))
-				ret = add_mmap(addr, pte_val(*pte) & PAGE_MASK,
-					       PAGE_SIZE, prot, hvc);
-			else
+			if (pte_present(*pte)) {
+				if (pte_newpage(*pte))
+					ret = add_mmap(addr, pte_val(*pte) & PAGE_MASK,
+						       PAGE_SIZE, prot, hvc);
+			} else
 				ret = add_munmap(addr, PAGE_SIZE, hvc);
 		} else if (pte_newprot(*pte))
 			ret = add_mprotect(addr, PAGE_SIZE, prot, hvc);
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

