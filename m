Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtpMe-0002To-VH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 May 2007 11:27:16 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HtpMe-0003HI-EP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 May 2007 11:27:12 -0700
Date: Thu, 31 May 2007 14:19:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070531181923.GA9904@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] Syslets - Fix cachemiss_thread return value
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

cachemiss_thread should explicitly return 0 or error instead of
task_ret_reg(current) (which is -ENOSYS anyway) because
async_thread_helper is careful to put the return value in eax anyway.

On x86_64, it looks like async_child_rip is similarly careful.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 kernel/async.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/async.c
===================================================================
--- linux-2.6.orig/kernel/async.c	2007-05-29 20:11:11.000000000 -0400
+++ linux-2.6/kernel/async.c	2007-05-31 14:12:49.000000000 -0400
@@ -575,7 +575,7 @@ static long cachemiss_thread(void *data)
 	struct task_struct *t = current;
 	struct async_head *ah = args->ah;
 	struct async_thread *at;
-	int ret;
+	int ret = 0;
 
 	at = &t->__at;
 	async_thread_init(t, at, ah);
@@ -607,7 +607,7 @@ static long cachemiss_thread(void *data)
 	complete(&ah->start_done);
 
 	async_cachemiss_loop(at, ah, t);
-	return task_ret_reg(t);
+	return ret;
 }
 
 /**

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
