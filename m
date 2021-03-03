Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTqx-005UJI-AJ
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 15:56:07 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 07/27] um: Do not use printk in SIGWINCH helper thread
Date: Wed,  3 Mar 2021 16:55:03 +0100
Message-Id: <20210303155523.124277-8-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>

The thread is running outside of the UML kernel scope and is a helper.
As such, printk cannot work and os_info must be used instead.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/drivers/chan_user.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index d8845d4aac6a..9d87c9998741 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -153,8 +153,8 @@ static int winch_thread(void *arg)
 	pipe_fd = data->pipe_fd;
 	count = write(pipe_fd, &c, sizeof(c));
 	if (count != sizeof(c))
-		printk(UM_KERN_ERR "winch_thread : failed to write "
-		       "synchronization byte, err = %d\n", -count);
+		os_info("winch_thread : failed to write synchronization byte, err = %d\n",
+			-count);
 
 	/*
 	 * We are not using SIG_IGN on purpose, so don't fix it as I thought to
@@ -166,28 +166,28 @@ static int winch_thread(void *arg)
 	sigfillset(&sigs);
 	/* Block all signals possible. */
 	if (sigprocmask(SIG_SETMASK, &sigs, NULL) < 0) {
-		printk(UM_KERN_ERR "winch_thread : sigprocmask failed, "
-		       "errno = %d\n", errno);
+		os_info("winch_thread : sigprocmask failed, errno = %d\n",
+			errno);
 		exit(1);
 	}
 	/* In sigsuspend(), block anything else than SIGWINCH. */
 	sigdelset(&sigs, SIGWINCH);
 
 	if (setsid() < 0) {
-		printk(UM_KERN_ERR "winch_thread : setsid failed, errno = %d\n",
+		os_info("winch_thread : setsid failed, errno = %d\n",
 		       errno);
 		exit(1);
 	}
 
 	if (ioctl(pty_fd, TIOCSCTTY, 0) < 0) {
-		printk(UM_KERN_ERR "winch_thread : TIOCSCTTY failed on "
-		       "fd %d err = %d\n", pty_fd, errno);
+		os_info("winch_thread : TIOCSCTTY failed on "
+			"fd %d err = %d\n", pty_fd, errno);
 		exit(1);
 	}
 
 	if (tcsetpgrp(pty_fd, os_getpid()) < 0) {
-		printk(UM_KERN_ERR "winch_thread : tcsetpgrp failed on "
-		       "fd %d err = %d\n", pty_fd, errno);
+		os_info("winch_thread : tcsetpgrp failed on fd %d err = %d\n",
+			pty_fd, errno);
 		exit(1);
 	}
 
@@ -199,8 +199,8 @@ static int winch_thread(void *arg)
 	 */
 	count = read(pipe_fd, &c, sizeof(c));
 	if (count != sizeof(c))
-		printk(UM_KERN_ERR "winch_thread : failed to read "
-		       "synchronization byte, err = %d\n", errno);
+		os_info("winch_thread : failed to read synchronization byte, err = %d\n",
+			errno);
 
 	while(1) {
 		/*
@@ -211,8 +211,8 @@ static int winch_thread(void *arg)
 
 		count = write(pipe_fd, &c, sizeof(c));
 		if (count != sizeof(c))
-			printk(UM_KERN_ERR "winch_thread : write failed, "
-			       "err = %d\n", errno);
+			os_info("winch_thread : write failed, err = %d\n",
+				errno);
 	}
 }
 
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

