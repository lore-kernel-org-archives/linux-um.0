Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJy9E-0007OF-2H for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 12:33:08 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJy9D-0003Zf-HQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 12:33:08 -0800
Message-Id: <200702212025.l1LKPKeG006784@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 21 Feb 2007 15:25:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/4] UML - host_info tidying
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Move the host_info string from util.c to um_arch.c, where it is
actually initialized and used.  Also document its lack of locking.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/include/os.h        |    2 +-
 arch/um/include/user_util.h |    2 --
 arch/um/kernel/um_arch.c    |    6 +++++-
 arch/um/os-Linux/util.c     |    8 +++-----
 4 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6.17/arch/um/include/os.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/os.h	2007-02-19 11:39:11.000000000 -0500
+++ linux-2.6.17/arch/um/include/os.h	2007-02-19 12:55:11.000000000 -0500
@@ -273,7 +273,7 @@ extern void stack_protections(unsigned l
 extern void task_protections(unsigned long address);
 extern int raw(int fd);
 extern void setup_machinename(char *machine_out);
-extern void setup_hostinfo(void);
+extern void setup_hostinfo(char *buf, int len);
 extern int setjmp_wrapper(void (*proc)(void *, void *), ...);
 
 /* time.c */
Index: linux-2.6.17/arch/um/include/user_util.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/user_util.h	2007-02-19 12:52:22.000000000 -0500
+++ linux-2.6.17/arch/um/include/user_util.h	2007-02-19 12:55:36.000000000 -0500
@@ -36,8 +36,6 @@ extern unsigned long end_vm;
 extern unsigned long start_vm;
 extern unsigned long long highmem;
 
-extern char host_info[];
-
 extern char saved_command_line[];
 
 extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
Index: linux-2.6.17/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/um_arch.c	2007-02-19 12:53:54.000000000 -0500
+++ linux-2.6.17/arch/um/kernel/um_arch.c	2007-02-19 12:55:11.000000000 -0500
@@ -17,6 +17,7 @@
 #include "linux/seq_file.h"
 #include "linux/delay.h"
 #include "linux/module.h"
+#include "linux/utsname.h"
 #include "asm/page.h"
 #include "asm/pgtable.h"
 #include "asm/ptrace.h"
@@ -68,6 +69,9 @@ unsigned long thread_saved_pc(struct tas
 					      task));
 }
 
+/* Changed in setup_arch, which is called in early boot */
+static char host_info[(__NEW_UTS_LEN + 1) * 5];
+
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	int index = 0;
@@ -483,7 +487,7 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
         strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
-	setup_hostinfo();
+	setup_hostinfo(host_info, sizeof host_info);
 }
 
 void __init check_bugs(void)
Index: linux-2.6.17/arch/um/os-Linux/util.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/util.c	2007-02-19 11:39:09.000000000 -0500
+++ linux-2.6.17/arch/um/os-Linux/util.c	2007-02-19 12:55:11.000000000 -0500
@@ -96,15 +96,13 @@ void setup_machinename(char *machine_out
 	strcpy(machine_out, host.machine);
 }
 
-char host_info[(_UTSNAME_LENGTH + 1) * 4 + _UTSNAME_NODENAME_LENGTH + 1];
-
-void setup_hostinfo(void)
+void setup_hostinfo(char *buf, int len)
 {
 	struct utsname host;
 
 	uname(&host);
-	sprintf(host_info, "%s %s %s %s %s", host.sysname, host.nodename,
-		host.release, host.version, host.machine);
+	snprintf(buf, len, "%s %s %s %s %s", host.sysname, host.nodename,
+		 host.release, host.version, host.machine);
 }
 
 int setjmp_wrapper(void (*proc)(void *, void *), ...)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
