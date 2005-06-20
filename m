Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkRSa-0000sU-DJ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:57:28 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DkRSZ-0007WD-N6	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:57:28 -0700
Message-Id: <200506201851.j5KIpJux008493@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/8] UML - Always disable kmalloc during shutdown
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
Date: Mon, 20 Jun 2005 14:51:19 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

kmalloc wasn't being disabled during panic.  This patch ensures that, no
matter how UML is exiting, it is disabled.  This matters because part of
the cleanup is to remove the umid file, which involves readdir, which calls
malloc.  This must map to libc malloc, rather than kmalloc or vmalloc.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/main.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/main.c	2005-06-20 11:54:50.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/main.c	2005-06-20 12:08:11.000000000 -0400
@@ -69,7 +69,6 @@ static __init void do_uml_initcalls(void
 
 static void last_ditch_exit(int sig)
 {
-        kmalloc_ok = 0;
 	signal(SIGINT, SIG_DFL);
 	signal(SIGTERM, SIG_DFL);
 	signal(SIGHUP, SIG_DFL);
Index: linux-2.6.12/arch/um/kernel/reboot.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/reboot.c	2005-06-20 11:54:45.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/reboot.c	2005-06-20 12:07:55.000000000 -0400
@@ -38,14 +38,14 @@ static void kill_off_processes(void)
 
 void uml_cleanup(void)
 {
-	kill_off_processes();
+        kmalloc_ok = 0;
 	do_uml_exitcalls();
+	kill_off_processes();
 }
 
 void machine_restart(char * __unused)
 {
-	do_uml_exitcalls();
-	kill_off_processes();
+        uml_cleanup();
 	CHOOSE_MODE(reboot_tt(), reboot_skas());
 }
 
@@ -53,8 +53,7 @@ EXPORT_SYMBOL(machine_restart);
 
 void machine_power_off(void)
 {
-	do_uml_exitcalls();
-	kill_off_processes();
+        uml_cleanup();
 	CHOOSE_MODE(halt_tt(), halt_skas());
 }
 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
