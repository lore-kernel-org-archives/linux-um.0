Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMqXB-0004w9-G6	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 10:24:57 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMqXA-0002W5-5p
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 10:24:57 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20051004172446.GL7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051002183758.GR7992@ftp.linux.org.uk>
	<20051002205451.GS7992@ftp.linux.org.uk>
	<200510032030.23705.blaisorblade@yahoo.it>
	<20051004170941.GI7992@ftp.linux.org.uk>
	<20051004171419.GJ7992@ftp.linux.org.uk>
	<20051004171845.GK7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004171845.GK7992@ftp.linux.org.uk>
Subject: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
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
Date: Tue, 4 Oct 2005 18:24:46 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

	Taking clone.c to sys-*, making it a normal kernel object, trimming
stub.h
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc3-git4-base/arch/um/include/sysdep-i386/stub.h current/arch/um/include/sysdep-i386/stub.h
--- RC14-rc3-git4-base/arch/um/include/sysdep-i386/stub.h	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/um/include/sysdep-i386/stub.h	2005-10-03 23:31:59.000000000 -0400
@@ -12,54 +12,7 @@
 extern void stub_segv_handler(int sig);
 extern void stub_clone_handler(void);
 
-#define STUB_SYSCALL_RET EAX
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
 
-static inline long stub_syscall2(long syscall, long arg1, long arg2)
-{
-	long ret;
-
-	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
-	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
-	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
-	__asm__("int $0x80;" : : : "%eax");
-	__asm__ __volatile__("movl %%eax, %0; " : "=g" (ret) :);
-	return(ret);
-}
-
-static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
-{
-	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
-	return(stub_syscall2(syscall, arg1, arg2));
-}
-
-static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
-				 long arg4)
-{
-	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
-	return(stub_syscall3(syscall, arg1, arg2, arg3));
-}
-
-static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5, long arg6)
-{
-	long ret;
-	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
-	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
-	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
-	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
-	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
-	__asm__("movl %0, %%edi; " : : "g" (arg5) : "%edi");
-	__asm__ __volatile__("pushl %%ebp ; movl %1, %%ebp; "
-		"int $0x80; popl %%ebp ; "
-		"movl %%eax, %0; " : "=g" (ret) : "g" (arg6) : "%eax");
-	return(ret);
-}
-
-static inline void trap_myself(void)
-{
-	__asm("int3");
-}
-
 #endif
diff -urN RC14-rc3-git4-base/arch/um/include/sysdep-x86_64/stub.h current/arch/um/include/sysdep-x86_64/stub.h
--- RC14-rc3-git4-base/arch/um/include/sysdep-x86_64/stub.h	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/um/include/sysdep-x86_64/stub.h	2005-10-02 23:04:09.000000000 -0400
@@ -13,46 +13,7 @@
 extern void stub_segv_handler(int sig);
 extern void stub_clone_handler(void);
 
-#define STUB_SYSCALL_RET PT_INDEX(RAX)
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
 
-static inline long stub_syscall2(long syscall, long arg1, long arg2)
-{
-	long ret;
-
-	__asm__("movq %0, %%rsi; " : : "g" (arg2) : "%rsi");
-	__asm__("movq %0, %%rdi; " : : "g" (arg1) : "%rdi");
-	__asm__("movq %0, %%rax; " : : "g" (syscall) : "%rax");
-	__asm__("syscall;" : : : "%rax", "%r11", "%rcx");
-	__asm__ __volatile__("movq %%rax, %0; " : "=g" (ret) :);
-	return(ret);
-}
-
-static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
-{
-	__asm__("movq %0, %%rdx; " : : "g" (arg3) : "%rdx");
-	return(stub_syscall2(syscall, arg1, arg2));
-}
-
-static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
-				 long arg4)
-{
-	__asm__("movq %0, %%r10; " : : "g" (arg4) : "%r10");
-	return(stub_syscall3(syscall, arg1, arg2, arg3));
-}
-
-static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5, long arg6)
-{
-	__asm__("movq %0, %%r9; " : : "g" (arg6) : "%r9");
-	__asm__("movq %0, %%r8; " : : "g" (arg5) : "%r8");
-	return(stub_syscall4(syscall, arg1, arg2, arg3, arg4));
-}
-
-static inline void trap_myself(void)
-{
-	__asm("int3");
-}
-
 #endif
diff -urN RC14-rc3-git4-base/arch/um/kernel/skas/Makefile current/arch/um/kernel/skas/Makefile
--- RC14-rc3-git4-base/arch/um/kernel/skas/Makefile	2005-09-12 14:33:28.000000000 -0400
+++ current/arch/um/kernel/skas/Makefile	2005-10-02 22:54:22.000000000 -0400
@@ -3,12 +3,9 @@
 # Licensed under the GPL
 #
 
-obj-y := clone.o exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
+obj-y := exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
 	syscall.o tlb.o trap_user.o uaccess.o
 
-USER_OBJS := process.o clone.o
+USER_OBJS := process.o
 
 include arch/um/scripts/Makefile.rules
-
-# clone.o is in the stub, so it can't be built with profiling
-$(obj)/clone.o : c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS))
diff -urN RC14-rc3-git4-base/arch/um/kernel/skas/include/stub-data.h current/arch/um/kernel/skas/include/stub-data.h
--- RC14-rc3-git4-base/arch/um/kernel/skas/include/stub-data.h	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/um/kernel/skas/include/stub-data.h	2005-10-02 22:44:11.000000000 -0400
@@ -6,7 +6,11 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
+#ifdef __KERNEL__
+#include <linux/time.h>
+#else
 #include <sys/time.h>
+#endif
 
 struct stub_data {
 	long offset;
diff -urN RC14-rc3-git4-base/arch/um/sys-i386/Makefile current/arch/um/sys-i386/Makefile
--- RC14-rc3-git4-base/arch/um/sys-i386/Makefile	2005-10-04 13:19:47.000000000 -0400
+++ current/arch/um/sys-i386/Makefile	2005-10-04 07:35:43.000000000 -0400
@@ -6,6 +6,7 @@
 subarch-obj-$(CONFIG_HIGHMEM) += mm/highmem.o
 subarch-obj-$(CONFIG_MODULES) += kernel/module.o
 
+obj-$(CONFIG_MODE_SKAS) += clone.o
 
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
 
@@ -13,5 +14,5 @@
 
 extra-$(CONFIG_MODE_TT) += unmap.o
 
-$(obj)/stub_segv.o $(obj)/unmap.o: \
+$(obj)/stub_segv.o $(obj)/clone.o $(obj)/unmap.o: \
 	_c_flags = $(call unprofile,$(CFLAGS))
diff -urN RC14-rc3-git4-base/arch/um/sys-i386/clone.c current/arch/um/sys-i386/clone.c
--- RC14-rc3-git4-base/arch/um/sys-i386/clone.c	1969-12-31 19:00:00.000000000 -0500
+++ current/arch/um/sys-i386/clone.c	2005-10-02 22:54:52.000000000 -0400
@@ -0,0 +1,47 @@
+#include <linux/config.h>
+#include <asm/unistd.h>
+#include <linux/mman.h>
+#include <linux/ptrace.h>
+#include "stub-data.h"
+
+static int errno;
+
+static inline _syscall2(int,clone,unsigned long,flags,unsigned long,newsp)
+static inline _syscall4(long,ptrace,long,request,
+			pid_t,pid,void *,addr,void *,data);
+static inline _syscall3(int,setitimer,int,which, const struct itimerval *,value,
+			struct itimerval *,ovalue);
+static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
+
+static inline void trap_myself(void)
+{
+	__asm("int3");
+}
+
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_clone_handler(void)
+{
+	long err;
+	struct stub_data *from = (struct stub_data *) CONFIG_STUB_DATA;
+
+	err = clone(CLONE_PARENT | CLONE_FILES | SIGCHLD,
+		    CONFIG_STUB_DATA + PAGE_SIZE / 2 - sizeof(void *));
+	if (err)
+		goto out;
+
+	err = ptrace(PTRACE_TRACEME, 0, NULL, NULL);
+	if (err)
+		goto out;
+
+	err = setitimer(ITIMER_VIRTUAL, &from->timer, NULL);
+	if (err)
+		goto out;
+
+	err = (long)mmap2((void *)CONFIG_STUB_DATA, PAGE_SIZE,
+			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
+			    from->fd, from->offset);
+out:
+	/* save current result. Parent: pid; child: retcode of mmap */
+	from->err = err == -1 ? errno : err;
+	trap_myself();
+}
diff -urN RC14-rc3-git4-base/arch/um/sys-x86_64/Makefile current/arch/um/sys-x86_64/Makefile
--- RC14-rc3-git4-base/arch/um/sys-x86_64/Makefile	2005-10-04 13:19:47.000000000 -0400
+++ current/arch/um/sys-x86_64/Makefile	2005-10-04 07:37:19.000000000 -0400
@@ -8,6 +8,7 @@
 	signal.o stub.o stub_segv.o syscalls.o syscall_table.o sysrq.o ksyms.o
 
 obj-$(CONFIG_MODULES) += um_module.o
+obj-$(CONFIG_MODE_SKAS) += clone.o
 
 subarch-obj-y = lib/bitops.o lib/csum-partial.o lib/memcpy.o lib/thunk.o
 subarch-obj-$(CONFIG_MODULES) += kernel/module.o
@@ -18,5 +19,5 @@
 
 extra-$(CONFIG_MODE_TT) += unmap.o
 
-$(obj)/stub_segv.o $(obj)/unmap.o: \
+$(obj)/stub_segv.o $(obj)/clone.o $(obj)/unmap.o: \
 	_c_flags = $(call unprofile,$(CFLAGS))
diff -urN RC14-rc3-git4-base/arch/um/sys-x86_64/clone.c current/arch/um/sys-x86_64/clone.c
--- RC14-rc3-git4-base/arch/um/sys-x86_64/clone.c	1969-12-31 19:00:00.000000000 -0500
+++ current/arch/um/sys-x86_64/clone.c	2005-10-02 22:57:53.000000000 -0400
@@ -0,0 +1,47 @@
+#include <linux/config.h>
+#include <asm/unistd.h>
+#include <linux/mman.h>
+#include <linux/ptrace.h>
+#include "stub-data.h"
+
+static int errno;
+
+static inline _syscall2(int,clone,unsigned long,flags,unsigned long,newsp)
+static inline _syscall4(long,ptrace,long,request,
+			pid_t,pid,void *,addr,void *,data);
+static inline _syscall3(int,setitimer,int,which, const struct itimerval *,value,
+			struct itimerval *,ovalue);
+static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
+
+static inline void trap_myself(void)
+{
+	__asm("int3");
+}
+
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_clone_handler(void)
+{
+	long err;
+	struct stub_data *from = (struct stub_data *) CONFIG_STUB_DATA;
+
+	err = clone(CLONE_PARENT | CLONE_FILES | SIGCHLD,
+		    CONFIG_STUB_DATA + PAGE_SIZE / 2 - sizeof(void *));
+	if (err)
+		goto out;
+
+	err = ptrace(PTRACE_TRACEME, 0, NULL, NULL);
+	if (err)
+		goto out;
+
+	err = setitimer(ITIMER_VIRTUAL, &from->timer, NULL);
+	if (err)
+		goto out;
+
+	err = (long)mmap((void *)CONFIG_STUB_DATA, PAGE_SIZE,
+			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
+			    from->fd, from->offset);
+out:
+	/* save current result. Parent: pid; child: retcode of mmap */
+	from->err = err == -1 ? errno : err;
+	trap_myself();
+}


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
