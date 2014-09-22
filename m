Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XW6tr-0000cd-6w
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 16:55:43 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XW6tq-0005I1-FZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 16:55:43 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Mon, 22 Sep 2014 17:53:24 +0100
Message-Id: <1411404804-871910-12-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH v4 11/11] Replace fsync() with sync_file_range()
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

If the ubd is asynchronous the amount of time uml will spend
fsync-ing on FLUSH is unpredictable. There are bits in the upper fs
layers that really dislike this. Replacing fsync() with an
async flush request via sync_file_range mitigates this (somewhat),
improves performance significantly without making filesystem integrity
much worse (compared to the original async writes + flush).

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---

 arch/um/drivers/ubd.h      |    1 +
 arch/um/drivers/ubd_kern.c |    2 +-
 arch/um/drivers/ubd_user.c |    7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd.h b/arch/um/drivers/ubd.h
index 3b48cd2..5847fff 100644
--- a/arch/um/drivers/ubd.h
+++ b/arch/um/drivers/ubd.h
@@ -8,6 +8,7 @@
 #define __UM_UBD_USER_H
 
 extern int start_io_thread(unsigned long sp, int *fds_out);
+extern int ubd_async_fsync(int fd);
 extern int io_thread(void *arg);
 extern int kernel_fd;
 
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 80f8655..ccfaa9d 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1410,7 +1410,7 @@ static void do_io(struct io_thread_req *req)
 
 	if (req->op == UBD_FLUSH) {
 		/* fds[0] is always either the rw image or our cow file */
-		n = os_sync_file(req->fds[0]);
+		n = ubd_async_fsync(req->fds[0]);
 		if (n != 0) {
 			printk("do_io - sync failed err = %d "
 			       "fd = %d\n", -n, req->fds[0]);
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index 6833fc5..4970087 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -17,10 +17,17 @@
 #include <sys/param.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <fcntl.h>
 
 #include "ubd.h"
 #include <os.h>
 
+int ubd_async_fsync(int fd) {
+	int ret;
+	CATCH_EINTR(ret = sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WRITE));
+	return ret;
+}
+
 int start_io_thread(unsigned long sp, int *fd_out)
 {
 	int pid, fds[2], err;
-- 
1.7.10.4


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

