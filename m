Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWRM-0007oF-1O
 for linux-um@lists.infradead.org; Wed, 05 Dec 2018 12:38:10 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 2/3] um: Skip TLB flushing where not needed
Date: Wed,  5 Dec 2018 12:37:40 +0000
Message-Id: <20181205123741.15456-2-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20181205123741.15456-1-anton.ivanov@cambridgegreys.com>
References: <20181205123741.15456-1-anton.ivanov@cambridgegreys.com>
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

Skip TLB flushing for all cases where it is not needed, not
just flush_tlb_mm_range

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/tlb.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index b7f7a60a0928..9ca902df243a 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -520,6 +520,13 @@ pte_t *addr_pte(struct task_struct *task, unsigned long addr)
 
 void flush_tlb_all(void)
 {
+	/*
+	 * Don't bother flushing if this address space is about to be
+	 * destroyed.
+	 */
+	if (atomic_read(&current->mm->mm_users) == 0)
+		return;
+
 	flush_tlb_mm(current->mm);
 }
 
@@ -541,6 +548,13 @@ void __flush_tlb_one(unsigned long addr)
 static void fix_range(struct mm_struct *mm, unsigned long start_addr,
 		      unsigned long end_addr, int force)
 {
+	/*
+	 * Don't bother flushing if this address space is about to be
+	 * destroyed.
+	 */
+	if (atomic_read(&mm->mm_users) == 0)
+		return;
+
 	fix_range_common(mm, start_addr, end_addr, force);
 }
 
@@ -556,13 +570,6 @@ EXPORT_SYMBOL(flush_tlb_range);
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 			unsigned long end)
 {
-	/*
-	 * Don't bother flushing if this address space is about to be
-	 * destroyed.
-	 */
-	if (atomic_read(&mm->mm_users) == 0)
-		return;
-
 	fix_range(mm, start, end, 0);
 }
 
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

