Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1XdITO-0002j2-Kr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Oct 2014 12:42:06 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XdITL-0000f9-30
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Oct 2014 12:42:06 +0000
Received: from [217.255.208.138] (helo=[192.168.2.106])
	by www17.your-server.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1) (envelope-from <thomas@m3y3r.de>) id 1XdITE-0007u6-6V
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Oct 2014 14:41:56 +0200
Message-ID: <1413117565.13916.6.camel@localhost.localdomain>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 12 Oct 2014 14:39:25 +0200
Mime-Version: 1.0
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH v2 1/2] um: Move uml_postsetup in the
	init_thread stack
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>


atomic_notifier_chain_register() and uml_postsetup() do call kernel code
that rely on the current macro and a valid task_struct resp. thread_info struct.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/include/shared/as-layout.h |  1 +
 arch/um/kernel/um_arch.c           | 15 ++++++++++-----
 arch/um/os-Linux/skas/process.c    |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 41c8c77..ca1843e 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -56,6 +56,7 @@ extern unsigned long brk_start;
 extern unsigned long host_task_size;
 
 extern int linux_main(int argc, char **argv);
+extern void uml_finishsetup(void);
 
 struct siginfo;
 extern void (*sig_info[])(int, struct siginfo *si, struct uml_pt_regs *);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 016adf0..ab72560 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -247,6 +247,16 @@ static struct notifier_block panic_exit_notifier = {
 	.priority 		= 0
 };
 
+void uml_finishsetup(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &panic_exit_notifier);
+
+	uml_postsetup();
+
+	new_thread_handler();
+}
+
 /* Set during early boot */
 unsigned long task_size;
 EXPORT_SYMBOL(task_size);
@@ -367,11 +377,6 @@ int __init linux_main(int argc, char **argv)
 		printf("Kernel virtual memory size shrunk to %lu bytes\n",
 		       virtmem_size);
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &panic_exit_notifier);
-
-	uml_postsetup();
-
 	stack_protections((unsigned long) &init_thread_info);
 	os_flush_stdout();
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 908579f..8666cb6 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -674,7 +674,7 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 	n = setjmp(initial_jmpbuf);
 	switch (n) {
 	case INIT_JMP_NEW_THREAD:
-		(*switch_buf)[0].JB_IP = (unsigned long) new_thread_handler;
+		(*switch_buf)[0].JB_IP = (unsigned long) uml_finishsetup;
 		(*switch_buf)[0].JB_SP = (unsigned long) stack +
 			UM_THREAD_SIZE - sizeof(void *);
 		break;




------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://p.sf.net/sfu/Zoho
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

