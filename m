Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRYgP-0007my-HQ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 10:54:13 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRYgP-0007eV-BB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 10:54:13 -0700
Message-Id: <200604061655.k36GtMvc005146@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/2] Add GFP_NOWAIT
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
Date: Thu, 06 Apr 2006 12:55:22 -0400
To: akpm@osdl.org
Cc: linux-xfs@oss.sgi.com, Daniel Phillips <phillips@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Introduce GFP_NOWAIT, as an alias for GFP_ATOMIC & ~__GFP_HIGH.

This also changes XFS, which is the only in-tree user of this idiom that I 
could find.  The XFS piece is compile-tested only.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.16.orig/fs/xfs/linux-2.6/xfs_buf.c	2006-04-06 12:16:14.000000000 -0400
+++ linux-2.6.16/fs/xfs/linux-2.6/xfs_buf.c	2006-04-06 12:16:54.000000000 -0400
@@ -182,7 +182,7 @@ free_address(
 {
 	a_list_t	*aentry;
 
-	aentry = kmalloc(sizeof(a_list_t), GFP_ATOMIC & ~__GFP_HIGH);
+	aentry = kmalloc(sizeof(a_list_t), GFP_NOWAIT);
 	if (likely(aentry)) {
 		spin_lock(&as_lock);
 		aentry->next = as_free_head;
Index: linux-2.6.16/include/linux/gfp.h
===================================================================
--- linux-2.6.16.orig/include/linux/gfp.h	2006-03-21 11:50:12.000000000 -0500
+++ linux-2.6.16/include/linux/gfp.h	2006-04-06 12:15:18.000000000 -0400
@@ -57,6 +57,8 @@ struct vm_area_struct;
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
 			__GFP_NOMEMALLOC|__GFP_HARDWALL)
 
+/* This equals 0, but use constants in case they ever change */
+#define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
 /* GFP_ATOMIC means both !wait (__GFP_WAIT not set) and use emergency pool */
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
