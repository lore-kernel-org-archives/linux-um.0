Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaM-0006XW-GY	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:54 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eaM-0007cu-A1
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:54 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183637.AA0DE24E7F5@zion.home.lan>
Subject: [uml-devel] [patch 38/39] [RFC] remap_file_pages protection support:
	avoid dirtying on read faults for NONUNIFORM pages
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
Date: Fri, 12 Aug 2005 20:36:37 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When installing pages on non-uniform VMA's, even for read faults we must
install them writable if the VMA is writable (we won't have a chance to fix
that). Normally, on write faults, we install the PTE as dirty (there's a
comment about 80386 on this), but maybe it's not needed here on read faults.

I've looked for more info about that comment - unfortunately, it's there
almost unchanged since 2.4.0, so I've found no info.

However, UML does depend on the old behaviour currently (trivial to cure,
anyway). And if other arch's don't have an hardware "dirty" bit, they'll
depend on this too.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/memory.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN mm/memory.c~rfp-fault-optim-risky mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-fault-optim-risky	2005-08-12 19:25:16.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-12 19:25:16.000000000 +0200
@@ -1899,8 +1899,10 @@ retry:
 		 * been set (we can have a writeable VMA with a read-only PTE),
 		 * so we must set the *exact* permission on fault, and avoid
 		 * calling do_wp_page on write faults. */
-		if (write_access || unlikely(vma->vm_flags & VM_NONUNIFORM))
+		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		else if (unlikely(vma->vm_flags & VM_NONUNIFORM))
+			entry = maybe_mkwrite(entry, vma);
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			lru_cache_add_active(new_page);
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
