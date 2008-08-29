Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZDCP-0005Ef-Aq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:16:13 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KZDCO-0002rH-Vt
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:16:13 -0700
Date: Fri, 29 Aug 2008 16:16:12 -0700 (PDT)
From: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
In-Reply-To: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
Message-ID: <alpine.DEB.1.00.0808291615300.15543@abydos.NerdBox.Net>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 3/6] UML and sched: Annotate stacks
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
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, jiayingz@google.com, dkegel@google.com

Track and tell valgrind about kernel mode stacks.  Valgrind gets confused
without these annotations because it expects processes to only use their
initial stack and stacks created for threads by way of clone.

Signed-off-by: Steve VanDeBogart <vandebo-lkml@nerdbox.net>
---

Index: linux-2.6.27-rc5/arch/um/kernel/process.c
===================================================================
--- linux-2.6.27-rc5.orig/arch/um/kernel/process.c	2008-08-29 14:17:31.000000000 -0700
+++ linux-2.6.27-rc5/arch/um/kernel/process.c	2008-08-29 14:41:34.000000000 -0700
@@ -16,6 +16,7 @@
  #include <linux/sched.h>
  #include <linux/tick.h>
  #include <linux/threads.h>
+#include <linux/valgrind.h>
  #include <asm/current.h>
  #include <asm/pgtable.h>
  #include <asm/uaccess.h>
@@ -62,10 +63,40 @@
  	if (atomic)
  		flags = GFP_ATOMIC;
  	page = __get_free_pages(flags, order);
+	/* There are long lived stacks and we won't free them */
+	if (page)
+		VALGRIND_STACK_REGISTER(page + (PAGE_SIZE << order) - 1, page);

  	return page;
  }

+struct thread_info *alloc_thread_info(struct task_struct *tsk)
+{
+	struct thread_info *ti;
+#ifdef CONFIG_DEBUG_STACK_USAGE
+	gfp_t mask = GFP_KERNEL | __GFP_ZERO;
+#else
+	gfp_t mask = GFP_KERNEL;
+#endif
+	ti = (struct thread_info *) __get_free_pages(mask,
+						CONFIG_KERNEL_STACK_ORDER);
+#ifdef CONFIG_VALGRIND_SUPPORT
+	if (ti) {
+		VALGRIND_MALLOCLIKE_BLOCK(ti, sizeof(*ti), 0, 0);
+		ti->valgrind_sid = VALGRIND_STACK_REGISTER((unsigned long)ti
+						+ UM_THREAD_SIZE - 1, ti + 1);
+	}
+#endif
+	return ti;
+}
+
+void free_thread_info(struct thread_info *ti)
+{
+	VALGRIND_STACK_DEREGISTER(ti->valgrind_sid);
+	VALGRIND_FREELIKE_BLOCK(ti, 0);
+	free_pages((unsigned long)ti, CONFIG_KERNEL_STACK_ORDER);
+}
+
  int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
  {
  	int pid;
Index: linux-2.6.27-rc5/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.27-rc5.orig/arch/um/kernel/skas/process.c	2008-07-13 14:51:29.000000000 -0700
+++ linux-2.6.27-rc5/arch/um/kernel/skas/process.c	2008-08-29 14:32:45.000000000 -0700
@@ -5,6 +5,7 @@

  #include "linux/init.h"
  #include "linux/sched.h"
+#include "linux/valgrind.h"
  #include "as-layout.h"
  #include "kern.h"
  #include "os.h"
@@ -65,6 +66,8 @@
  	}

  	init_new_thread_signals();
+	VALGRIND_STACK_REGISTER((unsigned long)(&init_stack + 1) - 1,
+				&init_thread_info + 1);

  	init_task.thread.request.u.thread.proc = start_kernel_proc;
  	init_task.thread.request.u.thread.arg = NULL;
Index: linux-2.6.27-rc5/include/asm-um/thread_info.h
===================================================================
--- linux-2.6.27-rc5.orig/include/asm-um/thread_info.h	2008-08-29 14:17:37.000000000 -0700
+++ linux-2.6.27-rc5/include/asm-um/thread_info.h	2008-08-29 14:46:02.000000000 -0700
@@ -24,6 +24,9 @@
  						   0-0xFFFFFFFF for kernel */
  	struct restart_block    restart_block;
  	struct thread_info	*real_thread;    /* Points to non-IRQ stack */
+#ifdef CONFIG_VALGRIND_SUPPORT
+	unsigned int valgrind_sid;
+#endif
  };

  #define INIT_THREAD_INFO(tsk)			\
@@ -55,6 +58,11 @@

  #define THREAD_SIZE_ORDER CONFIG_KERNEL_STACK_ORDER

+#define __HAVE_ARCH_THREAD_INFO_ALLOCATOR
+
+extern struct thread_info *alloc_thread_info(struct task_struct *tsk);
+extern void free_thread_info(struct thread_info *ti);
+
  #endif

  #define PREEMPT_ACTIVE		0x10000000
Index: linux-2.6.27-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.27-rc5.orig/include/linux/sched.h	2008-08-29 14:17:38.000000000 -0700
+++ linux-2.6.27-rc5/include/linux/sched.h	2008-08-29 14:32:45.000000000 -0700
@@ -1947,8 +1947,14 @@

  static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
  {
+#ifdef CONIG_VALGRIND_SUPPORT
+	unsigned int valgrind_sid = task_thread_info(p)->valgrind_sid;
+#endif
  	*task_thread_info(p) = *task_thread_info(org);
  	task_thread_info(p)->task = p;
+#ifdef CONIG_VALGRIND_SUPPORT
+	task_thread_info(p)->valgrind_sid = valgrind_sid;
+#endif
  }

  static inline unsigned long *end_of_stack(struct task_struct *p)

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
