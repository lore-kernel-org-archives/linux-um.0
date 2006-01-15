Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyEml-0005UE-86 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:35 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EyEmk-00052R-Re
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:35 -0800
Message-Id: <200601152139.k0FLdedi027721@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/11] UML - Change interface to boot_timer_handler
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
Date: Sun, 15 Jan 2006 16:39:40 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Current implementation of boot_timer_handler isn't usable
for s390. So I changed its name to do_boot_timer_handler,
taking (struct sigcontext *)sc as argument.
do_boot_timer_handler is called from new boot_timer_handler()
in arch/um/os-Linux/signal.c, which uses the same mechanisms
as other signal handler to find out sigcontext pointer.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/time_kern.c	2006-01-06 21:24:14.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/time_kern.c	2006-01-06 21:35:21.000000000 -0500
@@ -84,12 +84,11 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 }
 
-void boot_timer_handler(int sig)
+void do_boot_timer_handler(struct sigcontext * sc)
 {
 	struct pt_regs regs;
 
-	CHOOSE_MODE((void)
-		    (UPT_SC(&regs.regs) = (struct sigcontext *) (&sig + 1)),
+	CHOOSE_MODE((void) (UPT_SC(&regs.regs) = sc),
 		    (void) (regs.regs.skas.is_user = 0));
 	do_timer(&regs);
 }
Index: linux-2.6.15-mm/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/signal.c	2006-01-06 21:24:14.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/signal.c	2006-01-06 21:35:21.000000000 -0500
@@ -12,7 +12,6 @@
 #include <string.h>
 #include <sys/mman.h>
 #include "user_util.h"
-#include "kern_util.h"
 #include "user.h"
 #include "signal_kern.h"
 #include "sysdep/sigcontext.h"
@@ -49,6 +48,17 @@ void alarm_handler(ARCH_SIGHDLR_PARAM)
 		switch_timers(1);
 }
 
+extern void do_boot_timer_handler(struct sigcontext * sc);
+
+void boot_timer_handler(ARCH_SIGHDLR_PARAM)
+{
+	struct sigcontext *sc;
+
+	ARCH_GET_SIGCONTEXT(sc, sig);
+
+	do_boot_timer_handler(sc);
+}
+
 void set_sigstack(void *sig_stack, int size)
 {
 	stack_t stack = ((stack_t) { .ss_flags	= 0,



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
