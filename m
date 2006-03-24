Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqnA-0003ak-Vz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:44 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqnA-0005cW-FM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:44 -0800
Message-Id: <200603241815.k2OIF5lw005570@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 15/16] UML - Fix thread startup race
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
Date: Fri, 24 Mar 2006 13:15:05 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

This fixes a race in the starting of write_sigio_thread.
Previously, some of the data needed by the thread was initialized
after the clone.  If the thread ran immediately, it would see the
uninitialized data, including an empty pollfds, which would cause it
to hang.
We move the data initialization to before the clone, and adjust the
error paths and cleanup accordingly.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/sigio.c	2006-03-23 18:55:38.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/sigio.c	2006-03-23 21:10:27.000000000 -0500
@@ -29,8 +29,10 @@ static int write_sigio_pid = -1;
  * the descriptors closed after it is killed.  So, it can't see them change.
  * On the UML side, they are changed under the sigio_lock.
  */
-static int write_sigio_fds[2] = { -1, -1 };
-static int sigio_private[2] = { -1, -1 };
+#define SIGIO_FDS_INIT {-1, -1}
+
+static int write_sigio_fds[2] = SIGIO_FDS_INIT;
+static int sigio_private[2] = SIGIO_FDS_INIT;
 
 struct pollfds {
 	struct pollfd *poll;
@@ -270,49 +272,46 @@ void write_sigio_workaround(void)
 	/* Did we race? Don't try to optimize this, please, it's not so likely
 	 * to happen, and no more than once at the boot. */
 	if(write_sigio_pid != -1)
-		goto out_unlock;
-
-	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
-					    CLONE_FILES | CLONE_VM, &stack, 0);
+		goto out_free;
 
-	if (write_sigio_pid < 0)
-		goto out_clear;
+	current_poll = ((struct pollfds) { .poll 	= p,
+					   .used 	= 1,
+					   .size 	= 1 });
 
 	if (write_sigio_irq(l_write_sigio_fds[0]))
-		goto out_kill;
+		goto out_clear_poll;
 
-	/* Success, finally. */
 	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
 	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
 
-	current_poll = ((struct pollfds) { .poll 	= p,
-					   .used 	= 1,
-					   .size 	= 1 });
+	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
+					    CLONE_FILES | CLONE_VM, &stack, 0);
 
-	sigio_unlock();
-	return;
+	if (write_sigio_pid < 0)
+		goto out_clear;
 
- out_kill:
-	l_write_sigio_pid = write_sigio_pid;
-	write_sigio_pid = -1;
 	sigio_unlock();
-	/* Going to call waitpid, avoid holding the lock. */
-	os_kill_process(l_write_sigio_pid, 1);
-	goto out_free;
+	return;
 
- out_clear:
+out_clear:
 	write_sigio_pid = -1;
- out_unlock:
-	sigio_unlock();
- out_free:
+	write_sigio_fds[0] = -1;
+	write_sigio_fds[1] = -1;
+	sigio_private[0] = -1;
+	sigio_private[1] = -1;
+out_clear_poll:
+	current_poll = ((struct pollfds) { .poll	= NULL,
+					   .size	= 0,
+					   .used	= 0 });
+out_free:
 	kfree(p);
- out_close2:
+	sigio_unlock();
+out_close2:
 	close(l_sigio_private[0]);
 	close(l_sigio_private[1]);
- out_close1:
+out_close1:
 	close(l_write_sigio_fds[0]);
 	close(l_write_sigio_fds[1]);
-	return;
 }
 
 void sigio_cleanup(void)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
