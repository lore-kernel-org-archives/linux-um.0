Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ea6-0006WI-H1	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:38 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3ea5-0007ca-4m
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:38 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183549.160DD24B4FD@zion.home.lan>
Subject: [uml-devel] [patch 21/39] remap_file_pages protection support: use
	EOVERFLOW ret code
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
Date: Fri, 12 Aug 2005 20:35:48 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Use -EOVERFLOW ("Value too large for defined data type") rather than -EINVAL
when we cannot store the file offset in the PTE.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN mm/fremap.c~rfp-ef2big-ret-code mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-ef2big-ret-code	2005-08-11 23:04:59.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 23:04:59.000000000 +0200
@@ -213,7 +213,7 @@ asmlinkage long sys_remap_file_pages(uns
 	/* Can we represent this offset inside this architecture's pte's? */
 #if PTE_FILE_MAX_BITS < BITS_PER_LONG
 	if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
-		return err;
+		return -EOVERFLOW;
 #endif
 
 	/* We need down_write() to change vma->vm_flags. */
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
