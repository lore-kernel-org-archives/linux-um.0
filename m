Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ea9-0006Wb-4I	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:41 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3ea8-0007Y1-NW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:41 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183628.669D524E7E9@zion.home.lan>
Subject: [uml-devel] [patch 35/39] remap_file_pages protection support: avoid
	redundant pte_file PTE's
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
Date: Fri, 12 Aug 2005 20:36:28 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

For linear VMA's, there is no need to install pte_file PTEs to remember the
offset. We could probably go as far as checking directly the address and
protection like in include/linux/pagemap.h:set_nonlinear_pte(), instead of
vma->vm_flags. Also add some warnings on the path which used to cope with such
PTE's.

Untested yet.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   12 ++++++------
 linux-2.6.git-paolo/mm/memory.c |    5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff -puN mm/fremap.c~rfp-linear-optim-v3 mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-linear-optim-v3	2005-08-11 23:20:09.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 23:20:09.000000000 +0200
@@ -125,6 +125,12 @@ int install_file_pte(struct mm_struct *m
 
  	BUG_ON(!uniform && !(vma->vm_flags & VM_SHARED));
 
+	/* We're being called by mmap(MAP_NONBLOCK|MAP_POPULATE) on an uniform
+	 * VMA. So don't need to take the lock, and to install a PTE for the
+	 * page we'd fault in anyway. */
+	if (uniform)
+		return 0;
+
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 	
@@ -139,12 +145,6 @@ int install_file_pte(struct mm_struct *m
 	pte = pte_alloc_map(mm, pmd, addr);
 	if (!pte)
 		goto err_unlock;
-	/*
-	 * Skip uniform non-existent ptes:
-	 */
-	err = 0;
-	if (uniform && pte_none(*pte))
-		goto err_unlock;
 
 	zap_pte(mm, vma, addr, pte);
 
diff -puN mm/memory.c~rfp-linear-optim-v3 mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-linear-optim-v3	2005-08-11 23:20:09.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-11 23:20:09.000000000 +0200
@@ -1969,9 +1969,14 @@ static int do_file_page(struct mm_struct
 	/*
 	 * Fall back to the linear mapping if the fs does not support
 	 * ->populate; in this case do the protection checks.
+	 * Could have been installed by install_file_pte, for a MAP_NONBLOCK
+	 * pagetable population.
 	 */
 	if (!vma->vm_ops->populate ||
 			((access_mask & VM_WRITE) && !(vma->vm_flags & VM_SHARED))) {
+		/* remap_file_pages should disallow this, now that
+		 * install_file_pte skips linear ones. */
+		WARN_ON(1);
 		/* We're behaving as if pte_file was cleared, so check
 		 * protections like in handle_pte_fault. */
 		if (check_perms(vma, access_mask))
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
