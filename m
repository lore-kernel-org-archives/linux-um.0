Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XPcGt-00007I-PI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:00:41 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XPcGs-0006kc-Rp
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:00:39 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Thu,  4 Sep 2014 20:00:26 +0100
Message-Id: <1409857227-717756-10-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCH v3 09/10] Better IPC for UBD
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

socketpair() is a better IPC choice for lots of small requests
as it allows deeper (and configurable) queues than pipe()

As a result UBD will process nearly all of the requests submitted
to it instead of bouncing a significant percentage under load

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/drivers/ubd_kern.c |    2 +-
 arch/um/drivers/ubd_user.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 8568290..80f8655 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1268,7 +1268,7 @@ static bool submit_request(struct io_thread_req *io_req, struct ubd *dev)
 	int n = os_write_file(thread_fd, &io_req,
 			     sizeof(io_req));
 	if (n != sizeof(io_req)) {
-		if (n != -EAGAIN)
+		if ((n != -EAGAIN) && (n != -ENOBUFS))
 			printk("write to io thread failed, "
 			       "errno = %d\n", -n);
 		else if (list_empty(&dev->restart))
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index e376f9b..6833fc5 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Copyright (C) 2001 Ridgerun,Inc (glonnon@ridgerun.com)
  * Licensed under the GPL
@@ -25,7 +25,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
 {
 	int pid, fds[2], err;
 
-	err = os_pipe(fds, 1, 1);
+	err = socketpair(AF_UNIX, SOCK_STREAM, 0, (int *) &fds);
 	if(err < 0){
 		printk("start_io_thread - os_pipe failed, err = %d\n", -err);
 		goto out;
-- 
1.7.10.4


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

