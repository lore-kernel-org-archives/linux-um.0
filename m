Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnRCb-0002fr-6G for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 19:21:53 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FmiAB-0000rR-LG for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jun 2006 19:16:23 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fmi9n-0005Jg-Ov
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jun 2006 19:16:00 -0700
Message-Id: <200606040216.k542GDFU004832@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Sat, 03 Jun 2006 22:16:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/6] UML - Fix wall_to_monotonic initialization
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
Cc: Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, "Christopher S. Aker" <caker@theshore.net>

Initialize wall_to_monotonic correctly.  This fixes a problem where sleeps
lasted about one secone less than they should.
This also called for a bit of code restructuring, following a patch which
Blaisorblade had been keeping.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/os-Linux/time.c	2006-06-01 22:16:24.000000000 -0400
+++ linux-2.6.17-mm/arch/um/os-Linux/time.c	2006-06-02 17:47:11.000000000 -0400
@@ -81,20 +81,12 @@ void uml_idle_timer(void)
 	set_interval(ITIMER_REAL);
 }
 
-extern void ktime_get_ts(struct timespec *ts);
-#define do_posix_clock_monotonic_gettime(ts) ktime_get_ts(ts)
-
 void time_init(void)
 {
-	struct timespec now;
-
 	if(signal(SIGVTALRM, boot_timer_handler) == SIG_ERR)
 		panic("Couldn't set SIGVTALRM handler");
 	set_interval(ITIMER_VIRTUAL);
-
-	do_posix_clock_monotonic_gettime(&now);
-	wall_to_monotonic.tv_sec = -now.tv_sec;
-	wall_to_monotonic.tv_nsec = -now.tv_nsec;
+	time_init_kern();
 }
 
 unsigned long long os_nsecs(void)
Index: linux-2.6.17-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.17-mm.orig/arch/um/include/kern_util.h	2006-06-02 17:00:00.000000000 -0400
+++ linux-2.6.17-mm/arch/um/include/kern_util.h	2006-06-02 17:46:49.000000000 -0400
@@ -120,20 +120,11 @@ extern int is_syscall(unsigned long addr
 extern void free_irq(unsigned int, void *);
 extern int cpu(void);
 
+extern void time_init_kern(void);
+
 /* Are we disallowed to sleep? Used to choose between GFP_KERNEL and GFP_ATOMIC. */
 extern int __cant_sleep(void);
 extern void segv_handler(int sig, union uml_pt_regs *regs);
 extern void sigio_handler(int sig, union uml_pt_regs *regs);
 
 #endif
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
Index: linux-2.6.17-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/kernel/time_kern.c	2006-06-02 16:34:55.000000000 -0400
+++ linux-2.6.17-mm/arch/um/kernel/time_kern.c	2006-06-02 17:46:49.000000000 -0400
@@ -84,6 +84,16 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 }
 
+
+void time_init_kern(void)
+{
+	unsigned long long nsecs;
+
+	nsecs = os_nsecs();
+	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,
+				-nsecs % BILLION);
+}
+
 void do_boot_timer_handler(struct sigcontext * sc)
 {
 	struct pt_regs regs;



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
