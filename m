Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JAr3m-00080J-Bj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Jan 2008 10:14:23 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JAqqd-0000KR-Ho
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Jan 2008 10:00:48 -0800
Date: Fri, 4 Jan 2008 13:00:36 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080104180036.GA6974@c2.user-mode-linux.org>
References: <E1JA7m0-0007nP-Fi@pomaz-ex.szeredi.hu>
	<20080102200621.GB8847@c2.user-mode-linux.org>
	<E1JAAZt-0008F8-An@pomaz-ex.szeredi.hu>
	<20080102220519.GA10137@c2.user-mode-linux.org>
	<E1JAPc5-00011g-JJ@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1JAPc5-00011g-JJ@pomaz-ex.szeredi.hu>
Subject: Re: [uml-devel] UML woes in 2.6.24-rc6-mm1
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 03, 2008 at 01:55:57PM +0100, Miklos Szeredi wrote:
> This is the one: uml-runtime-detection-of-host-vmsplit-on-i386.patch
> 
> The relevant log line (both for successful and failed boots):
> 
> Locating the top of the address space ... 0xffc00000

Thanks for narrowing it down.  It turns out I can reproduce it with a
defconfig, but it reproduces much more easily with your config for
some reason.

Anyhow, try the patch below.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/include/as-layout.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/as-layout.h	2008-01-01 17:32:04.000000000 -0500
+++ linux-2.6.22/arch/um/include/as-layout.h	2008-01-04 12:27:21.000000000 -0500
@@ -57,6 +57,8 @@ extern unsigned long _stext, _etext, _sd
 extern unsigned long _unprotected_end;
 extern unsigned long brk_start;
 
+extern unsigned long host_task_size;
+
 extern int linux_main(int argc, char **argv);
 
 extern void (*sig_info[])(int, struct uml_pt_regs *);
Index: linux-2.6.22/arch/um/kernel/exec.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/exec.c	2008-01-04 12:12:32.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/exec.c	2008-01-04 12:27:48.000000000 -0500
@@ -25,7 +25,7 @@ void flush_thread(void)
 
 	ret = unmap(&current->mm->context.id, 0, STUB_START, 0, &data);
 	ret = ret || unmap(&current->mm->context.id, STUB_END,
-			   TASK_SIZE - STUB_END, 1, &data);
+			   host_task_size - STUB_END, 1, &data);
 	if (ret) {
 		printk(KERN_ERR "flush_thread - clearing address space failed, "
 		       "err = %d\n", ret);
Index: linux-2.6.22/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/um_arch.c	2008-01-04 12:11:33.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/um_arch.c	2008-01-04 12:53:53.000000000 -0500
@@ -244,6 +244,8 @@ static struct notifier_block panic_exit_
 unsigned long task_size;
 EXPORT_SYMBOL(task_size);
 
+unsigned long host_task_size;
+
 unsigned long brk_start;
 unsigned long end_iomem;
 EXPORT_SYMBOL(end_iomem);
@@ -270,11 +272,12 @@ int __init linux_main(int argc, char **a
 	if (have_root == 0)
 		add_arg(DEFAULT_COMMAND_LINE);
 
+	host_task_size = os_get_task_size();
 	/*
 	 * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
 	 * out
 	 */
-	task_size = os_get_task_size(PGDIR_SHIFT);
+	task_size = host_task_size & PGDIR_MASK;
 
 	/* OS sanity checks that need to happen before the kernel runs */
 	os_early_checks();
Index: linux-2.6.22/arch/um/os-Linux/sys-i386/task_size.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/sys-i386/task_size.c	2008-01-01 17:32:04.000000000 -0500
+++ linux-2.6.22/arch/um/os-Linux/sys-i386/task_size.c	2008-01-04 12:56:20.000000000 -0500
@@ -49,7 +49,7 @@ static int page_ok(unsigned long page)
 		ok = 1;
 		goto out;
 	} else if (mprotect(address, UM_KERN_PAGE_SIZE,
-			  PROT_READ | PROT_WRITE) != 0)
+			    PROT_READ | PROT_WRITE) != 0)
 		goto out;
 
 	if (setjmp(buf) == 0) {
@@ -63,13 +63,20 @@ static int page_ok(unsigned long page)
 	return ok;
 }
 
-unsigned long os_get_task_size(int shift)
+unsigned long os_get_task_size(void)
 {
 	struct sigaction sa, old;
-	unsigned long bottom = 0 >> shift;
-	unsigned long top = ~0UL >> shift;
+	unsigned long bottom = 0;
+	/*
+	 * A 32-bit UML on a 64-bit host gets confused about the VDSO at
+	 * 0xffffe000.  It is mapped, is readable, can be reprotected writeable
+	 * and written.  However, exec discovers later that it can't be
+	 * unmapped.  So, just set the highest address to be checked to just
+	 * below it.  This might waste some address space on 4G/4G 32-bit
+	 * hosts, but shouldn't hurt otherwise.
+	 */
+	unsigned long top = 0xffffd000 >> UM_KERN_PAGE_SHIFT;
 	unsigned long test;
-	int to_page = shift - UM_KERN_PAGE_SHIFT;
 
 	printf("Locating the top of the address space ... ");
 	fflush(stdout);
@@ -83,18 +90,19 @@ unsigned long os_get_task_size(int shift
 	sa.sa_flags = SA_NODEFER;
 	sigaction(SIGSEGV, &sa, &old);
 
-	if (!page_ok(bottom << to_page)) {
-		fprintf(stderr, "Address 0x%x no good?\n", bottom << shift);
+	if (!page_ok(bottom)) {
+		fprintf(stderr, "Address 0x%x no good?\n",
+			bottom << UM_KERN_PAGE_SHIFT);
 		exit(1);
 	}
 
 	/* This could happen with a 4G/4G split */
-	if (page_ok(top << to_page))
+	if (page_ok(top))
 		goto out;
 
 	do {
 		test = bottom + (top - bottom) / 2;
-		if (page_ok(test << to_page))
+		if (page_ok(test))
 			bottom = test;
 		else
 			top = test;
@@ -104,7 +112,9 @@ out:
 	/* Restore the old SIGSEGV handling */
 	sigaction(SIGSEGV, &old, NULL);
 
-	printf("0x%x\n", top << shift);
+	top <<= UM_KERN_PAGE_SHIFT;
+	printf("0x%x\n", top);
 	fflush(stdout);
-	return top << shift;
+
+	return top;
 }
Index: linux-2.6.22/arch/um/include/os.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/os.h	2008-01-04 12:55:38.000000000 -0500
+++ linux-2.6.22/arch/um/include/os.h	2008-01-04 12:55:48.000000000 -0500
@@ -299,6 +299,6 @@ extern int os_arch_prctl(int pid, int co
 extern int get_pty(void);
 
 /* sys-$ARCH/task_size.c */
-extern unsigned long os_get_task_size(int shift);
+extern unsigned long os_get_task_size(void);
 
 #endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
