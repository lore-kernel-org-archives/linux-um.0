Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GMqNq-0005r6-DY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Sep 2006 11:19:50 -0700
Received: from [81.2.110.250] (helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GMqNo-00077u-Pn
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Sep 2006 11:19:50 -0700
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 11 Sep 2006 19:43:00 +0100
Message-Id: <1158000180.23085.201.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [uml-devel] [PATCH] UML - tty locking
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
To: akpm@osdl.org, jdike@karaya.com

Jeff this is the tty locking diff I mentioned at Linux Kongress, it just
ensures current->signal->tty doesn't get freed during log_exec().

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/arch/um/kernel/exec.c linux-2.6.18-rc6-mm1/arch/um/kernel/exec.c
--- linux.vanilla-2.6.18-rc6-mm1/arch/um/kernel/exec.c	2006-09-11 11:02:11.000000000 +0100
+++ linux-2.6.18-rc6-mm1/arch/um/kernel/exec.c	2006-09-11 17:16:36.000000000 +0100
@@ -41,9 +41,11 @@
         long error;
 
 #ifdef CONFIG_TTY_LOG
-	task_lock(current);
+	mutex_lock(&tty_mutex);
+	task_lock(current);	/* FIXME:  is this needed ? */
 	log_exec(argv, current->signal->tty);
 	task_unlock(current);
+	mutex_unlock(&tty_mutex);
 #endif
         error = do_execve(file, argv, env, &current->thread.regs);
         if (error == 0){


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
