Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HZFzU-0004LT-6s for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Apr 2007 17:38:16 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HZFzT-00039q-Du
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Apr 2007 17:38:16 -0700
Date: Wed, 4 Apr 2007 20:34:03 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070405003403.GA13280@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 3/4] UML - Comment early boot locking
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Commentary about missing locking.

Also got rid of uml_start because it was pointless.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/um_arch.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/um_arch.c	2007-04-02 13:04:27.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/um_arch.c	2007-04-02 15:10:06.000000000 -0400
@@ -44,7 +44,7 @@
 
 #define DEFAULT_COMMAND_LINE "root=98:0"
 
-/* Changed in linux_main and setup_arch, which run before SMP is started */
+/* Changed in add_arg and setup_arch, which run before SMP is started */
 static char __initdata command_line[COMMAND_LINE_SIZE] = { 0 };
 
 static void __init add_arg(char *arg)
@@ -58,7 +58,12 @@ static void __init add_arg(char *arg)
 	strcat(command_line, arg);
 }
 
-struct cpuinfo_um boot_cpu_data = { 
+/*
+ * These fields are initialized at boot time and not changed.
+ * XXX This structure is used only in the non-SMP case.  Maybe this
+ * should be moved to smp.c.
+ */
+struct cpuinfo_um boot_cpu_data = {
 	.loops_per_jiffy	= 0,
 	.ipi_pipe		= { -1, -1 }
 };
@@ -119,14 +124,12 @@ const struct seq_operations cpuinfo_op =
 /* Set in linux_main */
 unsigned long host_task_size;
 unsigned long task_size;
-
-unsigned long uml_start;
-
-/* Set in early boot */
 unsigned long uml_physmem;
-unsigned long uml_reserved;
+unsigned long uml_reserved; /* Also modified in mem_init */
 unsigned long start_vm;
 unsigned long end_vm;
+
+/* Set in uml_ncpus_setup */
 int ncpus = 1;
 
 #ifdef CONFIG_CMDLINE_ON_HOST
@@ -140,6 +143,8 @@ static char *argv1_end = NULL;
 
 /* Set in early boot */
 static int have_root __initdata = 0;
+
+/* Set in uml_mem_setup and modified in linux_main */
 long long physmem_size = 32 * 1024 * 1024;
 
 void set_cmdline(char *cmd)
@@ -378,7 +383,6 @@ int __init linux_main(int argc, char **a
 
 	printf("UML running in %s mode\n", mode);
 
-	uml_start = (unsigned long) &__binary_start;
 	host_task_size = CHOOSE_MODE_PROC(set_task_sizes_tt,
 					  set_task_sizes_skas, &task_size);
 
@@ -400,7 +404,7 @@ int __init linux_main(int argc, char **a
 		physmem_size += UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
 	}
 
-	uml_physmem = uml_start & PAGE_MASK;
+	uml_physmem = (unsigned long) &__binary_start & PAGE_MASK;
 
 	/* Reserve up to 4M after the current brk */
 	uml_reserved = ROUND_4M(brk_start) + (1 << 22);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
