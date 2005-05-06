Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUBhe-00089a-Sb	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:53:50 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DUBhc-0004qd-S8	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 15:53:50 -0700
Message-Id: <200505062249.j46Mn3R9010450@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/12] UML - S390 preparation, peekusr/pokeusr
	defined by subarch
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
Date: Fri, 06 May 2005 18:49:03 -0400
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

s390 needs to change some parts of arch/um/kernel/ptrace.c.
Thus, the code regarding PEEKUSER and POKEUSER are shifted
to arch/um/sys-<subarch>/ptrace.c.
Also s390 debug registers need to be updated, when
singlestepping is switched on / off. Thus, setting/resetting
of singlestepping is centralized in the new function
set_singlestep(), which also inserts the macro
SUBARCH_SET_SINGLESTEP(mode), if defined.
Finally, s390 has the "ieee_instruction_pointer" in its
registers, which also is allowed to be read via
  ptrace( PTRACE_PEEKUSER, getpid(), PT_IEEE_IP, 0);
To implement this feature, sys_ptrace  inserts the macro
SUBARCH_PTRACE_SPECIAL, if defined.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/ptrace.c	2005-05-06 14:36:28.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/ptrace.c	2005-05-06 14:44:04.000000000 -0400
@@ -19,15 +19,30 @@
 #include "skas_ptrace.h"
 #include "sysdep/ptrace.h"
 
+static inline void set_singlestepping(struct task_struct *child, int on)
+{
+        if (on)
+                child->ptrace |= PT_DTRACE;
+        else
+                child->ptrace &= ~PT_DTRACE;
+        child->thread.singlestep_syscall = 0;
+
+#ifdef SUBARCH_SET_SINGLESTEPPING
+        SUBARCH_SET_SINGLESTEPPING(child, on)
+#endif
+                }
+
 /*
  * Called by kernel/ptrace.c when detaching..
  */
 void ptrace_disable(struct task_struct *child)
 { 
-	child->ptrace &= ~PT_DTRACE;
-	child->thread.singlestep_syscall = 0;
+        set_singlestepping(child,0);
 }
 
+extern int peek_user(struct task_struct * child, long addr, long data);
+extern int poke_user(struct task_struct * child, long addr, long data);
+
 long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
@@ -67,6 +82,10 @@
 		goto out_tsk;
 	}
 
+#ifdef SUBACH_PTRACE_SPECIAL
+        SUBARCH_PTRACE_SPECIAL(child,request,addr,data)
+#endif
+
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);
 	if (ret < 0)
 		goto out_tsk;
@@ -87,28 +106,9 @@
 	}
 
 	/* read the word at location addr in the USER area. */
-	case PTRACE_PEEKUSR: {
-		unsigned long tmp;
-
-		ret = -EIO;
-		if ((addr & 3) || addr < 0) 
-			break;
-
-		tmp = 0;  /* Default return condition */
-		if(addr < MAX_REG_OFFSET){
-			tmp = getreg(child, addr);
-		}
-#if defined(CONFIG_UML_X86) && !defined(CONFIG_64BIT)
-		else if((addr >= offsetof(struct user, u_debugreg[0])) &&
-			(addr <= offsetof(struct user, u_debugreg[7]))){
-			addr -= offsetof(struct user, u_debugreg[0]);
-			addr = addr >> 2;
-			tmp = child->thread.arch.debugregs[addr];
-		}
-#endif
-		ret = put_user(tmp, (unsigned long __user *) data);
-		break;
-	}
+        case PTRACE_PEEKUSR:
+                ret = peek_user(child, addr, data);
+                break;
 
 	/* when I and D space are separate, this will have to be fixed. */
 	case PTRACE_POKETEXT: /* write the word at location addr. */
@@ -121,26 +121,8 @@
 		break;
 
 	case PTRACE_POKEUSR: /* write the word at location addr in the USER area */
-		ret = -EIO;
-		if ((addr & 3) || addr < 0)
-			break;
-
-		if (addr < MAX_REG_OFFSET) {
-			ret = putreg(child, addr, data);
-			break;
-		}
-#if defined(CONFIG_UML_X86) && !defined(CONFIG_64BIT)
-		else if((addr >= offsetof(struct user, u_debugreg[0])) &&
-			(addr <= offsetof(struct user, u_debugreg[7]))){
-			  addr -= offsetof(struct user, u_debugreg[0]);
-			  addr = addr >> 2;
-			  if((addr == 4) || (addr == 5)) break;
-			  child->thread.arch.debugregs[addr] = data;
-			  ret = 0;
-		}
-#endif
-
-		break;
+                ret = poke_user(child, addr, data);
+                break;
 
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
@@ -148,8 +130,7 @@
 		if (!valid_signal(data))
 			break;
 
-		child->ptrace &= ~PT_DTRACE;
-		child->thread.singlestep_syscall = 0;
+                set_singlestepping(child, 0);
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
@@ -172,8 +153,7 @@
 		if (child->exit_state == EXIT_ZOMBIE)	/* already dead */
 			break;
 
-		child->ptrace &= ~PT_DTRACE;
-		child->thread.singlestep_syscall = 0;
+                set_singlestepping(child, 0);
 		child->exit_code = SIGKILL;
 		wake_up_process(child);
 		break;
@@ -184,8 +164,7 @@
 		if (!valid_signal(data))
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		child->ptrace |= PT_DTRACE;
-		child->thread.singlestep_syscall = 0;
+                set_singlestepping(child, 1);
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
Index: linux-2.6.12-rc3-mm/arch/um/sys-i386/ptrace.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/sys-i386/ptrace.c	2005-05-06 14:36:28.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/sys-i386/ptrace.c	2005-05-06 14:44:45.000000000 -0400
@@ -73,6 +73,25 @@
 	return 0;
 }
 
+int poke_user(struct task_struct *child, long addr, long data)
+{
+        if ((addr & 3) || addr < 0)
+                return -EIO;
+
+        if (addr < MAX_REG_OFFSET)
+                return putreg(child, addr, data);
+
+        else if((addr >= offsetof(struct user, u_debugreg[0])) &&
+                (addr <= offsetof(struct user, u_debugreg[7]))){
+                addr -= offsetof(struct user, u_debugreg[0]);
+                addr = addr >> 2;
+                if((addr == 4) || (addr == 5)) return -EIO;
+                child->thread.arch.debugregs[addr] = data;
+                return 0;
+        }
+        return -EIO;
+}
+
 unsigned long getreg(struct task_struct *child, int regno)
 {
 	unsigned long retval = ~0UL;
@@ -93,6 +112,27 @@
 	return retval;
 }
 
+int peek_user(struct task_struct *child, long addr, long data)
+{
+/* read the word at location addr in the USER area. */
+        unsigned long tmp;
+
+        if ((addr & 3) || addr < 0)
+                return -EIO;
+
+        tmp = 0;  /* Default return condition */
+        if(addr < MAX_REG_OFFSET){
+                tmp = getreg(child, addr);
+        }
+        else if((addr >= offsetof(struct user, u_debugreg[0])) &&
+                (addr <= offsetof(struct user, u_debugreg[7]))){
+                addr -= offsetof(struct user, u_debugreg[0]);
+                addr = addr >> 2;
+                tmp = child->thread.arch.debugregs[addr];
+        }
+        return put_user(tmp, (unsigned long *) data);
+}
+
 struct i387_fxsave_struct {
 	unsigned short	cwd;
 	unsigned short	swd;
Index: linux-2.6.12-rc3-mm/arch/um/sys-ppc/ptrace.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/sys-ppc/ptrace.c	2005-05-06 14:36:28.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/sys-ppc/ptrace.c	2005-05-06 14:41:25.000000000 -0400
@@ -8,6 +8,25 @@
 	return 0;
 }
 
+int poke_user(struct task_struct *child, long addr, long data)
+{
+	if ((addr & 3) || addr < 0)
+		return -EIO;
+
+	if (addr < MAX_REG_OFFSET)
+		return putreg(child, addr, data);
+
+	else if((addr >= offsetof(struct user, u_debugreg[0])) &&
+		(addr <= offsetof(struct user, u_debugreg[7]))){
+		  addr -= offsetof(struct user, u_debugreg[0]);
+		  addr = addr >> 2;
+		  if((addr == 4) || (addr == 5)) return -EIO;
+		  child->thread.arch.debugregs[addr] = data;
+		  return 0;
+	}
+	return -EIO;
+}
+
 unsigned long getreg(struct task_struct *child, unsigned long regno)
 {
 	unsigned long retval = ~0UL;
@@ -16,6 +35,27 @@
 	return retval;
 }
 
+int peek_user(struct task_struct *child, long addr, long data)
+{
+	/* read the word at location addr in the USER area. */
+	unsigned long tmp;
+
+	if ((addr & 3) || addr < 0)
+		return -EIO;
+
+	tmp = 0;  /* Default return condition */
+	if(addr < MAX_REG_OFFSET){
+		tmp = getreg(child, addr);
+	}
+	else if((addr >= offsetof(struct user, u_debugreg[0])) &&
+		(addr <= offsetof(struct user, u_debugreg[7]))){
+		addr -= offsetof(struct user, u_debugreg[0]);
+		addr = addr >> 2;
+		tmp = child->thread.arch.debugregs[addr];
+	}
+	return put_user(tmp, (unsigned long *) data);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.12-rc3-mm/arch/um/sys-x86_64/ptrace.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/sys-x86_64/ptrace.c	2005-05-06 14:36:28.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/sys-x86_64/ptrace.c	2005-05-06 14:46:00.000000000 -0400
@@ -62,6 +62,27 @@
 	return 0;
 }
 
+int poke_user(struct task_struct *child, long addr, long data)
+{
+        if ((addr & 3) || addr < 0)
+                return -EIO;
+
+        if (addr < MAX_REG_OFFSET)
+                return putreg(child, addr, data);
+
+#if 0 /* Need x86_64 debugregs handling */
+        else if((addr >= offsetof(struct user, u_debugreg[0])) &&
+                (addr <= offsetof(struct user, u_debugreg[7]))){
+                addr -= offsetof(struct user, u_debugreg[0]);
+                addr = addr >> 2;
+                if((addr == 4) || (addr == 5)) return -EIO;
+                child->thread.arch.debugregs[addr] = data;
+                return 0;
+        }
+#endif
+        return -EIO;
+}
+
 unsigned long getreg(struct task_struct *child, int regno)
 {
 	unsigned long retval = ~0UL;
@@ -84,6 +105,29 @@
 	return retval;
 }
 
+int peek_user(struct task_struct *child, long addr, long data)
+{
+	/* read the word at location addr in the USER area. */
+        unsigned long tmp;
+
+        if ((addr & 3) || addr < 0)
+                return -EIO;
+
+        tmp = 0;  /* Default return condition */
+        if(addr < MAX_REG_OFFSET){
+                tmp = getreg(child, addr);
+        }
+#if 0 /* Need x86_64 debugregs handling */
+        else if((addr >= offsetof(struct user, u_debugreg[0])) &&
+                (addr <= offsetof(struct user, u_debugreg[7]))){
+                addr -= offsetof(struct user, u_debugreg[0]);
+                addr = addr >> 2;
+                tmp = child->thread.arch.debugregs[addr];
+        }
+#endif
+        return put_user(tmp, (unsigned long *) data);
+}
+
 void arch_switch(void)
 {
 /* XXX



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
