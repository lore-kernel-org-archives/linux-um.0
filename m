Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Na0-0002De-A6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:48 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8NZz-0001dn-A9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:48 -0800
Message-Id: <200503072038.j27Kcjbc003998@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 12/16] UML - Remove useless sys_mount wrapper
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
Date: Mon, 07 Mar 2005 15:38:45 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

um_mount did nothing but turn around and call sys_mount with the same 
arguments.  This makes it useless code, and it has been duly removed.
Index: linux-2.6.11/arch/um/kernel/sys_call_table.c

Signed-off-by: Jeff Dike <jdike@addtoit.com>

===================================================================
--- linux-2.6.11.orig/arch/um/kernel/sys_call_table.c	2005-03-05 12:07:32.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/sys_call_table.c	2005-03-05 12:19:52.000000000 -0500
@@ -31,7 +31,6 @@
 extern syscall_handler_t sys_fork;
 extern syscall_handler_t sys_execve;
 extern syscall_handler_t um_time;
-extern syscall_handler_t um_mount;
 extern syscall_handler_t um_stime;
 extern syscall_handler_t sys_pipe;
 extern syscall_handler_t sys_olduname;
@@ -77,7 +76,7 @@
 	[ __NR_lchown ] = (syscall_handler_t *) sys_lchown16,
 	[ __NR_lseek ] = (syscall_handler_t *) sys_lseek,
 	[ __NR_getpid ] = (syscall_handler_t *) sys_getpid,
-	[ __NR_mount ] = um_mount,
+	[ __NR_mount ] = (syscall_handler_t *) sys_mount,
 	[ __NR_setuid ] = (syscall_handler_t *) sys_setuid16,
 	[ __NR_getuid ] = (syscall_handler_t *) sys_getuid16,
  	[ __NR_ptrace ] = (syscall_handler_t *) sys_ptrace,
Index: linux-2.6.11/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/syscall_kern.c	2005-03-05 12:18:28.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/syscall_kern.c	2005-03-05 12:19:52.000000000 -0500
@@ -27,12 +27,6 @@
 /*  Unlocked, I don't care if this is a bit off */
 int nsyscalls = 0;
 
-long um_mount(char __user * dev_name, char __user * dir_name,
-	      char __user * type, unsigned long new_flags, void __user * data)
-{
-	return(sys_mount(dev_name, dir_name, type, new_flags, data));
-}
-
 long sys_fork(void)
 {
 	long ret;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
