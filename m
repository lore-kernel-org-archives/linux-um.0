Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C09ex-0006N4-Ns for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Aug 2004 19:06:39 -0700
Received: from mail.britsys.net ([216.183.103.29] helo=mail02.WWW.BRITSYS.NET)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C09et-0005KK-Fa for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Aug 2004 19:06:35 -0700
Received: from beatnik by malice.crymeariver.org with local (Exim 3.36 #1
	(Debian)) id 1C09ek-0007QJ-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 25 Aug 2004 22:06:26 -0400
From: David Jeffery <djeffery@britsys.net>
Message-ID: <20040826020626.GA28471@malice.crymeariver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
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
Date: Wed, 25 Aug 2004 22:06:26 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is a patch against 2.6.8.1-mm4 to fix a skas UML problem with a 
nptl glibc.

UML with an nptl enabled glibc causes process creation to fail with 
this assertion failure in nptl:

bash: ../nptl/sysdeps/unix/sysv/linux/fork.c:132: __libc_fork: Assertion `({ 
__typeof (self->tid) __value; if (sizeof (__value) == 1) asm volatile 
("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" (((size_t) 
&((struct pthread *)0)->tid))); else if (sizeof (__value) == 4) asm 
volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" (((size_t) &((struct 
pthread *)0)->tid))); else { if (sizeof (__value) != 8) abort (); asm 
volatile ("movl %%gs:%P1,%%eax\n\t" "movl %%gs:%P2,%%edx" : "=A" 
(__value) : "i" (((size_t) &((struct pthread *)0)->tid)), "i" (((size_t) 
&((struct pthread *)0)->tid) + 4)); } __value; }) != ppid' failed.

The problem is caused by the incorrect implementation of sys_clone().  
sys_clone() is an ugly beast that has different arguements depending on 
the architecture.  For i386 and ppc, the child tid is passed as the 
5th arguement instead of as the 4th arguement as as some other 
architectures (like x86-64) do.  The 4th arguement on i386 and ppc 
doesn't look to be used by the kernel.

With this patch I've been running several UML skas images with a Debian 
Sarge based systems for several days without problem.  The patch adds a 
sys_clone_5arg() on i386 and ppc which just raps around the current 
sys_clone() so the child tid pointer in the 5th arguement will be passed 
down correctly.  I don't get any style points for this patch so feel 
free to pretty it up.

David Jeffery

diff -urN linux-2.6.8.1-mm4.orig/arch/um/Makefile linux-2.6.8.1-mm4/arch/um/Makefile
--- linux-2.6.8.1-mm4.orig/arch/um/Makefile	2004-08-25 20:52:56.000000000 -0400
+++ linux-2.6.8.1-mm4/arch/um/Makefile	2004-08-22 16:55:52.000000000 -0400
@@ -59,7 +59,8 @@
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
 	-D_LARGEFILE64_SOURCE $(ARCH_INCLUDE) -Derrno=kernel_errno \
-	-Dsigprocmask=kernel_sigprocmask $(MODE_INCLUDE)
+	-Dsigprocmask=kernel_sigprocmask $(MODE_INCLUDE) \
+	-D__subarch_$(SUBARCH)__
 
 CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
 
diff -urN linux-2.6.8.1-mm4.orig/arch/um/kernel/sys_call_table.c linux-2.6.8.1-mm4/arch/um/kernel/sys_call_table.c
--- linux-2.6.8.1-mm4.orig/arch/um/kernel/sys_call_table.c	2004-08-25 20:52:56.000000000 -0400
+++ linux-2.6.8.1-mm4/arch/um/kernel/sys_call_table.c	2004-08-22 16:55:52.000000000 -0400
@@ -19,6 +19,12 @@
 #define NFSSERVCTL sys_ni_syscall
 #endif
 
+#if defined(__subarch_i386__) || defined(__subarch_ppc__)
+#define SYS_CLONE sys_clone_5arg
+#else
+#define SYS_CLONE sys_clone
+#endif
+
 #define LAST_GENERIC_SYSCALL __NR_vserver
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
@@ -41,6 +47,7 @@
 extern syscall_handler_t sys_uname;
 extern syscall_handler_t sys_ipc;
 extern syscall_handler_t sys_sigreturn;
+extern syscall_handler_t sys_clone_5arg;
 extern syscall_handler_t sys_clone;
 extern syscall_handler_t sys_rt_sigreturn;
 extern syscall_handler_t sys_rt_sigaction;
@@ -177,7 +184,7 @@
 	[ __NR_ipc ] (syscall_handler_t *) sys_ipc,
 	[ __NR_fsync ] (syscall_handler_t *) sys_fsync,
 	[ __NR_sigreturn ] (syscall_handler_t *) sys_sigreturn,
-	[ __NR_clone ] (syscall_handler_t *) sys_clone,
+	[ __NR_clone ] (syscall_handler_t *) SYS_CLONE,
 	[ __NR_setdomainname ] (syscall_handler_t *) sys_setdomainname,
 	[ __NR_uname ] (syscall_handler_t *) sys_newuname,
 	[ __NR_adjtimex ] (syscall_handler_t *) sys_adjtimex,
diff -urN linux-2.6.8.1-mm4.orig/arch/um/kernel/syscall_kern.c linux-2.6.8.1-mm4/arch/um/kernel/syscall_kern.c
--- linux-2.6.8.1-mm4.orig/arch/um/kernel/syscall_kern.c	2004-08-25 20:52:56.000000000 -0400
+++ linux-2.6.8.1-mm4/arch/um/kernel/syscall_kern.c	2004-08-22 16:55:52.000000000 -0400
@@ -55,6 +55,14 @@
 	return(ret);
 }
 
+#if defined(__subarch_i386__) || defined(__subarch_ppc__)
+long sys_clone_5arg(unsigned long clone_flags, unsigned long newsp,
+               int *parent_tid, unsigned long unused, int *child_tid)
+{
+        return sys_clone(clone_flags, newsp, parent_tid, child_tid);
+}
+#endif
+
 long sys_vfork(void)
 {
 	long ret;


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
