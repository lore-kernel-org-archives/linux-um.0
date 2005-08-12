Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaa-0006Yx-1m	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:08 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eaZ-0007cu-OX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:08 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183554.D8CBD24E0B7@zion.home.lan>
Subject: [uml-devel] [patch 23/39] remap_file_pages protection support: fix
	try_to_unmap_one for VM_NONUNIFORM vma's
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
Date: Fri, 12 Aug 2005 20:35:54 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When unmapping linear but non uniform VMA's in try_to_unmap_one, we must
encode the prots in the PTE.

However, we shouldn't use the generic set_nonlinear_pte() function as it
allows for nonlinear offsets, on which we should instead BUG() in this code
path.

Additionally, add a missing TLB flush in both locations. However, there'is
some excess of flushes in these functions.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/rmap.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN mm/rmap.c~rfp-fix-unmap-linear mm/rmap.c
--- linux-2.6.git/mm/rmap.c~rfp-fix-unmap-linear	2005-08-11 23:07:12.000000000 +0200
+++ linux-2.6.git-paolo/mm/rmap.c	2005-08-11 23:07:12.000000000 +0200
@@ -543,6 +543,10 @@ static int try_to_unmap_one(struct page 
 	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval = ptep_clear_flush(vma, address, pte);
 
+	/* If nonlinear, store the file page offset in the pte. */
+	set_nonlinear_pte(pteval, pte, vma, mm, page, address);
+	flush_tlb_page(vma, address);
+
 	/* Move the dirty bit to the physical page now the pte is gone. */
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
@@ -661,6 +665,7 @@ static void try_to_unmap_cluster(unsigne
 
 		/* If nonlinear, store the file page offset in the pte. */
 		set_nonlinear_pte(pteval, pte, vma, mm, page, address);
+		flush_tlb_page(vma, address);
 
 		/* Move the dirty bit to the physical page now the pte is gone. */
 		if (pte_dirty(pteval))
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
