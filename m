Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUC1j-0001KB-Jo	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 16:14:35 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DUC1i-00088L-TI	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 16:14:35 -0700
Message-Id: <200505062249.j46Mn112010445@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/12] UML - command line handling cleanup
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
Date: Fri, 06 May 2005 18:49:01 -0400
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Command line handling cleanups - a couple of things made static and an 
unused declaration removed from header.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm/arch/um/include/user_util.h
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/include/user_util.h	2005-05-02 14:47:52.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/include/user_util.h	2005-05-06 14:35:06.000000000 -0400
@@ -67,7 +67,6 @@
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
 extern void setup_machinename(char *machine_out);
 extern void setup_hostinfo(void);
-extern void add_arg(char *arg);
 extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
 extern void init_new_thread_signals(int altstack);
 extern void do_exec(int old_pid, int new_pid);
Index: linux-2.6.12-rc3-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/um_arch.c	2005-05-02 14:47:52.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/um_arch.c	2005-05-06 14:37:21.000000000 -0400
@@ -23,6 +23,7 @@
 #include "asm/ptrace.h"
 #include "asm/elf.h"
 #include "asm/user.h"
+#include "asm/setup.h"
 #include "ubd_user.h"
 #include "asm/current.h"
 #include "asm/setup.h"
@@ -42,9 +43,9 @@
 #define DEFAULT_COMMAND_LINE "root=98:0"
 
 /* Changed in linux_main and setup_arch, which run before SMP is started */
-char command_line[COMMAND_LINE_SIZE] = { 0 };
+static char command_line[COMMAND_LINE_SIZE] = { 0 };
 
-void add_arg(char *arg)
+static void add_arg(char *arg)
 {
 	if (strlen(command_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
 		printf("add_arg: Too many command line arguments!\n");
@@ -449,7 +450,7 @@
 {
 	notifier_chain_register(&panic_notifier_list, &panic_exit_notifier);
 	paging_init();
- 	strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+        strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
 }
Index: linux-2.6.12-rc3-mm/include/asm-um/setup.h
===================================================================
--- linux-2.6.12-rc3-mm.orig/include/asm-um/setup.h	2005-05-02 14:47:52.000000000 -0400
+++ linux-2.6.12-rc3-mm/include/asm-um/setup.h	2005-05-05 12:32:59.000000000 -0400
@@ -2,7 +2,8 @@
 #define SETUP_H_INCLUDED
 
 /* POSIX mandated with _POSIX_ARG_MAX that we can rely on 4096 chars in the
- * command line, so this choice is ok.*/
+ * command line, so this choice is ok.
+ */
 
 #define COMMAND_LINE_SIZE 4096
 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
