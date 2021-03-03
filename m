Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTqx-005UJN-KI
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 15:56:05 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 08/27] um: Reap winch thread if it fails
Date: Wed,  3 Mar 2021 16:55:04 +0100
Message-Id: <20210303155523.124277-9-benjamin@sipsolutions.net>
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

When the winch thread runs into an error condition, it would exit(1) and
never be reaped until shutdown time. Change this to write a command byte
which causes the driver to kill it, therefore reaping the child.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/drivers/chan_user.c | 15 ++++++++++-----
 arch/um/drivers/line.c      | 13 ++++++++-----
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 9d87c9998741..57547bdcb5c6 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -141,7 +141,7 @@ struct winch_data {
 	int pipe_fd;
 };
 
-static int winch_thread(void *arg)
+static __noreturn int winch_thread(void *arg)
 {
 	struct winch_data *data = arg;
 	sigset_t sigs;
@@ -168,7 +168,7 @@ static int winch_thread(void *arg)
 	if (sigprocmask(SIG_SETMASK, &sigs, NULL) < 0) {
 		os_info("winch_thread : sigprocmask failed, errno = %d\n",
 			errno);
-		exit(1);
+		goto wait_kill;
 	}
 	/* In sigsuspend(), block anything else than SIGWINCH. */
 	sigdelset(&sigs, SIGWINCH);
@@ -176,19 +176,19 @@ static int winch_thread(void *arg)
 	if (setsid() < 0) {
 		os_info("winch_thread : setsid failed, errno = %d\n",
 		       errno);
-		exit(1);
+		goto wait_kill;
 	}
 
 	if (ioctl(pty_fd, TIOCSCTTY, 0) < 0) {
 		os_info("winch_thread : TIOCSCTTY failed on "
 			"fd %d err = %d\n", pty_fd, errno);
-		exit(1);
+		goto wait_kill;
 	}
 
 	if (tcsetpgrp(pty_fd, os_getpid()) < 0) {
 		os_info("winch_thread : tcsetpgrp failed on fd %d err = %d\n",
 			pty_fd, errno);
-		exit(1);
+		goto wait_kill;
 	}
 
 	/*
@@ -214,6 +214,11 @@ static int winch_thread(void *arg)
 			os_info("winch_thread : write failed, err = %d\n",
 				errno);
 	}
+
+wait_kill:
+	c = 2;
+	count = write(pipe_fd, &c, sizeof(c));
+	while (1) { pause(); };
 }
 
 static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 1c70a31e7c5b..b2800a085a3b 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -629,15 +629,18 @@ static irqreturn_t winch_interrupt(int irq, void *data)
 
 	if (fd != -1) {
 		err = generic_read(fd, &c, NULL);
-		if (err < 0) {
+		/* A read of 2 means the winch thread failed and has warned */
+		if (err < 0 || (err = 1 && c == 2)) {
 			if (err != -EAGAIN) {
 				winch->fd = -1;
 				list_del(&winch->list);
 				os_close_file(fd);
-				printk(KERN_ERR "winch_interrupt : "
-				       "read failed, errno = %d\n", -err);
-				printk(KERN_ERR "fd %d is losing SIGWINCH "
-				       "support\n", winch->tty_fd);
+				if (err < 0) {
+					printk(KERN_ERR "winch_interrupt : read failed, errno = %d\n",
+					       -err);
+					printk(KERN_ERR "fd %d is losing SIGWINCH support\n",
+					       winch->tty_fd);
+				}
 				INIT_WORK(&winch->work, __free_winch);
 				schedule_work(&winch->work);
 				return IRQ_HANDLED;
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

