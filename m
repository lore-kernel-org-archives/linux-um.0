Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWqZ-0004gA-4F for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:31 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWqS-0004Fd-7Y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:30 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231721.59164363A6@zion.localdomain>
Subject: [uml-devel] [patch 03/20] uml: fix syscall auditing
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
Date: Thu, 04 Nov 2004 00:17:21 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


Correct the entry_exit parameter for syscall_trace when tracing syscalls. It
was the reverse of the needed value. (i.e.  it was 1 on entry and 0 on exit).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/syscall_user.c |    4 ++--
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/syscall_user.c   |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/skas/syscall_user.c~uml-fix-syscall-auditing arch/um/kernel/skas/syscall_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/skas/syscall_user.c~uml-fix-syscall-auditing	2004-11-03 23:44:57.311847392 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/syscall_user.c	2004-11-03 23:44:57.315846784 +0100
@@ -22,7 +22,7 @@ void handle_syscall(union uml_pt_regs *r
 
 	index = record_syscall_start(UPT_SYSCALL_NR(regs));
 
-	syscall_trace(regs, 1);
+	syscall_trace(regs, 0);
 	result = execute_syscall(regs);
 
 	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
@@ -30,7 +30,7 @@ void handle_syscall(union uml_pt_regs *r
 	   (result == -ERESTARTNOINTR))
 		do_signal(result);
 
-	syscall_trace(regs, 0);
+	syscall_trace(regs, 1);
 	record_syscall_end(index, result);
 }
 
diff -puN arch/um/kernel/tt/syscall_user.c~uml-fix-syscall-auditing arch/um/kernel/tt/syscall_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/tt/syscall_user.c~uml-fix-syscall-auditing	2004-11-03 23:44:57.313847088 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/syscall_user.c	2004-11-03 23:44:57.316846632 +0100
@@ -33,7 +33,7 @@ void syscall_handler_tt(int sig, union u
 	SC_START_SYSCALL(sc);
 
 	index = record_syscall_start(syscall);
-	syscall_trace(regs, 1);
+	syscall_trace(regs, 0);
 	result = execute_syscall(regs);
 
 	/* regs->sc may have changed while the system call ran (there may
@@ -46,7 +46,7 @@ void syscall_handler_tt(int sig, union u
 	   (result == -ERESTARTNOINTR))
 		do_signal(result);
 
-	syscall_trace(regs, 0);
+	syscall_trace(regs, 1);
 	record_syscall_end(index, result);
 }
 
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
