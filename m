Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <menage@google.com>) id 1MGN1X-00060i-Tw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 00:59:39 +0000
Received: from smtp-out.google.com ([216.239.33.17])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGN1V-0007G0-D4
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 00:59:39 +0000
From: Paul Menage <menage@google.com>
Date: Mon, 15 Jun 2009 17:17:45 -0700
Message-ID: <20090616001744.30398.85320.stgit@menage.mtv.corp.google.com>
In-Reply-To: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
References: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 4/5] UML: Avoid lockdep issues during
	initialization
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
To: peterz@infradead.org, mingo@redhat.com, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

UML: Avoid lockdep issues during initialization

UML calls atomic_notifier_chain_register() very early during
initialization. When lockdep is in use, the spinlock operations thus
invoked make use of current_thread_info(), which isn't valid in UML
until start_kernel_proc() is reached (running on the init_thread_union
stack rather than the default stack at the top of the address space).

This patch moves the call to the beginning of start_kernel_proc(), and
additionally disables lock debugging for the duration of the call,
since lockdep_init() doesn't occur until start_kernel() is called.

Signed-off-by: Paul Menage <menage@google.com>

---

 arch/um/kernel/skas/process.c |   26 ++++++++++++++++++++++++++
 arch/um/kernel/um_arch.c      |   20 --------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 4a21c5c..2b62a72 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -5,7 +5,9 @@
 
 #include "linux/init.h"
 #include "linux/sched.h"
+#include "linux/debug_locks.h"
 #include "as-layout.h"
+#include "shared/kern_util.h"
 #include "kern.h"
 #include "os.h"
 #include "skas.h"
@@ -31,10 +33,34 @@ int new_mm(unsigned long stack)
 
 extern void start_kernel(void);
 
+static int panic_exit(struct notifier_block *self, unsigned long unused1,
+		      void *unused2)
+{
+	bust_spinlocks(1);
+	show_regs(&(current->thread.regs));
+	bust_spinlocks(0);
+	uml_exitcode = 1;
+	os_dump_core();
+	return 0;
+}
+
+static struct notifier_block panic_exit_notifier = {
+	.notifier_call 		= panic_exit,
+	.next 			= NULL,
+	.priority 		= 0
+};
+
 static int __init start_kernel_proc(void *unused)
 {
 	int pid;
 
+	/* lockdep hasn't yet been initialized, but this call takes
+	 * spinlocks. Temporarily disable lock debugging */
+	int saved_debug_locks = debug_locks;
+	debug_locks = 0;
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &panic_exit_notifier);
+	debug_locks = saved_debug_locks;
 	local_irq_disable();
 	pid = os_getpid();
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8d84250..364c589 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -223,23 +223,6 @@ static void __init uml_postsetup(void)
 	return;
 }
 
-static int panic_exit(struct notifier_block *self, unsigned long unused1,
-		      void *unused2)
-{
-	bust_spinlocks(1);
-	show_regs(&(current->thread.regs));
-	bust_spinlocks(0);
-	uml_exitcode = 1;
-	os_dump_core();
-	return 0;
-}
-
-static struct notifier_block panic_exit_notifier = {
-	.notifier_call 		= panic_exit,
-	.next 			= NULL,
-	.priority 		= 0
-};
-
 /* Set during early boot */
 unsigned long task_size;
 EXPORT_SYMBOL(task_size);
@@ -360,9 +343,6 @@ int __init linux_main(int argc, char **argv)
 		printf("Kernel virtual memory size shrunk to %lu bytes\n",
 		       virtmem_size);
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &panic_exit_notifier);
-
 	uml_postsetup();
 
 	stack_protections((unsigned long) &init_thread_info);


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

