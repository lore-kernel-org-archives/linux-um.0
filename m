Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWqy-0004jU-JS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:56 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWqw-0000MY-M8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:56 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231747.7CCC855C83@zion.localdomain>
Subject: [uml-devel] [patch 14/20] uml: fix sysemu test at startup
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
Date: Thu, 04 Nov 2004 00:17:47 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it, bodo.stroesser@fujitsu-siemens.com


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

Currently, the test for the SYSEMU support on the host is completely wrong, as
Bodo noticed. We should change the syscall result (inserting the host pid) and
check if it is received correctly by the guest. What we actually do, without
this patch, is to overwrite the syscall number.

This went unnoticed because we only check that the getpid() syscall from the
child does not return its pid. We don't check that it returns the correct
value.

Also, override the result portably, using the PT_SYSCALL_RET_OFFSET macro
which abstract away the host stack frame layout (took from Jeff Dike code).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff -puN arch/um/kernel/process.c~uml-fix-sysemu-test-startup arch/um/kernel/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/process.c~uml-fix-sysemu-test-startup	2004-11-03 23:45:15.751044208 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c	2004-11-03 23:45:15.754043752 +0100
@@ -214,8 +214,6 @@ static void __init check_sysemu(void)
 	sysemu_supported = 0;
 	pid = start_ptraced_child(&stack);
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
-		struct user_regs_struct regs;
-
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if (n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
@@ -223,18 +221,16 @@ static void __init check_sysemu(void)
 			panic("check_ptrace : expected SIGTRAP, "
 			      "got status = %d", status);
 
-		if (ptrace(PTRACE_GETREGS, pid, 0, &regs) < 0)
-			panic("check_ptrace : failed to read child "
-			      "registers, errno = %d", errno);
-		regs.orig_eax = pid;
-		if (ptrace(PTRACE_SETREGS, pid, 0, &regs) < 0)
-			panic("check_ptrace : failed to modify child "
-			      "registers, errno = %d", errno);
+		n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
+			   os_getpid());
+		if(n < 0)
+			panic("check_ptrace : failed to modify system "
+			      "call return, errno = %d", errno);
 
 		stop_ptraced_child(pid, stack, 0);
 
 		sysemu_supported = 1;
-		printk("found\n");
+		printk("OK\n");
 	}
 	else
 	{
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
