Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ea6-0006WK-O5	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:38 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3ea6-0007cu-Ac
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:38 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183641.0ED1124E7F7@zion.home.lan>
Subject: [uml-devel] [patch 39/39] remap_file_pages protection support: wrong
	"historical" code for review - 2
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
Date: Fri, 12 Aug 2005 20:36:40 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, mingo@elte.hu


From: Ingo Molnar <mingo@elte.hu>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This "fast-path" was contained in the original
remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch from Ingo Molnar; I think this
code is wrong, but I'm sending it for review anyway, because I'm unsure (and
in fact, in the end I found the reason for this).

I guess this code is intended for when we're called by sys_remap_file_page,
without altering pgoffset or protections (otherwise we'd refuse operation on a
private mapping). This cannot happen with mmap(MAP_POPULATE) because we clear
old mappings. And the code makes sense only if we COW'ed a page, because
otherwise the old mapping is already correct. I'm not sure whether we should
fail here - maybe skipping the PTE would be more appropriate. Or we could
anyway turn the nonblock param into a bitmask and pass O_TRUNC there.

However, this is wrong because both routines can be called from within
do_file_page, which is called when !pte_present(pte) && !pte_none(pte) &&
pte_file(pte). I.e.  the pte is not zeroed, so it has been used, but the page
has been swapped out, or the page hasn't been loaded in first place (for
instance for MAP_NONBLOCK).

More accurately, in that situation ->populate is called with nonblock == 0, so
only install_page can be called there. If ->populate fails, the faulting
process will get an inappropriate SIGBUS.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff -puN mm/fremap.c~rfp-wrong mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-wrong	2005-08-12 18:42:23.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-12 18:42:23.000000000 +0200
@@ -90,6 +90,14 @@ int install_page(struct mm_struct *mm, s
 	if (!page->mapping || page->index >= size)
 		goto err_unlock;
 
+	/*
+	 * Only install a new page for a non-shared mapping if it's
+	 * not existent yet:
+	 */
+	err = -EEXIST;
+	if (!pte_none(*pte) && !(vma->vm_flags & VM_SHARED))
+		goto err_unlock;
+
 	zap_pte(mm, vma, addr, pte);
 
 	inc_mm_counter(mm,rss);
@@ -145,6 +153,13 @@ int install_file_pte(struct mm_struct *m
 	pte = pte_alloc_map(mm, pmd, addr);
 	if (!pte)
 		goto err_unlock;
+	/*
+	 * Only install a new page for a non-shared mapping if it's
+	 * not existent yet:
+	 */
+	err = -EEXIST;
+	if (!pte_none(*pte) && !(vma->vm_flags & VM_SHARED))
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
