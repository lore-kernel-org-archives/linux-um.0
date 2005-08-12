Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3h-0004fQ-V2	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:09 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3h-00007I-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:09 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182108.3C7C624E7CC@zion.home.lan>
Subject: [uml-devel] [patch 05/39] remove stale comment from swapfile.c
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
Date: Fri, 12 Aug 2005 20:21:07 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Seems like on 2.4.9.4 this comment got out of sync ;-)

I'm not completely sure on which basis we don't need any more to do as the
comment suggests, but it seems that when faulting in a second time the same
swap page,  can_share_swap_page() returns false, and we do an early COW break,
so there's no need to write-protect the page.

No idea why we don't defer the COW break.

Reference commit from GIT version of BKCVS history:
5ee46c7964de4b1969fc5be036167eb2da0de4e2, BKRev 3c603c81PtWl2I1NnVuphvsItrD1hg
(v2.4.9.3 -> v2.4.9.4).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/swapfile.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

diff -puN mm/swapfile.c~remove-stale-comment-swap-file mm/swapfile.c
--- linux-2.6.git/mm/swapfile.c~remove-stale-comment-swap-file	2005-08-11 11:13:18.000000000 +0200
+++ linux-2.6.git-paolo/mm/swapfile.c	2005-08-11 11:13:18.000000000 +0200
@@ -388,10 +388,7 @@ void free_swap_and_cache(swp_entry_t ent
 }
 
 /*
- * Always set the resulting pte to be nowrite (the same as COW pages
- * after one process has exited).  We don't know just how many PTEs will
- * share this swap entry, so be cautious and let do_wp_page work out
- * what to do if a write is requested later.
+ * Since we're swapping it in, we mark it as old.
  *
  * vma->vm_mm->page_table_lock is held.
  */
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
