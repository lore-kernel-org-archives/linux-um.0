Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMoKY-0004v5-Jh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 09:45:06 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JMoKY-0005ns-2X
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 09:45:06 -0800
Date: Wed, 6 Feb 2008 12:44:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080206174448.GA7851@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/5] UML - Fix mm_context memory leak
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Miklos Szeredi <miklos@szeredi.hu>

[ Spotted by Miklos ]

Fix a memory leak in init_new_context.  The struct page ** buffer
allocated for install_special_mapping was never recorded, and thus
leaked when the mm_struct was freed.  Fix it by saving the pointer in
mm_context_t and freeing it in arch_exit_mmap.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
---
 arch/um/include/um_mmu.h  |    1 +
 arch/um/kernel/skas/mmu.c |    5 +++++
 2 files changed, 6 insertions(+)

Index: linux-2.6-git/arch/um/include/um_mmu.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/um_mmu.h	2008-02-06 12:15:05.000000000 -0500
+++ linux-2.6-git/arch/um/include/um_mmu.h	2008-02-06 12:24:08.000000000 -0500
@@ -13,6 +13,7 @@
 typedef struct mm_context {
 	struct mm_id id;
 	struct uml_ldt ldt;
+	struct page **stub_pages;
 } mm_context_t;
 
 extern void __switch_mm(struct mm_id * mm_idp);
Index: linux-2.6-git/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/skas/mmu.c	2008-02-06 12:15:05.000000000 -0500
+++ linux-2.6-git/arch/um/kernel/skas/mmu.c	2008-02-06 12:24:31.000000000 -0500
@@ -91,6 +91,8 @@ int init_new_context(struct task_struct 
 		goto out_free;
 	}
 
+	to_mm->stub_pages = NULL;
+
 	return 0;
 
  out_free:
@@ -126,6 +128,7 @@ void arch_dup_mmap(struct mm_struct *old
 
 	pages[0] = virt_to_page(&__syscall_stub_start);
 	pages[1] = virt_to_page(mm->context.id.stack);
+	mm->context.stub_pages = pages;
 
 	/* dup_mmap already holds mmap_sem */
 	err = install_special_mapping(mm, STUB_START, STUB_END - STUB_START,
@@ -147,6 +150,8 @@ void arch_exit_mmap(struct mm_struct *mm
 {
 	pte_t *pte;
 
+	if (mm->context.stub_pages != NULL)
+		kfree(mm->context.stub_pages);
 	pte = virt_to_pte(mm, STUB_CODE);
 	if (pte != NULL)
 		pte_clear(mm, STUB_CODE, pte);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
