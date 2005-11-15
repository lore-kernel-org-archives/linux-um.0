Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcAFr-0004OY-2l for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 15:30:23 -0800
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcAFp-0006VB-NP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 15:30:23 -0800
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAFNU8qk011206
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Nov 2005 18:30:08 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id
	jAFNVO0i057480 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Nov 2005 16:31:24 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	jAFNU81X013462 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Nov 2005 16:30:08 -0700
Received: from localhost (dyn9047021085.beaverton.ibm.com [9.47.21.85])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	jAFNU82u013458 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Nov 2005 16:30:08 -0700
Message-ID: <20051115233006.GA31279@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: linuxram@us.ibm.com (Ram Pai)
Subject: [uml-devel] [RFC PATCH] fixes for some compilation errors
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
Date: Tue, 15 Nov 2005 15:30:06 -0800
To: user-mode-linux-devel@lists.sourceforge.net

The patches in the patch tarball at
http://user-mode-linux.sf.net/patches.html  for 2.6.15-rc1 kernel do not
apply cleanly.  Its the last patch constant-page-size which has the
issue.  There were some compilation issues too in

arch/um/include/tt/mode_kern_tt.h
arch/um/sys-i386/stub_segv.c
arch/um/kernel/skas/clone.c
arch/um/kernel/tt/process_kern.c

The following patch fixes them, but I am not sure if they are correct
Please check,
RP


 arch/um/include/tt/mode_kern_tt.h |    2 +-
 arch/um/kernel/skas/clone.c       |   12 +++++++-----
 arch/um/sys-i386/stub_segv.c      |    2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

Index: 2.6.15-rc1/arch/um/include/tt/mode_kern_tt.h
===================================================================
--- 2.6.15-rc1.orig/arch/um/include/tt/mode_kern_tt.h
+++ 2.6.15-rc1/arch/um/include/tt/mode_kern_tt.h
@@ -9,11 +9,11 @@
 #include "linux/sched.h"
 #include "asm/page.h"
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
 
-extern void *switch_to_tt(void *prev, void *next);
+extern void switch_to_tt(void *prev, void *next);
 extern void flush_thread_tt(void);
 extern void start_thread_tt(struct pt_regs *regs, unsigned long eip,
 			   unsigned long esp);
 extern int copy_thread_tt(int nr, unsigned long clone_flags, unsigned long sp,
 			  unsigned long stack_top, struct task_struct *p,
Index: 2.6.15-rc1/arch/um/sys-i386/stub_segv.c
===================================================================
--- 2.6.15-rc1.orig/arch/um/sys-i386/stub_segv.c
+++ 2.6.15-rc1/arch/um/sys-i386/stub_segv.c
@@ -2,11 +2,11 @@
  * Copyright (C) 2004 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
  */
 
 #include <sys/select.h> /* The only way I can see to get sigset_t */
-#include <asm/signal.h>
+//#include <asm/signal.h>
 #include <asm/unistd.h>
 #include "uml-config.h"
 #include "sysdep/stub.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
Index: 2.6.15-rc1/arch/um/kernel/skas/clone.c
===================================================================
--- 2.6.15-rc1.orig/arch/um/kernel/skas/clone.c
+++ 2.6.15-rc1/arch/um/kernel/skas/clone.c
@@ -7,10 +7,11 @@
 #include "ptrace_user.h"
 #include "skas.h"
 #include "stub-data.h"
 #include "uml-config.h"
 #include "sysdep/stub.h"
+#include "kern_constants.h"
 
 /* This is in a separate file because it needs to be compiled with any
  * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
  */
 
@@ -18,29 +19,30 @@
 
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
 	long err;
+        struct stub_data *from = (struct stub_data *) UML_CONFIG_STUB_DATA;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    UML_CONFIG_STUB_DATA + PAGE_SIZE / 2 -
+			    UML_CONFIG_STUB_DATA + UM_KERN_PAGE_SIZE / 2 -
 			    sizeof(void *));
 	if(err != 0)
 		goto out;
 
 	err = stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
 	if(err)
 		goto out;
 
 	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
-			    (long) STUB_DATA(timer), 0);
+			    (long) &from->timer, 0);
 	if(err)
 		goto out;
 
-	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, PAGE_SIZE,
-			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
-			    STUB_DATA(fd), STUB_DATA(offset));
+	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA,
+			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+			    MAP_FIXED | MAP_SHARED, from->fd, from->offset);
  out:
 	/* save current result. Parent: pid; child: retcode of mmap */
 	STUB_DATA(err) = err;
 	trap_myself();
 }




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
