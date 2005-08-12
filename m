Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3o-0004gQ-4p	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:16 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3n-00009V-FM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:16 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182132.E0D7024E7E4@zion.home.lan>
Subject: [uml-devel] [patch 14/39] remap_file_pages protection support: assume
	VM_SHARED never disappears
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
Date: Fri, 12 Aug 2005 20:21:32 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Assume that even after dropping and reacquiring the lock, (vma->vm_flags &
VM_SHARED) won't change, thus moving a check earlier.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff -puN mm/fremap.c~rfp-assume-VM_PRIVATE-stays mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-assume-VM_PRIVATE-stays	2005-08-11 12:58:07.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 13:38:56.000000000 +0200
@@ -232,6 +232,8 @@ retry:
 
 		/* Must set VM_NONLINEAR before any pages are populated. */
 		if (pgoff != linear_page_index(vma, start)) {
+			if (!(vma->vm_flags & VM_SHARED))
+				goto out_unlock;
 			if (!(vma->vm_flags & VM_NONLINEAR)) {
 				if (!has_write_lock) {
 					up_read(&mm->mmap_sem);
@@ -239,12 +241,6 @@ retry:
 					has_write_lock = 1;
 					goto retry;
 				}
-				/* XXX: we check VM_SHARED after re-getting the
-				 * (write) semaphore but I guess that we could
-				 * check it earlier as we're not allowed to turn
-				 * a VM_PRIVATE vma into a VM_SHARED one! */
-				if (!(vma->vm_flags & VM_SHARED))
-					goto out_unlock;
 
 				mapping = vma->vm_file->f_mapping;
 				spin_lock(&mapping->i_mmap_lock);
@@ -254,10 +250,6 @@ retry:
 				vma_nonlinear_insert(vma, &mapping->i_mmap_nonlinear);
 				flush_dcache_mmap_unlock(mapping);
 				spin_unlock(&mapping->i_mmap_lock);
-			} else {
-				/* Won't drop the lock, check it here.*/
-				if (!(vma->vm_flags & VM_SHARED))
-					goto out_unlock;
 			}
 		}
 
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
