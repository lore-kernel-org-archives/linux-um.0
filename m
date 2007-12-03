Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzDIw-0000Qx-JO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 07:33:54 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IzDIv-0002J5-UZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 07:33:54 -0800
Message-Id: <E1IzDHv-0003xj-Af@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 03 Dec 2007 16:32:51 +0100
Subject: [uml-devel] [2.6.24 BUG] 100% iowait on host while UML is running
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jmoyer@redhat.com, zach.brown@oracle.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On 2.6.24, top started showing 100% iowait on one CPU when a UML
instance was running (but completely idle).  I've traced it to this
commit.  Reverting it cures the problem.

Miklos



commit 41d10da3717409de33d5441f2f6d8f072ab3fbb6
Author: Jeff Moyer <jmoyer@redhat.com>
Date:   Tue Oct 16 23:27:20 2007 -0700

    aio: account I/O wait time properly
    
    Some months back I proposed changing the schedule() call in
    read_events to an io_schedule():
    	http://osdir.com/ml/linux.kernel.aio.general/2006-10/msg00024.html
    This was rejected as there are AIO operations that do not initiate
    disk I/O.  I've had another look at the problem, and the only AIO
    operation that will not initiate disk I/O is IOCB_CMD_NOOP.  However,
    this command isn't even wired up!
    
    Given that it doesn't work, and hasn't for *years*, I'm going to
    suggest again that we do proper I/O accounting when using AIO.
    
    Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
    Acked-by: Zach Brown <zach.brown@oracle.com>
    Cc: Benjamin LaHaise <bcrl@kvack.org>
    Cc: Suparna Bhattacharya <suparna@in.ibm.com>
    Cc: Badari Pulavarty <pbadari@us.ibm.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/fs/aio.c b/fs/aio.c
index ea2e198..d02f43b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -303,7 +303,7 @@ static void wait_for_all_aios(struct kioctx *ctx)
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	while (ctx->reqs_active) {
 		spin_unlock_irq(&ctx->ctx_lock);
-		schedule();
+		io_schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		spin_lock_irq(&ctx->ctx_lock);
 	}
@@ -323,7 +323,7 @@ ssize_t fastcall wait_on_sync_kiocb(struct kiocb *iocb)
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!iocb->ki_users)
 			break;
-		schedule();
+		io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
 	return iocb->ki_user_data;
@@ -1170,7 +1170,7 @@ retry:
 			ret = 0;
 			if (to.timed_out)	/* Only check after read evt */
 				break;
-			schedule();
+			io_schedule();
 			if (signal_pending(tsk)) {
 				ret = -EINTR;
 				break;

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
