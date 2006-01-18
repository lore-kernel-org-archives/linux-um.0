Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1Ap-0007KX-S0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:39 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez1Ap-0000uW-Ab
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:39 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118001938.14622.47308.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 6/9] uml: avoid malloc to sleep in atomic sections
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
Date: Wed, 18 Jan 2006 01:19:40 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Ugly trick to help make malloc not sleeping - we can't do anything else. But
this is not yet optimal, since spinlock don't trigger in_atomic() when
preemption is disabled.

Also, even if ugly, this was already used in one place, and was even more bogus.
Fix it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/kern_util.h   |    4 +++-
 arch/um/include/user.h        |    1 +
 arch/um/kernel/process_kern.c |   21 +++++++++++++--------
 arch/um/os-Linux/helper.c     |    4 ++--
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
index 8f4e46d..c649108 100644
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -120,8 +120,10 @@ extern void machine_halt(void);
 extern int is_syscall(unsigned long addr);
 extern void arch_switch(void);
 extern void free_irq(unsigned int, void *);
-extern int um_in_interrupt(void);
 extern int cpu(void);
+
+/* Are we disallowed to sleep? Used to choose between GFP_KERNEL and GFP_ATOMIC. */
+extern int __cant_sleep(void);
 extern void segv_handler(int sig, union uml_pt_regs *regs);
 extern void sigio_handler(int sig, union uml_pt_regs *regs);
 
diff --git a/arch/um/include/user.h b/arch/um/include/user.h
index 0f865ef..91b0ac4 100644
--- a/arch/um/include/user.h
+++ b/arch/um/include/user.h
@@ -18,6 +18,7 @@ extern int open_gdb_chan(void);
 extern unsigned long strlcpy(char *, const char *, unsigned long);
 extern unsigned long strlcat(char *, const char *, unsigned long);
 extern void *um_vmalloc(int size);
+extern void *um_vmalloc_atomic(int size);
 extern void vfree(void *ptr);
 
 #endif
diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
index 7f13b85..d852c55 100644
--- a/arch/um/kernel/process_kern.c
+++ b/arch/um/kernel/process_kern.c
@@ -288,17 +288,27 @@ EXPORT_SYMBOL(disable_hlt);
 
 void *um_kmalloc(int size)
 {
-	return(kmalloc(size, GFP_KERNEL));
+	return kmalloc(size, GFP_KERNEL);
 }
 
 void *um_kmalloc_atomic(int size)
 {
-	return(kmalloc(size, GFP_ATOMIC));
+	return kmalloc(size, GFP_ATOMIC);
 }
 
 void *um_vmalloc(int size)
 {
-	return(vmalloc(size));
+	return vmalloc(size);
+}
+
+void *um_vmalloc_atomic(int size)
+{
+	return __vmalloc(size, GFP_ATOMIC | __GFP_HIGHMEM, PAGE_KERNEL);
+}
+
+int __cant_sleep(void) {
+	return in_atomic() || irqs_disabled() || in_interrupt();
+	/* Is in_interrupt() really needed? */
 }
 
 unsigned long get_fault_addr(void)
@@ -370,11 +380,6 @@ int smp_sigio_handler(void)
 	return(0);
 }
 
-int um_in_interrupt(void)
-{
-	return(in_interrupt());
-}
-
 int cpu(void)
 {
 	return(current_thread->cpu);
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 36cc847..6490a4f 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -60,7 +60,7 @@ int run_helper(void (*pre_exec)(void *),
 
 	if((stack_out != NULL) && (*stack_out != 0))
 		stack = *stack_out;
-	else stack = alloc_stack(0, um_in_interrupt());
+	else stack = alloc_stack(0, __cant_sleep());
 	if(stack == 0)
 		return(-ENOMEM);
 
@@ -124,7 +124,7 @@ int run_helper_thread(int (*proc)(void *
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(stack_order, um_in_interrupt());
+	stack = alloc_stack(stack_order, __cant_sleep());
 	if(stack == 0) return(-ENOMEM);
 
 	sp = stack + (page_size() << stack_order) - sizeof(void *);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
