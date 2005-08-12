Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e4r-0004k8-7A	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:16:21 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e4q-0000PI-Kz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:16:21 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182105.28FD924E7CA@zion.home.lan>
Subject: [uml-devel] [patch 04/39] remove implied vm_ops check
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
Date: Fri, 12 Aug 2005 20:21:04 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

If !vma->vm-ops we already BUG above, so retesting it is useless. The compiler
cannot optimize this because BUG is a macro and is not thus marked noreturn;
that should possibly be fixed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/memory.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN mm/memory.c~remove-implied-vm_ops-check mm/memory.c
--- linux-2.6.git/mm/memory.c~remove-implied-vm_ops-check	2005-08-11 11:05:20.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-11 11:05:47.000000000 +0200
@@ -1933,7 +1933,7 @@ static int do_file_page(struct mm_struct
 	 * Fall back to the linear mapping if the fs does not support
 	 * ->populate:
 	 */
-	if (!vma->vm_ops || !vma->vm_ops->populate || 
+	if (!vma->vm_ops->populate ||
 			(write_access && !(vma->vm_flags & VM_SHARED))) {
 		pte_clear(mm, address, pte);
 		return do_no_page(mm, vma, address, write_access, pte, pmd);
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
