Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HZFzU-0004Lh-VY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Apr 2007 17:38:17 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HZFzT-00039u-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Apr 2007 17:38:16 -0700
Date: Wed, 4 Apr 2007 20:34:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070405003401.GA13270@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 1/4] UML - Tidy fault code
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Tidying in preparation for the segfault register dumping patch which
follows.

void * pointers are changed to union uml_pt_regs *.  This makes
the types match reality, except in arch_fixup, which is changed to
operate on a union uml_pt_regs.  This fixes a bug in the call from
segv_handler, which passes a union uml_pt_regs, to segv, which expects
to pass a struct sigcontext to arch_fixup.

Whitespace and other style fixes.

There's also a errno printk fix.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/arch.h       |    2 +-
 arch/um/include/kern_util.h  |    2 +-
 arch/um/kernel/trap.c        |   35 ++++++++++++++++++-----------------
 arch/um/os-Linux/skas/trap.c |   17 ++++++++---------
 arch/um/sys-i386/fault.c     |   18 ++----------------
 arch/um/sys-i386/signal.c    |   41 +++++++++++++++--------------------------
 arch/um/sys-x86_64/fault.c   |   30 +++++++++++++++++-------------
 arch/um/sys-x86_64/signal.c  |    2 +-
 8 files changed, 63 insertions(+), 84 deletions(-)

Index: linux-2.6.21-mm/arch/um/include/arch.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/arch.h	2007-04-02 12:18:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/arch.h	2007-04-02 12:19:04.000000000 -0400
@@ -9,7 +9,7 @@
 #include "sysdep/ptrace.h"
 
 extern void arch_check_bugs(void);
-extern int arch_fixup(unsigned long address, void *sc_ptr);
+extern int arch_fixup(unsigned long address, union uml_pt_regs *regs);
 extern int arch_handle_signal(int sig, union uml_pt_regs *regs);
 
 #endif
Index: linux-2.6.21-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/kern_util.h	2007-04-02 12:19:01.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/kern_util.h	2007-04-02 12:19:04.000000000 -0400
@@ -43,7 +43,7 @@ extern unsigned long alloc_stack(int ord
 extern int do_signal(void);
 extern int is_stack_fault(unsigned long sp);
 extern unsigned long segv(struct faultinfo fi, unsigned long ip,
-			  int is_user, void *sc);
+			  int is_user, union uml_pt_regs *regs);
 extern int handle_page_fault(unsigned long address, unsigned long ip,
 			     int is_write, int is_user, int *code_out);
 extern void syscall_ready(void);
Index: linux-2.6.21-mm/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/trap.c	2007-04-02 12:18:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/trap.c	2007-04-02 12:19:04.000000000 -0400
@@ -72,8 +72,8 @@ good_area:
 		goto out;
 
 	/* Don't require VM_READ|VM_EXEC for write faults! */
-        if(!is_write && !(vma->vm_flags & (VM_READ | VM_EXEC)))
-                goto out;
+	if(!is_write && !(vma->vm_flags & (VM_READ | VM_EXEC)))
+		goto out;
 
 	do {
 survive:
@@ -157,18 +157,19 @@ static void segv_handler(int sig, union 
  * the info in the regs. A pointer to the info then would
  * give us bad data!
  */
-unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user, void *sc)
+unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
+		   union uml_pt_regs *regs)
 {
 	struct siginfo si;
 	void *catcher;
 	int err;
-        int is_write = FAULT_WRITE(fi);
-        unsigned long address = FAULT_ADDRESS(fi);
+	int is_write = FAULT_WRITE(fi);
+	unsigned long address = FAULT_ADDRESS(fi);
 
-        if(!is_user && (address >= start_vm) && (address < end_vm)){
-                flush_tlb_kernel_vm();
-                return(0);
-        }
+	if(!is_user && (address >= start_vm) && (address < end_vm)){
+		flush_tlb_kernel_vm();
+		return 0;
+	}
 	else if(current->mm == NULL)
 		panic("Segfault with no mm");
 
@@ -183,17 +184,17 @@ unsigned long segv(struct faultinfo fi, 
 
 	catcher = current->thread.fault_catcher;
 	if(!err)
-		return(0);
+		return 0;
 	else if(catcher != NULL){
 		current->thread.fault_addr = (void *) address;
 		do_longjmp(catcher, 1);
 	}
 	else if(current->thread.fault_addr != NULL)
 		panic("fault_addr set but no fault catcher");
-        else if(!is_user && arch_fixup(ip, sc))
-		return(0);
+	else if(!is_user && arch_fixup(ip, regs))
+		return 0;
 
- 	if(!is_user)
+	if(!is_user)
 		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
 		      address, ip);
 
@@ -202,7 +203,7 @@ unsigned long segv(struct faultinfo fi, 
 		si.si_errno = 0;
 		si.si_code = BUS_ADRERR;
 		si.si_addr = (void __user *)address;
-                current->thread.arch.faultinfo = fi;
+		current->thread.arch.faultinfo = fi;
 		force_sig_info(SIGBUS, &si, current);
 	} else if (err == -ENOMEM) {
 		printk("VM: killing process %s\n", current->comm);
@@ -211,10 +212,10 @@ unsigned long segv(struct faultinfo fi, 
 		BUG_ON(err != -EFAULT);
 		si.si_signo = SIGSEGV;
 		si.si_addr = (void __user *) address;
-                current->thread.arch.faultinfo = fi;
+		current->thread.arch.faultinfo = fi;
 		force_sig_info(SIGSEGV, &si, current);
 	}
-	return(0);
+	return 0;
 }
 
 void relay_signal(int sig, union uml_pt_regs *regs)
@@ -229,7 +230,7 @@ void relay_signal(int sig, union uml_pt_
 		panic("Kernel mode signal %d", sig);
 	}
 
-        current->thread.arch.faultinfo = *UPT_FAULTINFO(regs);
+	current->thread.arch.faultinfo = *UPT_FAULTINFO(regs);
 	force_sig(sig, current);
 }
 
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/trap.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/trap.c	2007-04-02 12:18:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/trap.c	2007-04-02 12:19:04.000000000 -0400
@@ -18,10 +18,9 @@
 void sig_handler_common_skas(int sig, void *sc_ptr)
 {
 	struct sigcontext *sc = sc_ptr;
-	struct skas_regs *r;
+	union uml_pt_regs *r;
 	void (*handler)(int, union uml_pt_regs *);
-	int save_errno = errno;
-	int save_user;
+	int save_user, save_errno = errno;
 
 	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
 	 * handler.  This can happen in copy_user, and if SEGV is disabled,
@@ -31,13 +30,13 @@ void sig_handler_common_skas(int sig, vo
 	if(sig == SIGSEGV)
 		change_sig(SIGSEGV, 1);
 
-	r = &TASK_REGS(get_current())->skas;
-	save_user = r->is_user;
-	r->is_user = 0;
+	r = TASK_REGS(get_current());
+	save_user = r->skas.is_user;
+	r->skas.is_user = 0;
 	if ( sig == SIGFPE || sig == SIGSEGV ||
 	     sig == SIGBUS || sig == SIGILL ||
 	     sig == SIGTRAP ) {
-		GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
+		GET_FAULTINFO_FROM_SC(r->skas.faultinfo, sc);
 	}
 
 	change_sig(SIGUSR1, 1);
@@ -49,10 +48,10 @@ void sig_handler_common_skas(int sig, vo
 	    sig != SIGVTALRM && sig != SIGALRM)
 		unblock_signals();
 
-	handler(sig, (union uml_pt_regs *) r);
+	handler(sig, r);
 
 	errno = save_errno;
-	r->is_user = save_user;
+	r->skas.is_user = save_user;
 }
 
 extern int ptrace_faultinfo;
Index: linux-2.6.21-mm/arch/um/sys-i386/fault.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-i386/fault.c	2007-04-02 12:18:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-i386/fault.c	2007-04-02 12:19:04.000000000 -0400
@@ -3,9 +3,7 @@
  * Licensed under the GPL
  */
 
-#include <signal.h>
 #include "sysdep/ptrace.h"
-#include "sysdep/sigcontext.h"
 
 /* These two are from asm-um/uaccess.h and linux/module.h, check them. */
 struct exception_table_entry
@@ -17,26 +15,14 @@ struct exception_table_entry
 const struct exception_table_entry *search_exception_tables(unsigned long add);
 
 /* Compare this to arch/i386/mm/extable.c:fixup_exception() */
-int arch_fixup(unsigned long address, void *sc_ptr)
+int arch_fixup(unsigned long address, union uml_pt_regs *regs)
 {
-	struct sigcontext *sc = sc_ptr;
 	const struct exception_table_entry *fixup;
 
 	fixup = search_exception_tables(address);
 	if(fixup != 0){
-		sc->eip = fixup->fixup;
+		UPT_IP(regs) = fixup->fixup;
 		return(1);
 	}
 	return(0);
 }
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
Index: linux-2.6.21-mm/arch/um/sys-x86_64/fault.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-x86_64/fault.c	2007-04-02 12:18:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-x86_64/fault.c	2007-04-02 12:19:04.000000000 -0400
@@ -4,20 +4,24 @@
  * Licensed under the GPL
  */
 
-#include "user.h"
+#include "sysdep/ptrace.h"
 
-int arch_fixup(unsigned long address, void *sc_ptr)
+/* These two are from asm-um/uaccess.h and linux/module.h, check them. */
+struct exception_table_entry
 {
-	/* XXX search_exception_tables() */
+	unsigned long insn;
+	unsigned long fixup;
+};
+
+const struct exception_table_entry *search_exception_tables(unsigned long add);
+int arch_fixup(unsigned long address, union uml_pt_regs *regs)
+{
+	const struct exception_table_entry *fixup;
+
+	fixup = search_exception_tables(address);
+	if(fixup != 0){
+		UPT_IP(regs) = fixup->fixup;
+		return(1);
+	}
 	return(0);
 }
-
-/* Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.21-mm/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-x86_64/signal.c	2007-04-02 12:18:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-x86_64/signal.c	2007-04-02 12:19:04.000000000 -0400
@@ -51,7 +51,7 @@ static int copy_sc_from_user_skas(struct
 
 #undef GETREG
 
-       return(err);
+       return err;
 }
 
 int copy_sc_to_user_skas(struct sigcontext __user *to,
Index: linux-2.6.21-mm/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-i386/signal.c	2007-04-02 12:18:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-i386/signal.c	2007-04-02 12:19:04.000000000 -0400
@@ -28,7 +28,7 @@ static int copy_sc_from_user_skas(struct
 	err = copy_from_user(&sc, from, sizeof(sc));
 	err |= copy_from_user(fpregs, sc.fpstate, sizeof(fpregs));
 	if(err)
-		return(err);
+		return err;
 
 	REGS_GS(regs->regs.skas.regs) = sc.gs;
 	REGS_FS(regs->regs.skas.regs) = sc.fs;
@@ -50,11 +50,11 @@ static int copy_sc_from_user_skas(struct
 	err = restore_fp_registers(userspace_pid[0], fpregs);
 	if(err < 0){
 	  	printk("copy_sc_from_user_skas - PTRACE_SETFPREGS failed, "
-		       "errno = %d\n", err);
-		return(1);
+		       "errno = %d\n", -err);
+		return err;
 	}
 
-	return(0);
+	return 0;
 }
 
 int copy_sc_to_user_skas(struct sigcontext __user *to, struct _fpstate __user *to_fp,
@@ -90,16 +90,16 @@ int copy_sc_to_user_skas(struct sigconte
 	if(err < 0){
 	  	printk("copy_sc_to_user_skas - PTRACE_GETFPREGS failed, "
 		       "errno = %d\n", err);
-		return(1);
+		return 1;
 	}
 	to_fp = (to_fp ? to_fp : (struct _fpstate __user *) (to + 1));
 	sc.fpstate = to_fp;
 
 	if(err)
-	  	return(err);
+	  	return err;
 
-	return(copy_to_user(to, &sc, sizeof(sc)) ||
-	       copy_to_user(to_fp, fpregs, sizeof(fpregs)));
+	return copy_to_user(to, &sc, sizeof(sc)) ||
+	       copy_to_user(to_fp, fpregs, sizeof(fpregs));
 }
 #endif
 
@@ -129,7 +129,7 @@ int copy_sc_from_user_tt(struct sigconte
 	to->fpstate = to_fp;
 	if(to_fp != NULL)
 		err |= copy_from_user(to_fp, from_fp, fpsize);
-	return(err);
+	return err;
 }
 
 int copy_sc_to_user_tt(struct sigcontext __user *to, struct _fpstate __user *fp,
@@ -164,15 +164,15 @@ static int copy_sc_from_user(struct pt_r
 	ret = CHOOSE_MODE(copy_sc_from_user_tt(UPT_SC(&to->regs), from,
 					       sizeof(struct _fpstate)),
 			  copy_sc_from_user_skas(to, from));
-	return(ret);
+	return ret;
 }
 
 static int copy_sc_to_user(struct sigcontext __user *to, struct _fpstate __user *fp,
 			   struct pt_regs *from, unsigned long sp)
 {
-	return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),
+	return CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),
 					      sizeof(*fp), sp),
-                           copy_sc_to_user_skas(to, fp, from, sp)));
+                           copy_sc_to_user_skas(to, fp, from, sp));
 }
 
 static int copy_ucontext_to_user(struct ucontext __user *uc, struct _fpstate __user *fp,
@@ -185,7 +185,7 @@ static int copy_ucontext_to_user(struct 
 	err |= put_user(current->sas_ss_size, &uc->uc_stack.ss_size);
 	err |= copy_sc_to_user(&uc->uc_mcontext, fp, &current->thread.regs, sp);
 	err |= copy_to_user(&uc->uc_sigmask, set, sizeof(*set));
-	return(err);
+	return err;
 }
 
 struct sigframe
@@ -355,7 +355,7 @@ long sys_sigreturn(struct pt_regs regs)
 
 	/* Avoid ERESTART handling */
 	PT_REGS_SYSCALL_NR(&current->thread.regs) = -1;
-	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
+	return PT_REGS_SYSCALL_RET(&current->thread.regs);
 
  segfault:
 	force_sig(SIGSEGV, current);
@@ -385,20 +385,9 @@ long sys_rt_sigreturn(struct pt_regs reg
 
 	/* Avoid ERESTART handling */
 	PT_REGS_SYSCALL_NR(&current->thread.regs) = -1;
-	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
+	return PT_REGS_SYSCALL_RET(&current->thread.regs);
 
  segfault:
 	force_sig(SIGSEGV, current);
 	return 0;
 }
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

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
