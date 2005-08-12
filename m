Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3k-0004fe-4p	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:12 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3i-00007h-SU
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:12 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182130.5BAE824E7E2@zion.home.lan>
Subject: [uml-devel] [patch 13/39] remap_file_pages protection support:
	support private vma for MAP_POPULATE
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
Date: Fri, 12 Aug 2005 20:21:30 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, mingo@elte.hu


From: Ingo Molnar <mingo@elte.hu>

If we're not rearranging pages, support even PRIVATE vma.

This is needed to make MAP_POPULATE|MAP_PRIVATE to work, since it calls
remap_file_pages.

Notes from: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We don't support private VMA because when they're swapped out we need to store
the swap entry in the PTE, not the file offset and protections; so, I suppose
that with remap-file-pages-prot, we must punt on private VMA even when we're
just changing protections. This change is in a separate patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   55 ++++++++++++++++++++++++----------------
 linux-2.6.git-paolo/mm/mmap.c   |    4 ++
 2 files changed, 38 insertions(+), 21 deletions(-)

diff -puN mm/fremap.c~rfp-private-vma mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-private-vma	2005-08-11 23:02:45.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 23:02:45.000000000 +0200
@@ -218,34 +218,47 @@ retry:
 			goto out_unlock;
 		if (((prot & PROT_EXEC) && !(vma->vm_flags & VM_MAYEXEC)))
 			goto out_unlock;
+		err = -EINVAL;
 		pgprot = protection_map[calc_vm_prot_bits(prot) | VM_SHARED];
 	} else 
 		pgprot = vma->vm_page_prot;
 
-	if ((vma->vm_flags & VM_SHARED) &&
-		(!vma->vm_private_data ||
-			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) &&
-		vma->vm_ops && vma->vm_ops->populate &&
-			end > start && start >= vma->vm_start &&
-				end <= vma->vm_end) {
+	if (!vma->vm_ops || !vma->vm_ops->populate || end <= start || start <
+			vma->vm_start || end > vma->vm_end)
+		goto out_unlock;
+
+	if (!vma->vm_private_data ||
+			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) {
 
 		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != linear_page_index(vma, start) &&
-		    !(vma->vm_flags & VM_NONLINEAR)) {
-			if (!has_write_lock) {
-				up_read(&mm->mmap_sem);
-				down_write(&mm->mmap_sem);
-				has_write_lock = 1;
-				goto retry;
+		if (pgoff != linear_page_index(vma, start)) {
+			if (!(vma->vm_flags & VM_NONLINEAR)) {
+				if (!has_write_lock) {
+					up_read(&mm->mmap_sem);
+					down_write(&mm->mmap_sem);
+					has_write_lock = 1;
+					goto retry;
+				}
+				/* XXX: we check VM_SHARED after re-getting the
+				 * (write) semaphore but I guess that we could
+				 * check it earlier as we're not allowed to turn
+				 * a VM_PRIVATE vma into a VM_SHARED one! */
+				if (!(vma->vm_flags & VM_SHARED))
+					goto out_unlock;
+
+				mapping = vma->vm_file->f_mapping;
+				spin_lock(&mapping->i_mmap_lock);
+				flush_dcache_mmap_lock(mapping);
+				vma->vm_flags |= VM_NONLINEAR;
+				vma_prio_tree_remove(vma, &mapping->i_mmap);
+				vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
+				flush_dcache_mmap_unlock(mapping);
+				spin_unlock(&mapping->i_mmap_lock);
+			} else {
+				/* Won't drop the lock, check it here.*/
+				if (!(vma->vm_flags & VM_SHARED))
+					goto out_unlock;
 			}
-			mapping = vma->vm_file->f_mapping;
-			spin_lock(&mapping->i_mmap_lock);
-			flush_dcache_mmap_lock(mapping);
-			vma->vm_flags |= VM_NONLINEAR;
-			vma_prio_tree_remove(vma, &mapping->i_mmap);
-			vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
-			flush_dcache_mmap_unlock(mapping);
-			spin_unlock(&mapping->i_mmap_lock);
 		}
 
 		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,
diff -puN mm/mmap.c~rfp-private-vma mm/mmap.c
--- linux-2.6.git/mm/mmap.c~rfp-private-vma	2005-08-11 23:02:45.000000000 +0200
+++ linux-2.6.git-paolo/mm/mmap.c	2005-08-11 23:02:45.000000000 +0200
@@ -1120,6 +1120,10 @@ out:	
 	}
 	if (flags & MAP_POPULATE) {
 		up_write(&mm->mmap_sem);
+		/*
+		 * remap_file_pages() works even if the mapping is private,
+		 * in the linearly-mapped case:
+		 */
 		sys_remap_file_pages(addr, len, 0,
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
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
