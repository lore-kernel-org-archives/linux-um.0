Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaU-0006YL-Eu	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:02 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eaU-0007eQ-93
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:02 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183619.CA89224E7E1@zion.home.lan>
Subject: [uml-devel] [patch 32/39] remap_file_pages protection support: fix
	i386 handler
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
Date: Fri, 12 Aug 2005 20:36:19 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Actually, with the current model, we should get a failure with VMA's mapped
with only PROT_WRITE (even if I wasn't able to verify that in UML, which has
similar code).

To test!

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/mm/fault.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/mm/fault.c~rfp-fault-sigsegv-3-i386 arch/i386/mm/fault.c
--- linux-2.6.git/arch/i386/mm/fault.c~rfp-fault-sigsegv-3-i386	2005-08-12 17:12:51.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/mm/fault.c	2005-08-12 17:12:51.000000000 +0200
@@ -381,7 +381,8 @@ bad_area_prot:
 		 * requirements... we should always test just
 		 * pte_read/write/exec, on vma->vm_page_prot! This way is
 		 * cumbersome. However, for now things should work for i386. */
-		access_mask |= vma->vm_flags & VM_EXEC ? VM_EXEC : VM_READ;
+		access_mask |= vma->vm_flags & VM_EXEC ? VM_EXEC :
+			(vma->vm_flags & VM_READ ? VM_READ : VM_WRITE );
 		goto handle_fault;
 	}
 /*
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
