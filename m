Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJd2Z-0002mj-24 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 12:51:47 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DJd2W-00023W-Og for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 12:51:47 -0700
Message-ID: <42558F3C.1000303@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050505070400080405070704"
Subject: [uml-devel] Additional patch to split out subarch specific code
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
Date: Thu, 07 Apr 2005 21:51:24 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050505070400080405070704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

here is the next patch for UML/s390 preparation.
If new_mm() has a vaild from_fd, it copies the LDT of
from_mm to new_mm using MM_COPY_SEGMENTS.
IMHO, this is arch specific.
So I shifted it to init_new_ldt() in ldt.c. I did this
for i386 only, because x86_64 doesn't have an ldt.c (yet?)
The patch applies on top of the latest LDT fixes/improvements
that AFAIK already are merged in your tree.

	Bodo


--------------050505070400080405070704
Content-Type: text/x-diff;
 name="shift-MM_COPY_SEGMENTS.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shift-MM_COPY_SEGMENTS.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

s390 doesn't have a LDT. So MM_COPY_SEGMENTS will not be
supported on s390.
The only user of MM_COPY_SEGMENTS is new_mm(), but that's
no longer useful, as arch/sys-i386/ldt.c defines init_new_ldt(),
which is called immediately after new_mm().
So we should copy host's LDT in init_new_ldt(), if /proc/mm is
available, to have this subarch specific call in subarch code.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/kernel/skas/include/skas.h~shift-MM_COPY_SEGMENTS arch/um/kernel/skas/include/skas.h
--- linux-2.6.11/arch/um/kernel/skas/include/skas.h~shift-MM_COPY_SEGMENTS	2005-04-07 21:28:29.468697914 +0200
+++ linux-2.6.11-root/arch/um/kernel/skas/include/skas.h	2005-04-07 21:28:29.479697320 +0200
@@ -41,7 +41,7 @@ extern int protect(struct mm_id * mm_idp
                    unsigned long len, int r, int w, int x, int done, 
                    void **data);
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
-extern int new_mm(int from, unsigned long stack);
+extern int new_mm(unsigned long stack);
 extern int start_userspace(unsigned long stub_stack);
 extern int copy_context_skas0(unsigned long stack, int pid);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
diff -puN arch/um/kernel/skas/process_kern.c~shift-MM_COPY_SEGMENTS arch/um/kernel/skas/process_kern.c
--- linux-2.6.11/arch/um/kernel/skas/process_kern.c~shift-MM_COPY_SEGMENTS	2005-04-07 21:28:29.470697806 +0200
+++ linux-2.6.11-root/arch/um/kernel/skas/process_kern.c	2005-04-07 21:28:29.480697266 +0200
@@ -21,7 +21,6 @@
 #include "tlb.h"
 #include "kern.h"
 #include "mode.h"
-#include "proc_mm.h"
 #include "registers.h"
 
 void *switch_to_skas(void *prev, void *next)
@@ -131,25 +130,14 @@ int copy_thread_skas(int nr, unsigned lo
 
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
 
diff -puN arch/um/sys-i386/ldt.c~shift-MM_COPY_SEGMENTS arch/um/sys-i386/ldt.c
--- linux-2.6.11/arch/um/sys-i386/ldt.c~shift-MM_COPY_SEGMENTS	2005-04-07 21:28:29.473697644 +0200
+++ linux-2.6.11-root/arch/um/sys-i386/ldt.c	2005-04-07 21:32:35.490129841 +0200
@@ -11,6 +11,8 @@
 #include "asm/unistd.h"
 #include "choose-mode.h"
 #include "kern.h"
+#include "proc_mm.h"
+#include "os.h"
 
 #ifdef CONFIG_MODE_TT
 extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
@@ -388,13 +390,14 @@ long init_new_ldt(struct mmu_context_ska
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
@@ -426,8 +429,26 @@ long init_new_ldt(struct mmu_context_ska
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
+							from_mm->u.mm_fd } } );
+		i = os_write_file(new_mm->u.mm_fd, &copy, sizeof(copy));
+		if(i != sizeof(copy))
+			printk("new_mm : /proc/mm copy_segments failed, "
+			       "err = %d\n", -i);
+	}
+
+	if(!ptrace_ldt) {
 		/* Our local LDT is used to supply the data for
 		 * modify_ldt(READLDT), if PTRACE_LDT isn't available,
 		 * i.e., we have to use the stub for modify_ldt, which
@@ -455,6 +476,7 @@ long init_new_ldt(struct mmu_context_ska
 		up(&from_mm->ldt.semaphore);
 	}
 
+    out:
 	return err;
 }
 
diff -puN arch/um/kernel/skas/mmu.c~shift-MM_COPY_SEGMENTS arch/um/kernel/skas/mmu.c
--- linux-2.6.11/arch/um/kernel/skas/mmu.c~shift-MM_COPY_SEGMENTS	2005-04-07 21:28:29.475697536 +0200
+++ linux-2.6.11-root/arch/um/kernel/skas/mmu.c	2005-04-07 21:28:29.487696888 +0200
@@ -54,7 +54,7 @@ static int init_stub_pte(struct mm_struc
 
 int init_new_context_skas(struct task_struct *task, struct mm_struct *mm)
 {
-	int from_fd, ret = -ENOMEM;
+	int ret = -ENOMEM;
  	unsigned long stack = 0;
 	struct mmu_context_skas * from_mm = NULL;
 	struct mmu_context_skas * to_mm = &mm->context.skas;
@@ -74,11 +74,7 @@ int init_new_context_skas(struct task_st
 		from_mm = &current->mm->context.skas;
 
 	if(proc_mm){
-		if(from_mm)
-			from_fd = from_mm->u.mm_fd;
-		else from_fd = -1;
-  
-		ret = new_mm(from_fd, stack);
+		ret = new_mm(stack);
 		if(ret < 0){
 			printk("init_new_context_skas - new_mm failed, "
 			       "errno = %d\n", ret);
_

--------------050505070400080405070704--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
