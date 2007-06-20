Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I14q4-0003rX-GC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2007 11:23:33 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I14q2-0004jK-PU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2007 11:23:32 -0700
Date: Wed, 20 Jun 2007 14:23:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070620182312.GA7856@c2.user-mode-linux.org>
References: <20070619184245.GA10567@c2.user-mode-linux.org>
	<20070619115422.de61abd5.akpm@linux-foundation.org>
	<20070619195003.GA11718@c2.user-mode-linux.org>
	<20070619131441.01b5ae4b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070619131441.01b5ae4b.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH 2/2] UML - Add stack usage monitoring
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Jun 19, 2007 at 01:14:41PM -0700, Andrew Morton wrote:
> Oh well.  Your new code should really be generic, utilising the
> stack-page-zeroing which CONFIG_DEBUG_STACK_USAGE enables.  There's nothing
> UML-specific about it.
> 
> low_water_lock and lowest_to_date should be static to check_stack_usage(),
> btw..

OK, here's a fixed version.  Dunno if the prink wants to be more elaborate.

If this is OK, then drop the UML version.

				Jeff

-- 
Work email - jdike at linux dot intel dot com



Add generic exit-time stack-depth checking to CONFIG_DEBUG_STACK_USAGE.

This also adds UML support.

Tested on UML and i386.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/Kconfig.debug        |    9 +++++++++
 arch/um/defconfig            |    1 +
 include/asm-um/thread_info.h |    9 +++++++++
 kernel/exit.c                |   24 ++++++++++++++++++++++++
 4 files changed, 43 insertions(+)

Index: linux-2.6.21-mm/kernel/exit.c
===================================================================
--- linux-2.6.21-mm.orig/kernel/exit.c	2007-06-20 11:57:07.000000000 -0400
+++ linux-2.6.21-mm/kernel/exit.c	2007-06-20 13:53:20.000000000 -0400
@@ -867,6 +867,27 @@ static void exit_notify(struct task_stru
 		release_task(tsk);
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static void check_stack_usage(void)
+{
+	static DEFINE_SPINLOCK(low_water_lock);
+	static int lowest_to_date = THREAD_SIZE;
+	unsigned long *n = end_of_stack(current), free;
+
+	while (*n == 0)
+		n++;
+	free = (unsigned long)n - (unsigned long)end_of_stack(current);
+
+	spin_lock(&low_water_lock);
+	if (free < lowest_to_date) {
+		printk(KERN_WARNING "Greatest stack depth - %ld bytes left\n",
+		       free);
+		lowest_to_date = free;
+	}
+	spin_unlock(&low_water_lock);
+}
+#endif
+
 fastcall NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -942,6 +963,9 @@ fastcall NORET_TYPE void do_exit(long co
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
+#ifdef CONFIG_DEBUG_STACK_USAGE
+	check_stack_usage();
+#endif
 	exit_thread();
 	container_exit(tsk, 1);
 	exit_keys(tsk);
Index: linux-2.6.21-mm/arch/um/Kconfig.debug
===================================================================
--- linux-2.6.21-mm.orig/arch/um/Kconfig.debug	2007-06-20 11:57:13.000000000 -0400
+++ linux-2.6.21-mm/arch/um/Kconfig.debug	2007-06-20 11:59:43.000000000 -0400
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
Index: linux-2.6.21-mm/arch/um/defconfig
===================================================================
--- linux-2.6.21-mm.orig/arch/um/defconfig	2007-06-20 11:57:13.000000000 -0400
+++ linux-2.6.21-mm/arch/um/defconfig	2007-06-20 11:58:29.000000000 -0400
@@ -527,3 +527,4 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_GPROF is not set
 # CONFIG_GCOV is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
Index: linux-2.6.21-mm/include/asm-um/thread_info.h
===================================================================
--- linux-2.6.21-mm.orig/include/asm-um/thread_info.h	2007-06-20 11:57:13.000000000 -0400
+++ linux-2.6.21-mm/include/asm-um/thread_info.h	2007-06-20 14:17:22.000000000 -0400
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
 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
