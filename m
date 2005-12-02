Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhxrF-0007qD-GD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 15:28:57 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ehxr8-0006n3-U2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 15:28:56 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20051202001358.GA12204@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Stop the insanity
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
Date: Thu, 1 Dec 2005 19:13:58 -0500
To: William Stearns <wstearns@pobox.com>, Blaisorblade <blaisorblade@yahoo.it>, Kai Tan <mineown@hotmail.com>, Rob Landley <rob@landley.net>, David Lang <dlang@invendra.net>, Antoine Martin <antoine@nagafix.co.uk>, Joel Palmius <joel.palmius@miun.se>, Mihai Rusu <dizzy@roedu.net>, Michael Richardson <mcr@sandelman.ottawa.on.ca>, Jason Lunz <lunz@falooley.org>, Benjamin LaHaise <bcrl@kvack.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

I'm sending this mail out to everyone that I can find who has had the UML
stubs compiled in unexpected ways, resulting in crashing.

I'd like testing of the patch below on as many gcc versions as possible.  I
think this patch avoids the fundamental issue which is behind this, namely
gcc using the stack when we have just replaced it, behind gcc's back.  The 
remapping and storage of the return value is hidden in a blob of asm, hopefully
giving gcc no room for creativity.

The patch changes both i386 and x86_64 and I'd appreciate testing on both
architectures.  It's against -rc3, but should go cleanly against -rc4 as well.

Please report back both successes and failures.

				Jeff

Index: linux-2.6.15/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/sysdep-i386/stub.h	2005-11-29 18:45:43.000000000 -0500
+++ linux-2.6.15/arch/um/include/sysdep-i386/stub.h	2005-12-01 15:04:56.000000000 -0500
@@ -6,8 +6,12 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
+#include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
+#include "stub-data.h"
+#include "kern_constants.h"
+#include "uml-config.h"
 
 extern void stub_segv_handler(int sig);
 extern void stub_clone_handler(void);
@@ -76,23 +80,22 @@ static inline long stub_syscall5(long sy
 	return ret;
 }
 
-static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5, long arg6)
+static inline void trap_myself(void)
 {
-	long ret;
-
-	__asm__ volatile ("push %%ebp ; movl %%eax,%%ebp ; movl %1,%%eax ; "
-			"int $0x80 ; pop %%ebp"
-			: "=a" (ret)
-			: "g" (syscall), "b" (arg1), "c" (arg2), "d" (arg3),
-			  "S" (arg4), "D" (arg5), "0" (arg6));
-
-	return ret;
+	__asm("int3");
 }
 
-static inline void trap_myself(void)
+static inline void remap_stack(int fd, unsigned long offset)
 {
-	__asm("int3");
+	__asm__ volatile ("movl %%eax,%%ebp ; movl %0,%%eax ; int $0x80 ;"
+			  "movl %7, %%ebx ; movl %%eax, (%%ebx)"
+			  : : "g" (STUB_MMAP_NR), "b" (UML_CONFIG_STUB_DATA), 
+			    "c" (UM_KERN_PAGE_SIZE), 
+			    "d" (PROT_READ | PROT_WRITE),
+			    "S" (MAP_FIXED | MAP_SHARED), "D" (fd), 
+			    "a" (offset), 
+			    "i" (&((struct stub_data *) UML_CONFIG_STUB_DATA)->err) 
+			  : "memory");
 }
 
 #endif
Index: linux-2.6.15/arch/um/include/sysdep-x86_64/stub.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/sysdep-x86_64/stub.h	2005-11-29 18:45:43.000000000 -0500
+++ linux-2.6.15/arch/um/include/sysdep-x86_64/stub.h	2005-12-01 16:15:28.000000000 -0500
@@ -6,8 +6,12 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
+#include <sys/mman.h>
 #include <asm/unistd.h>
 #include <sysdep/ptrace_user.h>
+#include "stub-data.h"
+#include "kern_constants.h"
+#include "uml-config.h"
 
 extern void stub_segv_handler(int sig);
 extern void stub_clone_handler(void);
@@ -81,23 +85,23 @@ static inline long stub_syscall5(long sy
 	return ret;
 }
 
-static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5, long arg6)
+static inline void trap_myself(void)
 {
-	long ret;
-
-	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; "
-		"movq %7, %%r9; " __syscall : "=a" (ret)
-		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
-		  "g" (arg4), "g" (arg5), "g" (arg6)
-		: __syscall_clobber, "r10", "r8", "r9" );
-
-	return ret;
+	__asm("int3");
 }
 
-static inline void trap_myself(void)
+static inline void remap_stack(long fd, unsigned long offset)
 {
-	__asm("int3");
+	__asm__ volatile ("movq %4,%%r10 ; movq %5,%%r8 ; "
+			  "movq %6, %%r9; " __syscall "; movq %7, %%rbx ; "
+			  "movq %%rax, (%%rbx)": 
+			  : "a" (STUB_MMAP_NR), "D" (UML_CONFIG_STUB_DATA), 
+			    "S" (UM_KERN_PAGE_SIZE), 
+			    "d" (PROT_READ | PROT_WRITE), 
+                            "g" (MAP_FIXED | MAP_SHARED), "g" (fd), 
+			    "g" (offset),
+			    "i" (&((struct stub_data *) UML_CONFIG_STUB_DATA)->err)
+			  : __syscall_clobber, "r10", "r8", "r9" );
 }
 
 #endif
Index: linux-2.6.15/arch/um/kernel/skas/clone.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/clone.c	2005-12-01 11:49:12.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/clone.c	2005-12-01 13:52:10.000000000 -0500
@@ -18,11 +18,10 @@
  * on some systems.
  */
 
-#define STUB_DATA(field) (((struct stub_data *) UML_CONFIG_STUB_DATA)->field)
-
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
+	struct stub_data *data = (struct stub_data *) UML_CONFIG_STUB_DATA;
 	long err;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
@@ -35,17 +34,21 @@ stub_clone_handler(void)
 	if(err)
 		goto out;
 
-	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
-			    (long) &STUB_DATA(timer), 0);
+	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL, 
+			    (long) &data->timer, 0);
 	if(err)
 		goto out;
 
-	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA,
-			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
-			    MAP_FIXED | MAP_SHARED, STUB_DATA(fd),
-			    STUB_DATA(offset));
+	remap_stack(data->fd, data->offset);
+	goto done;
+
  out:
-	/* save current result. Parent: pid; child: retcode of mmap */
-	STUB_DATA(err) = err;
+	/* save current result. 
+	 * Parent: pid; 
+	 * child: retcode of mmap already saved and it jumps around this 
+	 * assignment
+	 */
+	data->err = err;
+ done:
 	trap_myself();
 }


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
