Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Wed, 23 Jan 2008 12:12:30 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080123171230.GA7634@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [SPAM] [uml-devel] [RFC PATCH 9/10] SKAS4 - rename new_mm
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
To: UML-user <user-mode-linux-user@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

UML already had a new_mm().  This is renamed to make_new_mm().

diff --git a/arch/um/include/skas/skas.h b/arch/um/include/skas/skas.h
index d6cbb4f..061a362 100644
--- a/arch/um/include/skas/skas.h
+++ b/arch/um/include/skas/skas.h
@@ -17,7 +17,7 @@ extern int skas_needs_stub;
 extern int user_thread(unsigned long stack, int flags);
 extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
-extern int new_mm(unsigned long stack);
+extern int make_new_mm(unsigned long stack);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index f859ec3..3426711 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -101,7 +101,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		from_mm = &current->mm->context;
 
 	if (proc_mm) {
-		ret = new_mm(stack);
+		ret = make_new_mm(stack);
 		if (ret < 0) {
 			printk(KERN_ERR "init_new_context_skas - "
 			       "new_mm failed, errno = %d\n", ret);
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index fce389c..2c6de0a 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -9,7 +9,7 @@
 #include "os.h"
 #include "skas.h"
 
-int new_mm(unsigned long stack)
+int make_new_mm(unsigned long stack)
 {
 	int fd;
 
diff --git a/arch/um/sys-i386/ldt.c b/arch/um/sys-i386/ldt.c
index 67c0958..c06c66c 100644
--- a/arch/um/sys-i386/ldt.c
+++ b/arch/um/sys-i386/ldt.c
@@ -436,7 +436,7 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 		/*
 		 * We have a valid from_mm, so we now have to copy the LDT of
 		 * from_mm to new_mm, because using proc_mm an new mm with
-		 * an empty/default LDT was created in new_mm()
+		 * an empty/default LDT was created in make_new_mm()
 		 */
 		copy = ((struct proc_mm_op) { .op 	= MM_COPY_SEGMENTS,
 					      .u 	=

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
