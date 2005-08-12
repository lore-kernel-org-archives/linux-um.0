Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3k-0004ff-5x	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:12 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3j-0000kw-Gg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:12 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182059.E410A24E0A6@zion.home.lan>
Subject: [uml-devel] [patch 02/39] shmem_populate: avoid an useless check, and
	some comments
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
Date: Fri, 12 Aug 2005 20:20:59 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Either shmem_getpage returns a failure, or it found a page, or it was told it
couldn't do any I/O. So it's useless to check nonblock in the else branch. We
could add a BUG() there but I preferred to comment the offending function.

This was taken out from one Ingo Molnar's old patch I'm resurrecting.

References: commit b103e8b204b317d52834671d5f09db95645523c2 of old-2.6-bkcvs,
pointing to BKrev: 3f5ed0c1llm6NnNwNXtPv-Z0IYzkwA

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/filemap.c |    7 +++++++
 linux-2.6.git-paolo/mm/shmem.c   |    6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff -puN mm/shmem.c~mm-populate-optim-comment mm/shmem.c
--- linux-2.6.git/mm/shmem.c~mm-populate-optim-comment	2005-08-11 11:12:39.000000000 +0200
+++ linux-2.6.git-paolo/mm/shmem.c	2005-08-11 11:12:39.000000000 +0200
@@ -1195,6 +1195,7 @@ static int shmem_populate(struct vm_area
 		err = shmem_getpage(inode, pgoff, &page, sgp, NULL);
 		if (err)
 			return err;
+		/* Page may still be null, but only if nonblock was set. */
 		if (page) {
 			mark_page_accessed(page);
 			err = install_page(mm, vma, addr, page, prot);
@@ -1202,7 +1203,10 @@ static int shmem_populate(struct vm_area
 				page_cache_release(page);
 				return err;
 			}
-		} else if (nonblock) {
+		} else {
+			/* No page was found just because we can't read it in
+			 * now (being here implies nonblock != 0), but the page
+			 * may exist, so set the PTE to fault it in later. */
     			err = install_file_pte(mm, vma, addr, pgoff, prot);
 			if (err)
 	    			return err;
diff -puN mm/filemap.c~mm-populate-optim-comment mm/filemap.c
--- linux-2.6.git/mm/filemap.c~mm-populate-optim-comment	2005-08-11 11:12:39.000000000 +0200
+++ linux-2.6.git-paolo/mm/filemap.c	2005-08-11 11:12:39.000000000 +0200
@@ -1505,8 +1505,12 @@ repeat:
 		return -EINVAL;
 
 	page = filemap_getpage(file, pgoff, nonblock);
+
+	/* XXX: This is wrong, a filesystem I/O error may have happened. Fix that as
+	 * done in shmem_populate calling shmem_getpage */
 	if (!page && !nonblock)
 		return -ENOMEM;
+
 	if (page) {
 		err = install_page(mm, vma, addr, page, prot);
 		if (err) {
@@ -1514,6 +1518,9 @@ repeat:
 			return err;
 		}
 	} else {
+		/* No page was found just because we can't read it in now (being
+		 * here implies nonblock != 0), but the page may exist, so set
+		 * the PTE to fault it in later. */
 		err = install_file_pte(mm, vma, addr, pgoff, prot);
 		if (err)
 			return err;
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
