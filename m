Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e4w-0004kZ-1k	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:16:26 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e4t-0000QE-Ea
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:16:26 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182327.05E9B24E0A6@zion.home.lan>
Subject: [uml-devel] [patch 20/39] remap_file_pages protection support:
	optimize install_file_pte for MAP_POPULATE
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 12 Aug 2005 20:23:27 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add an optimization to install_file_pte: if the VMA is uniform, and the PTE
was null, it will be installed correctly if needed at fault time - we avoid
thus touching the page tables, but we must still do the walk...

I'd like to avoid doing the walk altogether, when detecting that the VMA is
uniform.

I'm wondering why should the PTE have a wrong value? It could be a pte_file
PTE installed by a previous MAP_POPULATE or remap_file_pages call with
MAP_NONBLOCK, but that would either have been zapped (if we're handling
MAP_POPULATE) or it would be correct (if called by remap_file_pages, which is
unlikely since we're in a uniform VMA).

The protections must be correct, or we'd detect it by seeing VM_NONUNIFORM,
and the offset too, otherwise we'd see VM_NONLINEAR.

Thus it's just used for MAP_POPULATE|MAP_NONBLOCK.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN mm/fremap.c~rfp-linear-optim-v2 mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-linear-optim-v2	2005-08-11 22:46:58.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 22:57:49.000000000 +0200
@@ -121,6 +121,9 @@ int install_file_pte(struct mm_struct *m
 	pud_t *pud;
 	pgd_t *pgd;
 	pte_t pte_val;
+	int uniform = !(vma->vm_flags & (VM_NONUNIFORM | VM_NONLINEAR));
+
+ 	BUG_ON(!uniform && !(vma->vm_flags & VM_SHARED));
 
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
@@ -136,6 +139,12 @@ int install_file_pte(struct mm_struct *m
 	pte = pte_alloc_map(mm, pmd, addr);
 	if (!pte)
 		goto err_unlock;
+	/*
+	 * Skip uniform non-existent ptes:
+	 */
+	err = 0;
+	if (uniform && pte_none(*pte))
+		goto err_unlock;
 
 	zap_pte(mm, vma, addr, pte);
 
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
