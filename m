Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1szw-0006jN-Em for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 13:43:28 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C1szv-0003sk-MU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 13:43:28 -0700
Received: from zion.localdomain (62.11.74.135) by mail-relay-4.tiscali.it
	(7.1.021.3)
	id 40F3EBEA00A49FAB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 22:43:27 +0200
From: blaisorblade_spam@yahoo.it
Message-Id: <20040830203554.6657EBD5A@zion.localdomain>
Subject: [uml-devel] [patch 4/4] uml-more-EINTR-safety
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
Date: Mon, 30 Aug 2004 22:35:54 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade_spam@yahoo.it


Add some more EINTR safety with some more uses of CATCH_EINTR.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/helper.c       |    4 ++--
 uml-linux-2.6.8.1-paolo/arch/um/kernel/process.c      |    3 ++-
 uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process.c |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/skas/process.c~uml-more-EINTR-safety arch/um/kernel/skas/process.c
--- uml-linux-2.6.8.1/arch/um/kernel/skas/process.c~uml-more-EINTR-safety	2004-08-29 14:40:48.558829712 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process.c	2004-08-29 14:40:48.563828952 +0200
@@ -81,7 +81,7 @@ static void handle_trap(int pid, union u
 			panic("handle_trap - continuing to end of syscall failed, "
 			      "errno = %d\n", errno);
 
-		err = waitpid(pid, &status, WUNTRACED);
+		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
 			panic("handle_trap - failed to wait at end of syscall, "
 			      "errno = %d, status = %d\n", errno, status);
diff -puN arch/um/kernel/process.c~uml-more-EINTR-safety arch/um/kernel/process.c
--- uml-linux-2.6.8.1/arch/um/kernel/process.c~uml-more-EINTR-safety	2004-08-29 14:40:48.560829408 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/process.c	2004-08-29 14:40:48.563828952 +0200
@@ -216,7 +216,8 @@ static void __init check_sysemu(void)
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
 		struct user_regs_struct regs;
 
-		if (waitpid(pid, &status, WUNTRACED) < 0)
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		if (n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
 		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
 			panic("check_ptrace : expected SIGTRAP, "
diff -puN arch/um/kernel/helper.c~uml-more-EINTR-safety arch/um/kernel/helper.c
--- uml-linux-2.6.8.1/arch/um/kernel/helper.c~uml-more-EINTR-safety	2004-08-29 14:40:48.561829256 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/helper.c	2004-08-29 14:40:48.564828800 +0200
@@ -128,7 +128,7 @@ int run_helper_thread(int (*proc)(void *
 		return(-errno);
 	}
 	if(stack_out == NULL){
-		pid = waitpid(pid, &status, 0);
+		CATCH_EINTR(pid = waitpid(pid, &status, 0));
 		if(pid < 0){
 			printk("run_helper_thread - wait failed, errno = %d\n",
 			       errno);
@@ -147,7 +147,7 @@ int helper_wait(int pid, int block)
 {
 	int ret;
 
-	ret = waitpid(pid, NULL, WNOHANG);
+	CATCH_EINTR(ret = waitpid(pid, NULL, WNOHANG));
 	if(ret < 0){
 		printk("helper_wait : waitpid failed, errno = %d\n", errno);
 		return(-errno);
_


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
