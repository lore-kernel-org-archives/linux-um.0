Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3e-0004f0-0x	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:06 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3d-0000jt-DE
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:05 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182057.1DC0C24B4FD@zion.home.lan>
Subject: [uml-devel] [patch 01/39] comment typo fix
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
Date: Fri, 12 Aug 2005 20:20:56 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

smp_entry_t -> swap_entry_t

Too short changelog entry?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/swapops.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/swapops.h~fix-typo include/linux/swapops.h
--- linux-2.6.git/include/linux/swapops.h~fix-typo	2005-08-11 11:12:23.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/swapops.h	2005-08-11 11:12:24.000000000 +0200
@@ -4,7 +4,7 @@
  * the low-order bits.
  *
  * We arrange the `type' and `offset' fields so that `type' is at the five
- * high-order bits of the smp_entry_t and `offset' is right-aligned in the
+ * high-order bits of the swap_entry_t and `offset' is right-aligned in the
  * remaining bits.
  *
  * swp_entry_t's are *never* stored anywhere in their arch-dependent format.
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
