Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw4Ba-0006ta-AM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:30 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fw4BZ-0004YP-Fi
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:30 -0700
Message-Id: <200606292136.k5TLaY7N010817@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 29 Jun 2006 17:36:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/9] UML - Remove unneeded time definitions
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
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Remove um_time() and um_stime() syscalls since they are identical to
system-wide ones.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Index: linux-2.6.17/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/time_kern.c	2006-06-29 11:45:07.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/time_kern.c	2006-06-29 11:45:07.000000000 -0400
@@ -142,16 +142,6 @@ irqreturn_t um_timer(int irq, void *dev,
 	return IRQ_HANDLED;
 }
 
-long um_time(int __user *tloc)
-{
-	long ret = get_time() / NSEC_PER_SEC;
-
-	if((tloc != NULL) && put_user(ret, tloc))
-		return -EFAULT;
-
-	return ret;
-}
-
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long long nsecs = get_time();
@@ -180,18 +170,6 @@ static inline void set_time(unsigned lon
 	clock_was_set();
 }
 
-long um_stime(int __user *tptr)
-{
-	int value;
-
-	if (get_user(value, tptr))
-                return -EFAULT;
-
-	set_time((unsigned long long) value * NSEC_PER_SEC);
-
-	return 0;
-}
-
 int do_settimeofday(struct timespec *tv)
 {
 	set_time((unsigned long long) tv->tv_sec * NSEC_PER_SEC + tv->tv_nsec);
Index: linux-2.6.17/arch/um/sys-i386/sys_call_table.S
===================================================================
--- linux-2.6.17.orig/arch/um/sys-i386/sys_call_table.S	2006-06-29 11:39:24.000000000 -0400
+++ linux-2.6.17/arch/um/sys-i386/sys_call_table.S	2006-06-29 11:45:07.000000000 -0400
@@ -7,8 +7,6 @@
 #define sys_vm86old sys_ni_syscall
 #define sys_vm86 sys_ni_syscall
 
-#define sys_stime um_stime
-#define sys_time um_time
 #define old_mmap old_mmap_i386
 
 #include "../../i386/kernel/syscall_table.S"
Index: linux-2.6.17/arch/um/sys-x86_64/syscall_table.c
===================================================================
--- linux-2.6.17.orig/arch/um/sys-x86_64/syscall_table.c	2006-06-29 11:39:24.000000000 -0400
+++ linux-2.6.17/arch/um/sys-x86_64/syscall_table.c	2006-06-29 11:45:07.000000000 -0400
@@ -20,12 +20,6 @@
 /*#define sys_set_thread_area sys_ni_syscall
 #define sys_get_thread_area sys_ni_syscall*/
 
-/* For __NR_time. The x86-64 name hopefully will change from sys_time64 to
- * sys_time (since the current situation is bogus). I've sent a patch to cleanup
- * this. Remove below the obsoleted line. */
-#define sys_time64 um_time
-#define sys_time um_time
-
 /* On UML we call it this way ("old" means it's not mmap2) */
 #define sys_mmap old_mmap
 /* On x86-64 sys_uname is actually sys_newuname plus a compatibility trick.


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
