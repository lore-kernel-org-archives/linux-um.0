Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWQdG-0007UB-4a	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:50 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EWQdF-0003O4-Jx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:50 -0800
Message-Id: <200510310439.j9V4dZ10000851@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/10] UML - Separate libc-dependent uaccess code
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
Date: Sun, 30 Oct 2005 23:39:35 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Gennady.V.Sharapov@intel.com

From: Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from uaccess_user.c file under os-Linux dir

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.14/arch/um/include/os.h
===================================================================
--- linux-2.6.14.orig/arch/um/include/os.h	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/include/os.h	2005-10-30 19:08:40.000000000 -0500
@@ -199,6 +199,12 @@ extern void forward_pending_sigio(int ta
 extern int start_fork_tramp(void *arg, unsigned long temp_stack,
 			    int clone_flags, int (*tramp)(void *));
 
+/* uaccess.c */
+extern unsigned long __do_user_copy(void *to, const void *from, int n,
+				    void **fault_addr, void **fault_catcher,
+				    void (*op)(void *to, const void *from,
+					       int n), int *faulted_out);
+
 #endif
 
 /*
Index: linux-2.6.14/arch/um/include/uml_uaccess.h
===================================================================
--- linux-2.6.14.orig/arch/um/include/uml_uaccess.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.14/arch/um/include/uml_uaccess.h	2005-10-30 19:08:40.000000000 -0500
@@ -8,10 +8,6 @@
 
 extern int __do_copy_to_user(void *to, const void *from, int n,
 			     void **fault_addr, void **fault_catcher);
-extern unsigned long __do_user_copy(void *to, const void *from, int n,
-				    void **fault_addr, void **fault_catcher,
-				    void (*op)(void *to, const void *from,
-					       int n), int *faulted_out);
 void __do_copy(void *to, const void *from, int n);
 
 #endif
Index: linux-2.6.14/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/Makefile	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/kernel/Makefile	2005-10-30 19:15:00.000000000 -0500
@@ -10,7 +10,7 @@ obj-y = config.o exec_kern.o exitcode.o 
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o physmem.o \
 	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
 	signal_kern.o signal_user.o smp.o syscall_kern.o sysrq.o time.o \
-	time_kern.o tlb.o trap_kern.o trap_user.o uaccess_user.o um_arch.o \
+	time_kern.o tlb.o trap_kern.o trap_user.o uaccess.o um_arch.o \
 	umid.o user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
Index: linux-2.6.14/arch/um/kernel/tt/uaccess_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/tt/uaccess_user.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/kernel/tt/uaccess_user.c	2005-10-30 19:08:40.000000000 -0500
@@ -10,6 +10,7 @@
 #include "uml_uaccess.h"
 #include "task.h"
 #include "kern_util.h"
+#include "os.h"
 
 int __do_copy_from_user(void *to, const void *from, int n,
 			void **fault_addr, void **fault_catcher)
Index: linux-2.6.14/arch/um/kernel/uaccess.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/uaccess.c	2005-10-28 06:47:18.772411750 -0400
+++ linux-2.6.14/arch/um/kernel/uaccess.c	2005-10-30 19:08:40.000000000 -0500
@@ -0,0 +1,30 @@
+/* 
+ * Copyright (C) 2001 Chris Emerson (cemerson@chiark.greenend.org.uk)
+ * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+/* These are here rather than tt/uaccess.c because skas mode needs them in
+ * order to do SIGBUS recovery when a tmpfs mount runs out of room.
+ */
+
+#include <linux/string.h>
+#include "os.h"
+
+void __do_copy(void *to, const void *from, int n)
+{
+	memcpy(to, from, n);
+}	
+
+
+int __do_copy_to_user(void *to, const void *from, int n,
+		      void **fault_addr, void **fault_catcher)
+{
+	unsigned long fault;
+	int faulted;
+
+	fault = __do_user_copy(to, from, n, fault_addr, fault_catcher,
+			       __do_copy, &faulted);
+	if(!faulted) return(0);
+	else return(n - (fault - (unsigned long) to));
+}
Index: linux-2.6.14/arch/um/kernel/uaccess_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/uaccess_user.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.14/arch/um/kernel/uaccess_user.c	2005-10-28 06:47:18.772411750 -0400
@@ -1,64 +0,0 @@
-/* 
- * Copyright (C) 2001 Chris Emerson (cemerson@chiark.greenend.org.uk)
- * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <setjmp.h>
-#include <string.h>
-
-/* These are here rather than tt/uaccess.c because skas mode needs them in
- * order to do SIGBUS recovery when a tmpfs mount runs out of room.
- */
-
-unsigned long __do_user_copy(void *to, const void *from, int n,
-			     void **fault_addr, void **fault_catcher,
-			     void (*op)(void *to, const void *from,
-					int n), int *faulted_out)
-{
-	unsigned long *faddrp = (unsigned long *) fault_addr, ret;
-
-	sigjmp_buf jbuf;
-	*fault_catcher = &jbuf;
-	if(sigsetjmp(jbuf, 1) == 0){
-		(*op)(to, from, n);
-		ret = 0;
-		*faulted_out = 0;
-	} 
-	else {
-		ret = *faddrp;
-		*faulted_out = 1;
-	}
-	*fault_addr = NULL;
-	*fault_catcher = NULL;
-	return ret;
-}
-
-void __do_copy(void *to, const void *from, int n)
-{
-	memcpy(to, from, n);
-}	
-
-
-int __do_copy_to_user(void *to, const void *from, int n,
-		      void **fault_addr, void **fault_catcher)
-{
-	unsigned long fault;
-	int faulted;
-
-	fault = __do_user_copy(to, from, n, fault_addr, fault_catcher,
-			       __do_copy, &faulted);
-	if(!faulted) return(0);
-	else return(n - (fault - (unsigned long) to));
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.14/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/os-Linux/Makefile	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/os-Linux/Makefile	2005-10-30 19:15:37.000000000 -0500
@@ -4,10 +4,10 @@
 #
 
 obj-y = aio.o elf_aux.o file.o mem.o process.o signal.o start_up.o time.o \
-	tt.o tty.o user_syms.o drivers/ sys-$(SUBARCH)/
+	tt.o tty.o uaccess.o user_syms.o drivers/ sys-$(SUBARCH)/
 
 USER_OBJS := aio.o elf_aux.o file.o mem.o process.o signal.o start_up.o \
-	time.o tt.o tty.o
+	time.o tt.o tty.o uaccess.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
 CFLAGS_elf_aux.o += -I$(objtree)/arch/um
Index: linux-2.6.14/arch/um/os-Linux/uaccess.c
===================================================================
--- linux-2.6.14.orig/arch/um/os-Linux/uaccess.c	2005-10-28 06:47:18.772411750 -0400
+++ linux-2.6.14/arch/um/os-Linux/uaccess.c	2005-10-30 19:08:40.000000000 -0500
@@ -0,0 +1,32 @@
+/* 
+ * Copyright (C) 2001 Chris Emerson (cemerson@chiark.greenend.org.uk)
+ * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <setjmp.h>
+#include <string.h>
+
+unsigned long __do_user_copy(void *to, const void *from, int n,
+			     void **fault_addr, void **fault_catcher,
+			     void (*op)(void *to, const void *from,
+					int n), int *faulted_out)
+{
+	unsigned long *faddrp = (unsigned long *) fault_addr, ret;
+
+	sigjmp_buf jbuf;
+	*fault_catcher = &jbuf;
+	if(sigsetjmp(jbuf, 1) == 0){
+		(*op)(to, from, n);
+		ret = 0;
+		*faulted_out = 0;
+	} 
+	else {
+		ret = *faddrp;
+		*faulted_out = 1;
+	}
+	*fault_addr = NULL;
+	*fault_catcher = NULL;
+	return ret;
+}
+



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
