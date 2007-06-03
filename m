Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hutnt-0002Bu-Lv for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 10:23:45 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hutns-0004E0-7F
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 10:23:45 -0700
Date: Sun, 3 Jun 2007 13:15:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070603171534.GA30116@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] syslets demo - fix malloc failure check
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Zach Brown <zach.brown@oracle.com>, Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Fix the stack malloc failure check.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 syslets/async-test-v5/sys.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/syslets/async-test-v5/sys.h
===================================================================
--- linux-2.6.orig/syslets/async-test-v5/sys.h	2007-05-31 13:29:57.000000000 -0400
+++ linux-2.6/syslets/async-test-v5/sys.h	2007-06-03 13:12:43.000000000 -0400
@@ -108,9 +108,10 @@ static u64 completion_ring[MAX_PENDING];
 
 static unsigned long thread_stack_alloc()
 {
-	void *stack = malloc(THREAD_STACK_SIZE) + THREAD_STACK_SIZE;
+	void *stack = malloc(THREAD_STACK_SIZE);
 	assert(stack != NULL);
 
+	stack += THREAD_STACK_SIZE;
 	pr("allocated stack: %p\n", stack);
 
 	return (unsigned long)stack;

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
