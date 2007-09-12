Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVZZo-00024X-Vj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:49 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVZZo-0000YQ-DL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:48 -0700
Date: Wed, 12 Sep 2007 17:16:45 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070912211645.GA10242@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/11] UML - tidy set_interval
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

set_interval took a timer type as an argument, but it always specified
a virtual timer.  So, it is not needed, and it is gone, and
set_interval is simplified appropriately.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/os.h            |    2 +-
 arch/um/kernel/time.c           |    2 +-
 arch/um/os-Linux/skas/process.c |    2 +-
 arch/um/os-Linux/time.c         |    5 ++---
 4 files changed, 5 insertions(+), 6 deletions(-)

Index: linux-2.6.22/arch/um/include/os.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/os.h	2007-08-30 16:30:49.000000000 -0400
+++ linux-2.6.22/arch/um/include/os.h	2007-08-30 16:31:15.000000000 -0400
@@ -252,7 +252,7 @@ extern void os_dump_core(void);
 
 extern int switch_timers(int to_real);
 extern void idle_sleep(int secs);
-extern int set_interval(int is_virtual);
+extern int set_interval(void);
 extern void disable_timer(void);
 extern void uml_idle_timer(void);
 extern unsigned long long os_nsecs(void);
Index: linux-2.6.22/arch/um/kernel/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/time.c	2007-08-30 16:30:13.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/time.c	2007-08-30 16:31:15.000000000 -0400
@@ -102,7 +102,7 @@ static void register_timer(void)
 		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
 
-	err = set_interval(1);
+	err = set_interval();
 	if (err != 0)
 		printk(KERN_ERR "register_timer : set_interval failed - "
 		       "errno = %d\n", -err);
Index: linux-2.6.22/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/process.c	2007-08-30 16:30:13.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/skas/process.c	2007-08-30 16:31:15.000000000 -0400
@@ -178,7 +178,7 @@ static int userspace_tramp(void *stack)
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
 	init_new_thread_signals();
-	err = set_interval(1);
+	err = set_interval();
 	if (err)
 		panic("userspace_tramp - setting timer failed, errno = %d\n",
 		      err);
Index: linux-2.6.22/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/time.c	2007-08-30 16:30:49.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/time.c	2007-08-30 16:31:15.000000000 -0400
@@ -14,14 +14,13 @@
 
 static int is_real_timer = 0;
 
-int set_interval(int is_virtual)
+int set_interval(void)
 {
 	int usec = 1000000/UM_HZ;
-	int timer_type = is_virtual ? ITIMER_VIRTUAL : ITIMER_REAL;
 	struct itimerval interval = ((struct itimerval) { { 0, usec },
 							  { 0, usec } });
 
-	if (setitimer(timer_type, &interval, NULL) == -1)
+	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
 		return -errno;
 
 	return 0;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
