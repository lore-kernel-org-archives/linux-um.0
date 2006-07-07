Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeHp-0006ap-NU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:37 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeHo-0000ik-Tm
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:37 -0700
Message-Id: <200607070033.k670XmJx008722@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 06 Jul 2006 20:33:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 13/19] UML - Make some symbols static
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

A few sigio-related things can be made static.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/os.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/os.h	2006-07-06 13:28:50.000000000 -0400
+++ linux-2.6.17/arch/um/include/os.h	2006-07-06 13:28:59.000000000 -0400
@@ -329,7 +329,6 @@ extern void os_set_ioignore(void);
 extern void init_irq_signals(int on_sigstack);
 
 /* sigio.c */
-extern int add_sigio_fd(int fd, int read);
 extern int ignore_sigio_fd(int fd);
 extern void maybe_sigio_broken(int fd, int read);
 
Index: linux-2.6.17/arch/um/kernel/sigio_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/sigio_kern.c	2006-07-06 13:22:13.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/sigio_kern.c	2006-07-06 13:28:59.000000000 -0400
@@ -53,17 +53,3 @@ void sigio_unlock(void)
 {
 	spin_unlock(&sigio_spinlock);
 }
-
-extern void sigio_cleanup(void);
-__uml_exitcall(sigio_cleanup);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.17/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sigio.c	2006-07-06 13:28:57.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sigio.c	2006-07-06 13:28:59.000000000 -0400
@@ -43,13 +43,13 @@ struct pollfds {
 /* Protected by sigio_lock().  Used by the sigio thread, but the UML thread
  * synchronizes with it.
  */
-struct pollfds current_poll = {
+static struct pollfds current_poll = {
 	.poll  		= NULL,
 	.size 		= 0,
 	.used 		= 0
 };
 
-struct pollfds next_poll = {
+static struct pollfds next_poll = {
 	.poll  		= NULL,
 	.size 		= 0,
 	.used 		= 0
@@ -156,7 +156,7 @@ static void update_thread(void)
 	set_signals(flags);
 }
 
-int add_sigio_fd(int fd, int read)
+static int add_sigio_fd(int fd, int read)
 {
 	int err = 0, i, n, events;
 
@@ -333,10 +333,12 @@ void maybe_sigio_broken(int fd, int read
 	add_sigio_fd(fd, read);
 }
 
-void sigio_cleanup(void)
+static void sigio_cleanup(void)
 {
 	if(write_sigio_pid != -1){
 		os_kill_process(write_sigio_pid, 1);
 		write_sigio_pid = -1;
 	}
 }
+
+__uml_exitcall(sigio_cleanup);


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
