Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I3nms-000175-FP for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jun 2007 23:47:30 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I3ncz-000824-Ce
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jun 2007 23:37:19 -0700
Date: Wed, 27 Jun 2007 23:37:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070627233701.8e53f3cb.akpm@linux-foundation.org>
In-Reply-To: <20070614202655.GA9647@c2.user-mode-linux.org>
References: <20070614202655.GA9647@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 4/5] UML - Simplify helper stack handling
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>


So I'm running the generic version of this on i386 with 8k stacks (below),
with a quick LTP run.

Holy cow, either we use a _lot_ of stack or these numbers are off:

vmm:/home/akpm> dmesg -s 1000000|grep 'bytes left' 
khelper used greatest stack depth: 7176 bytes left
khelper used greatest stack depth: 7064 bytes left
khelper used greatest stack depth: 6840 bytes left
khelper used greatest stack depth: 6812 bytes left
hostname used greatest stack depth: 6636 bytes left
uname used greatest stack depth: 6592 bytes left
uname used greatest stack depth: 6284 bytes left
hotplug used greatest stack depth: 5568 bytes left
rpc.nfsd used greatest stack depth: 5136 bytes left
chown02 used greatest stack depth: 4956 bytes left
fchown01 used greatest stack depth: 4892 bytes left

That's the sum of process stack and interrupt stack, but I doubt if this
little box is using much interrupt stack space.

No wonder people are still getting stack overflows with 4k stacks...





From: Jeff Dike <jdike@addtoit.com>

Add generic exit-time stack-depth checking to CONFIG_DEBUG_STACK_USAGE.

This also adds UML support.

Tested on UML and i386.

[akpm@linux-foundation.org: cleanups, speedups, tweaks]
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/um/Kconfig.debug        |    9 +++++++++
 arch/um/defconfig            |    1 +
 include/asm-um/thread_info.h |    9 +++++++++
 kernel/exit.c                |   29 +++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff -puN arch/um/Kconfig.debug~add-generic-exit-time-stack-depth-checking-to-config_debug_stack_usage arch/um/Kconfig.debug
--- a/arch/um/Kconfig.debug~add-generic-exit-time-stack-depth-checking-to-config_debug_stack_usage
+++ a/arch/um/Kconfig.debug
@@ -47,4 +47,13 @@ config GCOV
         If you're involved in UML kernel development and want to use gcov,
         say Y.  If you're unsure, say N.
 
+config DEBUG_STACK_USAGE
+	bool "Stack utilization instrumentation"
+	default N
+	help
+	  Track the maximum kernel stack usage - this will look at each
+	  kernel stack at process exit and log it if it's the deepest
+	  stack seen so far.
+
+	  This option will slow down process creation and destruction somewhat.
 endmenu
diff -puN arch/um/defconfig~add-generic-exit-time-stack-depth-checking-to-config_debug_stack_usage arch/um/defconfig
--- a/arch/um/defconfig~add-generic-exit-time-stack-depth-checking-to-config_debug_stack_usage
+++ a/arch/um/defconfig
@@ -527,3 +527,4 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_GPROF is not set
 # CONFIG_GCOV is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
diff -puN include/asm-um/thread_info.h~add-generic-exit-time-stack-depth-checking-to-config_debug_stack_usage include/asm-um/thread_info.h
--- a/include/asm-um/thread_info.h~add-generic-exit-time-stack-depth-checking-to-config_debug_stack_usage
+++ a/include/asm-um/thread_info.h
@@ -52,10 +52,19 @@ static inline struct thread_info *curren
 	return ti;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+
+#define alloc_thread_info(tsk) \
+	((struct thread_info *) __get_free_pages(GFP_KERNEL | __GFP_ZERO, \
+						 CONFIG_KERNEL_STACK_ORDER))
+#else
+
 /* thread information allocation */
 #define alloc_thread_info(tsk) \
 	((struct thread_info *) __get_free_pages(GFP_KERNEL, \
 						 CONFIG_KERNEL_STACK_ORDER))
+#endif
+
 #define free_thread_info(ti) \
 	free_pages((unsigned long)(ti),CONFIG_KERNEL_STACK_ORDER)
 
diff -puN kernel/exit.c~add-generic-exit-time-stack-depth-checking-to-config_debug_stack_usage kernel/exit.c
--- a/kernel/exit.c~add-generic-exit-time-stack-depth-checking-to-config_debug_stack_usage
+++ a/kernel/exit.c
@@ -868,6 +868,34 @@ static void exit_notify(struct task_stru
 		release_task(tsk);
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static void check_stack_usage(void)
+{
+	static DEFINE_SPINLOCK(low_water_lock);
+	static int lowest_to_date = THREAD_SIZE;
+	unsigned long *n = end_of_stack(current);
+	unsigned long free;
+
+	while (*n == 0)
+		n++;
+	free = (unsigned long)n - (unsigned long)end_of_stack(current);
+
+	if (free >= lowest_to_date)
+		return;
+
+	spin_lock(&low_water_lock);
+	if (free < lowest_to_date) {
+		printk(KERN_WARNING "%s used greatest stack depth: %lu bytes "
+				"left\n",
+				current->comm, free);
+		lowest_to_date = free;
+	}
+	spin_unlock(&low_water_lock);
+}
+#else
+static inline void check_stack_usage(void) {}
+#endif
+
 fastcall NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -959,6 +987,7 @@ fastcall NORET_TYPE void do_exit(long co
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
+	check_stack_usage();
 	exit_thread();
 	cpuset_exit(tsk);
 	exit_keys(tsk);
_


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
