Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8yLz-0000p2-3m for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Sep 2004 02:51:31 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1C8yLy-0001Jk-5J for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Sep 2004 02:51:31 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040919094602.7D09890DD@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml-malloc-use-vmalloc-fix-again
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
Date: Sun, 19 Sep 2004 11:46:01 +0200
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Since we sometimes disable temporarily kmalloc_ok (don't ask me why), we
must test, inside __wrap_free, the new CAN_KFREE macro; and then we must update
every reference to kmalloc_ok to handle correctly even kfree_ok. Also encapsulate
a bit more this code.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/include/kern_util.h   |   10 ++++++-
 uml-linux-2.6.8.1-paolo/arch/um/kernel/main.c         |   24 ++++++++++++------
 uml-linux-2.6.8.1-paolo/arch/um/kernel/mem.c          |    5 ++-
 uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c      |    2 -
 uml-linux-2.6.8.1-paolo/arch/um/kernel/process_kern.c |    6 ++--
 uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process.c |    4 +--
 uml-linux-2.6.8.1-paolo/arch/um/kernel/tt/tracer.c    |    2 -
 7 files changed, 35 insertions(+), 18 deletions(-)

diff -puN arch/um/include/kern_util.h~uml-malloc-use-vmalloc-fix-again arch/um/include/kern_util.h
--- uml-linux-2.6.8.1/arch/um/include/kern_util.h~uml-malloc-use-vmalloc-fix-again	2004-09-17 17:19:13.946898416 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/include/kern_util.h	2004-09-17 17:19:13.984892640 +0200
@@ -12,7 +12,15 @@
 extern int ncpus;
 extern char *linux_prog;
 extern char *gdb_init;
-extern int kmalloc_ok;
+
+extern int __kmalloc_ok;
+extern int __kfree_ok;
+
+#define KMALLOC_START() ({ __kmalloc_ok = __kfree_ok = 1; })
+#define KMALLOC_STOP() ({ __kmalloc_ok = __kfree_ok = 0; })
+#define KMALLOC_SAVE(save) ({ (save) = __kmalloc_ok; __kmalloc_ok = 0; })
+#define KMALLOC_RESTORE(save) ({ __kmalloc_ok = (save); })
+
 extern int timer_irq_inited;
 extern int jail;
 extern int nsyscalls;
diff -puN arch/um/kernel/main.c~uml-malloc-use-vmalloc-fix-again arch/um/kernel/main.c
--- uml-linux-2.6.8.1/arch/um/kernel/main.c~uml-malloc-use-vmalloc-fix-again	2004-09-17 17:19:13.947898264 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/main.c	2004-09-17 17:19:13.984892640 +0200
@@ -68,7 +68,7 @@ static __init void do_uml_initcalls(void
 
 static void last_ditch_exit(int sig)
 {
-	CHOOSE_MODE(kmalloc_ok = 0, (void) 0);
+	CHOOSE_MODE(KMALLOC_STOP(), (void) 0);
 	signal(SIGINT, SIG_DFL);
 	signal(SIGTERM, SIG_DFL);
 	signal(SIGHUP, SIG_DFL);
@@ -172,7 +172,11 @@ int main(int argc, char **argv, char **e
 }
 
 #define CAN_KMALLOC() \
-	(kmalloc_ok && CHOOSE_MODE((getpid() != tracing_pid), 1))
+	(__kmalloc_ok && CHOOSE_MODE((getpid() != tracing_pid), 1))
+
+/*Must we still check if we are not in the tracing thread? I'm not sure about this.*/
+#define CAN_KFREE() \
+	(__kfree_ok && CHOOSE_MODE((getpid() != tracing_pid), 1))
 
 extern void *__real_malloc(int);
 
@@ -211,6 +215,8 @@ extern unsigned long high_physmem;
 void __wrap_free(void *ptr)
 {
 	unsigned long addr = (unsigned long) ptr;
+	if (addr == 0)
+		return;
 
 	/* We need to know how the allocation happened, so it can be correctly
 	 * freed.  This is done by seeing what region of memory the pointer is
@@ -218,9 +224,10 @@ void __wrap_free(void *ptr)
 	 * 	physical memory - kmalloc/kfree
 	 *	kernel virtual memory - vmalloc/vfree
 	 * 	anywhere else - malloc/free
-	 * If kmalloc is not yet possible, then the kernel memory regions
-	 * may not be set up yet, and the variables not set up.  So,
-	 * free is called.
+	 * If kmalloc is not yet possible, then high_physmem and end_vm are 0,
+	 * so we will always use __real_free.
+	 * And since we disable sometimes __kmalloc_ok while running,
+	 * we cannot check CAN_KMALLOC. CAN_KFREE is created exactly for this.
 	 *
 	 * CAN_KMALLOC is checked because it would be bad to free a buffer
 	 * with kmalloc/vmalloc after they have been turned off during
@@ -228,14 +235,15 @@ void __wrap_free(void *ptr)
 	 */
 
 	if((addr >= uml_physmem) && (addr < high_physmem)){
-		if(CAN_KMALLOC())
+		if(CAN_KFREE())
 			kfree(ptr);
 	}
 	else if((addr >= start_vm) && (addr < end_vm)){
-		if(CAN_KMALLOC())
+		if(CAN_KFREE())
 			vfree(ptr);
 	}
-	else __real_free(ptr);
+	else
+		__real_free(ptr);
 }
 
 /*
diff -puN arch/um/kernel/mem.c~uml-malloc-use-vmalloc-fix-again arch/um/kernel/mem.c
--- uml-linux-2.6.8.1/arch/um/kernel/mem.c~uml-malloc-use-vmalloc-fix-again	2004-09-17 17:19:13.948898112 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/mem.c	2004-09-17 17:19:13.984892640 +0200
@@ -27,7 +27,8 @@ unsigned long *empty_zero_page = NULL;
 unsigned long *empty_bad_page = NULL;
 pgd_t swapper_pg_dir[1024];
 unsigned long highmem;
-int kmalloc_ok = 0;
+int __kmalloc_ok = 0;
+int __kfree_ok = 0;
 
 static unsigned long brk_end;
 
@@ -98,7 +99,7 @@ void mem_init(void)
 	max_pfn = totalram_pages;
 	printk(KERN_INFO "Memory: %luk available\n", 
 	       (unsigned long) nr_free_pages() << (PAGE_SHIFT-10));
-	kmalloc_ok = 1;
+	KMALLOC_START();
 
 #ifdef CONFIG_HIGHMEM
 	setup_highmem(end_iomem, highmem);
diff -puN arch/um/kernel/physmem.c~uml-malloc-use-vmalloc-fix-again arch/um/kernel/physmem.c
--- uml-linux-2.6.8.1/arch/um/kernel/physmem.c~uml-malloc-use-vmalloc-fix-again	2004-09-17 17:19:13.949897960 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c	2004-09-17 17:19:13.985892488 +0200
@@ -291,7 +291,7 @@ int init_maps(unsigned long physmem, uns
 	total_pages = phys_pages + iomem_pages + highmem_pages;
 	total_len = phys_len + iomem_pages + highmem_len;
 
-	if(kmalloc_ok){
+	if(__kmalloc_ok){
 		map = kmalloc(total_len, GFP_KERNEL);
 		if(map == NULL) 
 			map = vmalloc(total_len);
diff -puN arch/um/kernel/process_kern.c~uml-malloc-use-vmalloc-fix-again arch/um/kernel/process_kern.c
--- uml-linux-2.6.8.1/arch/um/kernel/process_kern.c~uml-malloc-use-vmalloc-fix-again	2004-09-17 17:19:13.950897808 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/process_kern.c	2004-09-17 17:19:13.985892488 +0200
@@ -171,12 +171,12 @@ int copy_thread(int nr, unsigned long cl
 
 void initial_thread_cb(void (*proc)(void *), void *arg)
 {
-	int save_kmalloc_ok = kmalloc_ok;
+	int save_kmalloc_ok;
 
-	kmalloc_ok = 0;
+	KMALLOC_SAVE(save_kmalloc_ok);
 	CHOOSE_MODE_PROC(initial_thread_cb_tt, initial_thread_cb_skas, proc, 
 			 arg);
-	kmalloc_ok = save_kmalloc_ok;
+	KMALLOC_RESTORE(save_kmalloc_ok);
 }
  
 unsigned long stack_sp(unsigned long page)
diff -puN arch/um/kernel/skas/process.c~uml-malloc-use-vmalloc-fix-again arch/um/kernel/skas/process.c
--- uml-linux-2.6.8.1/arch/um/kernel/skas/process.c~uml-malloc-use-vmalloc-fix-again	2004-09-17 17:19:13.951897656 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/skas/process.c	2004-09-17 17:19:13.985892488 +0200
@@ -325,11 +325,11 @@ int start_idle_thread(void *stack, void 
 		siglongjmp(*cb_back, 1);
 	}
 	else if(n == 3){
-		kmalloc_ok = 0;
+		KMALLOC_STOP();
 		return(0);
 	}
 	else if(n == 4){
-		kmalloc_ok = 0;
+		KMALLOC_STOP();
 		return(1);
 	}
 	siglongjmp(**switch_buf, 1);
diff -puN arch/um/kernel/tt/tracer.c~uml-malloc-use-vmalloc-fix-again arch/um/kernel/tt/tracer.c
--- uml-linux-2.6.8.1/arch/um/kernel/tt/tracer.c~uml-malloc-use-vmalloc-fix-again	2004-09-17 17:19:13.952897504 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/tt/tracer.c	2004-09-17 17:19:13.986892336 +0200
@@ -310,7 +310,7 @@ int tracer(int (*init_proc)(void *), voi
 				case OP_REBOOT:
 				case OP_HALT:
 					unmap_physmem();
-					kmalloc_ok = 0;
+					KMALLOC_STOP();
 					ptrace(PTRACE_KILL, pid, 0, 0);
 					return(op == OP_REBOOT);
 				case OP_NONE:
_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
