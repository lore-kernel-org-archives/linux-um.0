Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw4BW-0006tV-OO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:26 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fw4BW-0005L9-11
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:26 -0700
Message-Id: <200606292136.k5TLaVWf010807@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 29 Jun 2006 17:36:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/9] UML - unregister useless console when it's
	not needed
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

-mm in combination with an FC5 init started dying with 'stderr=1'
because init didn't like the lack of /dev/console and exited.  The
problem was that the stderr console, which is intended to dump printk
output to the terminal before the regular console is initialized,
isn't a tty, and so can't make /dev/console operational.

However, since it is registered first, the normal console, when it is
registered, doesn't become the preferred console, and isn't attached
to /dev/console.  Thus, /dev/console is never operational.

This patch makes the stderr console unregister itself in an initcall,
which is late enough that the normal console is registered.  When that
happens, the normal console will become the preferred console and will
be able to run /dev/console.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/drivers/stderr_console.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/drivers/stderr_console.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.17-mm/arch/um/drivers/stderr_console.c	2006-06-28 22:59:46.000000000 -0400
@@ -8,10 +8,7 @@
 
 /*
  * Don't register by default -- as this registeres very early in the
- * boot process it becomes the default console.  And as this isn't a
- * real tty driver init isn't able to open /dev/console then.
- *
- * In most cases this isn't what you want ...
+ * boot process it becomes the default console.
  */
 static int use_stderr_console = 0;
 
@@ -43,3 +40,20 @@ static int stderr_setup(char *str)
 	return 1;
 }
 __setup("stderr=", stderr_setup);
+
+/* The previous behavior of not unregistering led to /dev/console being
+ * impossible to open.  My FC5 filesystem started having init die, and the
+ * system panicing because of this.  Unregistering causes the real
+ * console to become the default console, and /dev/console can then be
+ * opened.  Making this an initcall makes this happen late enough that
+ * there is no added value in dumping everything to stderr, and the
+ * normal console is good enough to show you all available output.
+ */
+static int __init unregister_stderr(void)
+{
+	unregister_console(&stderr_console);
+
+	return 0;
+}
+
+__initcall(unregister_stderr);


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
