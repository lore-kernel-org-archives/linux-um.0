Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaj-0006Zb-4H	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:17 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eai-0007lo-MT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:17 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183622.E3B7E24E7E3@zion.home.lan>
Subject: [uml-devel] [patch 33/39] remap_file_pages protection support:
	VM_FAULT_SIGSEGV permission checking rework
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
Date: Fri, 12 Aug 2005 20:36:22 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Simplify the generic arch permission checking: the previous one was clumsy, as
it didn't account arch-specific implications (read implies exec, write implies
read, and so on).

Still to undo fixes for the archs (i386 and UML) which were modified for the
previous scheme.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/memory.c |   49 ++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 16 deletions(-)

diff -puN mm/memory.c~rfp-sigsegv-4 mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-sigsegv-4	2005-08-12 17:18:55.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-12 17:18:55.000000000 +0200
@@ -1923,6 +1923,35 @@ oom:
 	goto out;
 }
 
+static inline int check_perms(struct vm_area_struct * vma, int access_mask) {
+	if (unlikely(vm_flags & VM_NONUNIFORM)) {
+		/* we used to check protections in arch handler, but with
+		 * VM_NONUNIFORM the check is skipped. */
+#if 0
+		if ((access_mask & VM_WRITE) > (vm_flags & VM_WRITE))
+			goto err;
+		if ((access_mask & VM_READ) > (vm_flags & VM_READ))
+			goto err;
+		if ((access_mask & VM_EXEC) > (vm_flags & VM_EXEC))
+			goto err;
+#else
+		/* access_mask contains the type of the access, vm_flags are the
+		 * declared protections, pte has the protection which will be
+		 * given to the PTE's in that area. */
+		//pte_t pte = pfn_pte(0UL, protection_map[vm_flags & 0x0f|VM_SHARED]);
+		pte_t pte = pfn_pte(0UL, vma->vm_page_prot);
+		if ((access_mask & VM_WRITE) && ! pte_write(pte))
+			goto err;
+		if ((access_mask & VM_READ) && ! pte_read(pte))
+			goto err;
+		if ((access_mask & VM_EXEC) && ! pte_exec(pte))
+			goto err;
+#endif
+	}
+	return 0;
+err:
+	return -EPERM;
+}
 /*
  * Fault of a previously existing named mapping. Repopulate the pte
  * from the encoded file_pte if possible. This enables swappable
@@ -1944,14 +1973,8 @@ static int do_file_page(struct mm_struct
 			((access_mask & VM_WRITE) && !(vma->vm_flags & VM_SHARED))) {
 		/* We're behaving as if pte_file was cleared, so check
 		 * protections like in handle_pte_fault. */
-		if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
-			if ((access_mask & VM_WRITE) > (vma->vm_flags & VM_WRITE))
-				goto out_segv;
-			if ((access_mask & VM_READ) > (vma->vm_flags & VM_READ))
-				goto out_segv;
-			if ((access_mask & VM_EXEC) > (vma->vm_flags & VM_EXEC))
-				goto out_segv;
-		}
+		if (check_perms(vma, access_mask))
+			goto out_segv;
 
 		pte_clear(mm, address, pte);
 		return do_no_page(mm, vma, address, access_mask & VM_WRITE, pte, pmd);
@@ -2007,14 +2030,8 @@ static inline int handle_pte_fault(struc
 		/* when pte_file(), the VMA protections are useless. Otherwise,
 		 * we used to check protections in arch handler, but with
 		 * VM_NONUNIFORM the check is skipped. */
-		if (unlikely(vma->vm_flags & VM_NONUNIFORM) && !pte_file(entry)) {
-			if ((access_mask & VM_WRITE) > (vma->vm_flags & VM_WRITE))
-				goto out_segv;
-			if ((access_mask & VM_READ) > (vma->vm_flags & VM_READ))
-				goto out_segv;
-			if ((access_mask & VM_EXEC) > (vma->vm_flags & VM_EXEC))
-				goto out_segv;
-		}
+		if (!pte_file(entry) && check_perms(vma, access_mask))
+			goto out_segv;
 
 		/*
 		 * If it truly wasn't present, we know that kswapd
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
