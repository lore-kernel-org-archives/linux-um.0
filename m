Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JA9tX-0005WF-9G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:08:56 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JA9tW-0001Yh-J5
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:08:55 -0800
Date: Wed, 2 Jan 2008 15:08:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080102200851.GA7939@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/7] UML - Re-remove accidentally restored code
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

aout-suppress-aout-library-support-if-config_arch_supports_aout.patch
restores some code which had been deleted by
uml-move-um_virt_to_phys.patch and uml-add-virt_to_pte.patch,
presumably due to a botched diff.

This patch gets rid of it again.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/process.c |   44 --------------------------------------------
 1 file changed, 44 deletions(-)

Index: linux-2.6.22/arch/um/kernel/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/process.c	2007-12-13 13:28:34.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/process.c	2007-12-13 13:30:45.000000000 -0500
@@ -4,7 +4,6 @@
  * Licensed under the GPL
  */
 
-#include "linux/module.h"
 #include "linux/stddef.h"
 #include "linux/err.h"
 #include "linux/hardirq.h"
@@ -256,49 +255,6 @@ void cpu_idle(void)
 	default_idle();
 }
 
-void *um_virt_to_phys(struct task_struct *task, unsigned long addr,
-		      pte_t *pte_out)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	pte_t ptent;
-
-	if (task->mm == NULL)
-		return ERR_PTR(-EINVAL);
-	pgd = pgd_offset(task->mm, addr);
-	if (!pgd_present(*pgd))
-		return ERR_PTR(-EINVAL);
-
-	pud = pud_offset(pgd, addr);
-	if (!pud_present(*pud))
-		return ERR_PTR(-EINVAL);
-
-	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
-		return ERR_PTR(-EINVAL);
-
-	pte = pte_offset_kernel(pmd, addr);
-	ptent = *pte;
-	if (!pte_present(ptent))
-		return ERR_PTR(-EINVAL);
-
-	if (pte_out != NULL)
-		*pte_out = ptent;
-	return (void *) (pte_val(ptent) & PAGE_MASK) + (addr & ~PAGE_MASK);
-}
-
-char *current_cmd(void)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_HIGHMEM)
-	return "(Unknown)";
-#else
-	void *addr = um_virt_to_phys(current, current->mm->arg_start, NULL);
-	return IS_ERR(addr) ? "(Unknown)": __va((unsigned long) addr);
-#endif
-}
-
 int __cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
