Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1XaMFF-0001VG-9h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Oct 2014 10:07:21 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XaMFD-00080Z-BQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Oct 2014 10:07:21 +0000
Message-ID: <1412417231.14180.33.camel@localhost.localdomain>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 04 Oct 2014 12:07:11 +0200
In-Reply-To: <CAFLxGvzAru4dCcAkxMeUVyWYfK8x1dYA4X5dO3g7q8D-iZqBNg@mail.gmail.com>
References: <1412292073.14180.16.camel@localhost.localdomain>
	<CAFLxGvzAru4dCcAkxMeUVyWYfK8x1dYA4X5dO3g7q8D-iZqBNg@mail.gmail.com>
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
Subject: [uml-devel] [PATCH] Dump really early stack traces (was: panic()
 call from non-kernel stack in uml_postsetup)
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Am Freitag, den 03.10.2014, 10:17 +0200 schrieb Richard Weinberger:
> On Fri, Oct 3, 2014 at 1:21 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
> > Hi,
> >
> > When you pass an initrd to UML and the size of the initrd is too big for
> > the current kernel memory, a panic() call is done with the message("Out
> > of memory").
> >
> > But this message never hits the stdout as the following stack trace
> > dumps because there is no current_thread_info() in the UML stack, which
> > is still active at this time:
> 
> Do you see the message if you boot UML with the earlyprintk parameter?
> 
Hi,

this panic happens really early, actually only the boot memory is setup
correctly at this point in time, no console, no early console.

The following patch enables UML to also print stack traces from really
early panics, like when the initrd is too big for the allocated memory.
The patch fixes the current_thread_info() access from non-kernel-stack,
i.e. the UML stack itself.
It also registers an kmsg_dumper that dumps the kernel messge buffer via
printf to stdout.
The panic_exit handler is changed to call the kmsg_dumper, as it would
have been the case if the panic_notifer would have return into the
panic() method.

Result looks like this:
[...]
UML running in SKAS0 mode
Adding 19550208 bytes to physical memory to account for exec-shield gap
<1>[    0.000000] bootmem alloc of 44301012 bytes failed!
<0>[    0.000000] Kernel panic - not syncing: Out of memory
<4>[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 3.16.2-dirty #144
<6>[    0.000000] Stack:
<4>[    0.000000]  605f2947 00000002 7fffd9728d68 00000000
<4>[    0.000000]  ffffffff 6002be30 7fffd9729078 60372980
<4>[    0.000000]  7fffd9728d40 604afa9c 60601d98 604ac0cb
<6>[    0.000000] Call Trace:
<6>[    0.000000]  [<6002be30>] ? current_thread_info+0x0/0x40
<6>[    0.000000]  [<60372980>] ? strlen+0x0/0x30
<6>[    0.000000]  [<604afa9c>] dump_stack+0x6b/0x87
<6>[    0.000000]  [<604ac0cb>] ? printk+0x0/0xa0
<6>[    0.000000]  [<60377b90>] ? bust_spinlocks+0x0/0x60
<6>[    0.000000]  [<604ab55b>] panic+0x15d/0x305
<6>[    0.000000]  [<604ab3fe>] ? panic+0x0/0x305
<6>[    0.000000]  [<60046990>] ? memcpy+0x0/0x140
<6>[    0.000000]  [<604ac0cb>] ? printk+0x0/0xa0
<6>[    0.000000]  [<60011862>] ? alloc_bootmem_core+0x0/0x114
<6>[    0.000000]  [<600119a9>] ? ___alloc_bootmem_nopanic+0x33/0x50
<6>[    0.000000]  [<60372980>] ? strlen+0x0/0x30
<6>[    0.000000]  [<60011f88>] __alloc_bootmem+0x4d/0x51
<6>[    0.000000]  [<600060fc>] read_initrd+0x83/0x156
<6>[    0.000000]  [<60005da1>] linux_main+0x466/0x4a9
<6>[    0.000000]  [<6003ff80>] ? change_sig+0x0/0x80
<6>[    0.000000]  [<60006c0b>] main+0x18b/0x390
<6>[    0.000000]  [<600261f0>] ? _start+0x0/0x30
<6>[    0.000000]  [<60006a80>] ? main+0x0/0x390
<6>[    0.000000]  [<600261f0>] ? _start+0x0/0x30
<6>[    0.000000]  [<604aa8c0>] ? __libc_csu_init+0x0/0x70
<6>[    0.000000]  [<600261f0>] ? _start+0x0/0x30
<6>[    0.000000]  [<60026219>] ? _start+0x29/0x30
<6>[    0.000000]  [<600261f0>] ? _start+0x0/0x30
<6>[    0.000000] 
<6>[    0.000000] Stopping all CPUs...done

Feedback/comments are most welcome.

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -44,17 +44,8 @@ struct thread_info {
 #define init_stack		(init_thread_union.stack)
 
 #define THREAD_SIZE ((1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE)
-/* how to get the thread information struct from C */
-static inline struct thread_info *current_thread_info(void)
-{
-	struct thread_info *ti;
-	unsigned long mask = THREAD_SIZE - 1;
-	void *p;
 
-	asm volatile ("" : "=r" (p) : "0" (&ti));
-	ti = (struct thread_info *) (((unsigned long)p) & ~mask);
-	return ti;
-}
+extern struct thread_info *current_thread_info(void);
 
 #define THREAD_SIZE_ORDER CONFIG_KERNEL_STACK_ORDER
 
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -19,6 +19,7 @@ extern int kmalloc_ok;
 #define UML_ROUND_UP(addr) \
 	((((unsigned long) addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
+extern int is_kernel_addr(void* addr);
 extern unsigned long alloc_stack(int order, int atomic);
 extern void free_stack(unsigned long stack, int order);
 
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -13,7 +13,7 @@ clean-files :=
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o smp.o syscall.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o skas/
+	um_arch.o umid.o maccess.o kmsg_dump.o skas/
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 #include <linux/utsname.h>
 #include <linux/sched.h>
+#include <linux/kmsg_dump.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
 @@ -234,6 +235,7 @@ static void __init uml_postsetup(void)
 static int panic_exit(struct notifier_block *self, unsigned long unused1,
 		      void *unused2)
 {
+	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(1);
 	bust_spinlocks(0);
 	uml_exitcode = 1;
@@ -407,3 +421,21 @@ void alternatives_smp_module_del(struct module *mod)
 {
 }
 #endif
+
+/* how to get the thread information struct from C */
+inline struct thread_info *current_thread_info(void)
+{
+	struct thread_info *ti;
+	unsigned long mask = THREAD_SIZE - 1;
+	void *p;
+
+	asm volatile ("" : "=r" (p) : "0" (&ti));
+	ti = (struct thread_info *) (((unsigned long)p) & ~mask);
+	if(!is_kernel_addr((void*)ti)) {
+		return &init_thread_info;
+	}
+	return ti;
+}
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -254,7 +255,7 @@ void __wrap_free(void *ptr)
 	 * there is a possibility for memory leaks.
 	 */
 
-	if ((addr >= uml_physmem) && (addr < high_physmem)) {
+	if (is_kernel_addr(addr)) {
 		if (kmalloc_ok)
 			kfree(ptr);
 	}
@@ -264,3 +265,10 @@ void __wrap_free(void *ptr)
 	}
 	else __real_free(ptr);
 }
+
+int is_kernel_addr(void* addr)
+{
+	if((addr >= uml_physmem) && (addr < high_physmem))
+		return 1;
+	return 0;
+}
\ No newline at end of file
--- /dev/null	2014-10-01 22:51:22.599698712 +0200
+++ arch/um/kernel/kmsg_dump.c	2014-10-04 01:33:45.792999523 +0200
@@ -0,0 +1,25 @@
+#include <linux/kmsg_dump.h>
+#include <shared/init.h>
+#include <shared/kern.h>
+
+static struct kmsg_dumper pf_dumper;
+
+static void pf_kmsg_dump(struct kmsg_dumper *dumper,
+			 enum kmsg_dump_reason reason)
+{
+	static char line[1024];
+	size_t len;
+
+	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
+		line[len-1] = '\0';
+		printf("%s\n", line);
+	}
+}
+
+int kmsg_dump_printf(void)
+{
+	pf_dumper.dump = pf_kmsg_dump;
+	return kmsg_dump_register(&pf_dumper);
+}
+
+__uml_initcall(kmsg_dump_printf);



------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

