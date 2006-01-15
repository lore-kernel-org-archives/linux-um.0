Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyEmh-0005U9-LT for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:31 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EyEmh-0000TX-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:31 -0800
Message-Id: <200601152139.k0FLdWvO027705@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/11] UML - Move LDT creation
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
Date: Sun, 15 Jan 2006 16:39:32 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

s390 doesn't have a LDT. So MM_COPY_SEGMENTS will not be
supported on s390.
The only user of MM_COPY_SEGMENTS is new_mm(), but that's
no longer useful, as arch/sys-i386/ldt.c defines init_new_ldt(),
which is called immediately after new_mm().
So we should copy host's LDT in init_new_ldt(), if /proc/mm is
available, to have this subarch specific call in subarch code.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/include/skas.h	2006-01-05 16:19:59.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/include/skas.h	2006-01-05 21:26:43.000000000 -0500
@@ -33,7 +33,7 @@ extern int protect(struct mm_id * mm_idp
 		   unsigned long len, int r, int w, int x, int done,
 		   void **data);
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
-extern int new_mm(int from, unsigned long stack);
+extern int new_mm(unsigned long stack);
 extern int start_userspace(unsigned long stub_stack);
 extern int copy_context_skas0(unsigned long stack, int pid);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
Index: linux-2.6.15/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/mmu.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/mmu.c	2006-01-05 21:26:43.000000000 -0500
@@ -78,7 +78,7 @@ int init_new_context_skas(struct task_st
  	struct mmu_context_skas *from_mm = NULL;
 	struct mmu_context_skas *to_mm = &mm->context.skas;
 	unsigned long stack = 0;
-	int from_fd, ret = -ENOMEM;
+	int ret = -ENOMEM;
 
 	if(skas_needs_stub){
 		stack = get_zeroed_page(GFP_KERNEL);
@@ -108,11 +108,7 @@ int init_new_context_skas(struct task_st
 		from_mm = &current->mm->context.skas;
 
 	if(proc_mm){
-		if(from_mm)
-			from_fd = from_mm->id.u.mm_fd;
-		else from_fd = -1;
-
-		ret = new_mm(from_fd, stack);
+		ret = new_mm(stack);
 		if(ret < 0){
 			printk("init_new_context_skas - new_mm failed, "
 			       "errno = %d\n", ret);
Index: linux-2.6.15/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/process_kern.c	2006-01-05 16:19:59.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/process_kern.c	2006-01-05 21:26:43.000000000 -0500
@@ -20,7 +20,6 @@
 #include "tlb.h"
 #include "kern.h"
 #include "mode.h"
-#include "proc_mm.h"
 #include "registers.h"
 
 void switch_to_skas(void *prev, void *next)
@@ -125,25 +124,14 @@ int copy_thread_skas(int nr, unsigned lo
 
 extern void map_stub_pages(int fd, unsigned long code,
 			   unsigned long data, unsigned long stack);
-int new_mm(int from, unsigned long stack)
+int new_mm(unsigned long stack)
 {
-	struct proc_mm_op copy;
-	int n, fd;
+	int fd;
 
 	fd = os_open_file("/proc/mm", of_cloexec(of_write(OPENFLAGS())), 0);
 	if(fd < 0)
 		return(fd);
 
-	if(from != -1){
-		copy = ((struct proc_mm_op) { .op 	= MM_COPY_SEGMENTS,
-					      .u 	=
-					      { .copy_segments	= from } } );
-		n = os_write_file(fd, &copy, sizeof(copy));
-		if(n != sizeof(copy))
-			printk("new_mm : /proc/mm copy_segments failed, "
-			       "err = %d\n", -n);
-	}
-
 	if(skas_needs_stub)
 		map_stub_pages(fd, CONFIG_STUB_CODE, CONFIG_STUB_DATA, stack);
 
Index: linux-2.6.15/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-i386/ldt.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/sys-i386/ldt.c	2006-01-05 21:26:43.000000000 -0500
@@ -16,6 +16,8 @@
 #include "choose-mode.h"
 #include "kern.h"
 #include "mode_kern.h"
+#include "proc_mm.h"
+#include "os.h"
 
 extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
 
@@ -456,13 +458,14 @@ long init_new_ldt(struct mmu_context_ska
 	int i;
 	long page, err=0;
 	void *addr = NULL;
+	struct proc_mm_op copy;
 
-	memset(&desc, 0, sizeof(desc));
 
 	if(!ptrace_ldt)
 		init_MUTEX(&new_mm->ldt.semaphore);
 
 	if(!from_mm){
+		memset(&desc, 0, sizeof(desc));
 		/*
 		 * We have to initialize a clean ldt.
 		 */
@@ -494,8 +497,26 @@ long init_new_ldt(struct mmu_context_ska
 			}
 		}
 		new_mm->ldt.entry_count = 0;
+
+		goto out;
 	}
-	else if (!ptrace_ldt) {
+
+	if(proc_mm){
+		/* We have a valid from_mm, so we now have to copy the LDT of
+		 * from_mm to new_mm, because using proc_mm an new mm with
+		 * an empty/default LDT was created in new_mm()
+		 */
+		copy = ((struct proc_mm_op) { .op 	= MM_COPY_SEGMENTS,
+					      .u 	=
+					      { .copy_segments =
+							from_mm->id.u.mm_fd } } );
+		i = os_write_file(new_mm->id.u.mm_fd, &copy, sizeof(copy));
+		if(i != sizeof(copy))
+			printk("new_mm : /proc/mm copy_segments failed, "
+			       "err = %d\n", -i);
+	}
+
+	if(!ptrace_ldt) {
 		/* Our local LDT is used to supply the data for
 		 * modify_ldt(READLDT), if PTRACE_LDT isn't available,
 		 * i.e., we have to use the stub for modify_ldt, which
@@ -524,6 +545,7 @@ long init_new_ldt(struct mmu_context_ska
 		up(&from_mm->ldt.semaphore);
 	}
 
+    out:
 	return err;
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
