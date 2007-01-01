Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1TCv-0005oz-Hz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:29 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H1TCp-0004xk-VJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:26 -0800
Message-Id: <200701011947.l01Jl7vp020746@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 01 Jan 2007 14:47:07 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/8] UML - watchdog driver locking
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Replace BKL use with a spinlock.

Also fix the control so that open doesn't return holding a lock.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/harddog_kern.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/harddog_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/harddog_kern.c	2006-12-29 18:25:36.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/harddog_kern.c	2006-12-29 21:02:50.000000000 -0500
@@ -44,12 +44,13 @@
 #include <linux/reboot.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include <asm/uaccess.h>
 #include "mconsole.h"
 
 MODULE_LICENSE("GPL");
 
-/* Locked by the BKL in harddog_open and harddog_release */
+static DEFINE_SPINLOCK(lock);
 static int timer_alive;
 static int harddog_in_fd = -1;
 static int harddog_out_fd = -1;
@@ -62,12 +63,12 @@ extern int start_watchdog(int *in_fd_ret
 
 static int harddog_open(struct inode *inode, struct file *file)
 {
-	int err;
+	int err = -EBUSY;
 	char *sock = NULL;
 
-	lock_kernel();
+	spin_lock(&lock);
 	if(timer_alive)
-		return -EBUSY;
+		goto err;
 #ifdef CONFIG_HARDDOG_NOWAYOUT	 
 	__module_get(THIS_MODULE);
 #endif
@@ -76,11 +77,15 @@ static int harddog_open(struct inode *in
 	sock = mconsole_notify_socket();
 #endif
 	err = start_watchdog(&harddog_in_fd, &harddog_out_fd, sock);
-	if(err) return(err);
+	if(err)
+		goto err;
 
 	timer_alive = 1;
-	unlock_kernel();
+	spin_unlock(&lock);
 	return nonseekable_open(inode, file);
+err:
+	spin_unlock(&lock);
+	return err;
 }
 
 extern void stop_watchdog(int in_fd, int out_fd);
@@ -90,14 +95,16 @@ static int harddog_release(struct inode 
 	/*
 	 *	Shut off the timer.
 	 */
-	lock_kernel();
+
+	spin_lock(&lock);
 
 	stop_watchdog(harddog_in_fd, harddog_out_fd);
 	harddog_in_fd = -1;
 	harddog_out_fd = -1;
 
 	timer_alive=0;
-	unlock_kernel();
+	spin_unlock(&lock);
+
 	return 0;
 }
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
