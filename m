Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I0ifJ-0005ZD-Fp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2007 11:42:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I0ifH-0001TD-Q0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2007 11:42:57 -0700
Date: Tue, 19 Jun 2007 14:42:45 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070619184245.GA10562@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - Use get_free_pages to allocate kernel
	stacks
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

For some reason, I was using kmalloc instead of get_free_pages for
kernel stacks.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 include/asm-um/thread_info.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.21-mm/include/asm-um/thread_info.h
===================================================================
--- linux-2.6.21-mm.orig/include/asm-um/thread_info.h	2007-06-19 12:23:16.000000000 -0400
+++ linux-2.6.21-mm/include/asm-um/thread_info.h	2007-06-19 14:06:36.000000000 -0400
@@ -54,8 +54,10 @@ static inline struct thread_info *curren
 
 /* thread information allocation */
 #define alloc_thread_info(tsk) \
-	((struct thread_info *) kmalloc(THREAD_SIZE, GFP_KERNEL))
-#define free_thread_info(ti) kfree(ti)
+	((struct thread_info *) __get_free_pages(GFP_KERNEL, \
+						 CONFIG_KERNEL_STACK_ORDER))
+#define free_thread_info(ti) \
+	free_pages((unsigned long)(ti),CONFIG_KERNEL_STACK_ORDER)
 
 #endif
 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
