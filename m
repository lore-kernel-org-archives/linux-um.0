Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CShgT-00074u-6W for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2004 12:06:13 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CShgP-00060u-SQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2004 12:06:13 -0800
Message-ID: <419517A4.7020700@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090402010602080506080204"
Subject: [uml-devel] Patchset to implement PTRACE_SYSEMU_SINGLESTEP
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
Date: Fri, 12 Nov 2004 21:05:56 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090402010602080506080204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached are several patches. Four of them (patch-2.6.*-skas-v7-*) implement
PTRACE_SYSEMU_SINGLESTEP in the host. They are based on
linux-2.6.7-vanilla + host-skas3-2.6.7-v7.patch (resp. the 2.6.9 versions).
The "-reorganize" patches are a rework of the current patch without changing
the functionality. The "add-SYSEMU_SINGLESTEP" then implement the new features.
Please note: the differences between 2.6.7 and 2.6.9 are dependent on the
different handling of syscall singlestepping in the two versions.

To have UML using the new feature, there are two further patches named
patch-SYSEMU_SINGLESTEP-*. They are based on linux-2.6.9-vanilla +
all bb2-patches + patch-sysemu-tt + patch-fix-uml-hang-on-2.6.9-host.
To have all the patches complete, the latter two are attached also.

I tested on host 2.6.7 and host 2.6.9 with SKAS and TT mode. Currently I don't
know any problem with it.

Bodo

BTW: Today I tried the first time since weeks to do a reboot in SKAS. It simply
      exits UML, as it did weeks ago. Is there anybody involved with that problem?

--------------090402010602080506080204
Content-Type: text/plain;
 name="patch-2.6.7-skas-v7-reorganize"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.7-skas-v7-reorganize"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch is based on 2.6.7-vanilla + host-skas3-2.6.7-v7.patch
It reorganizes the code without changing the behavior of the
host kernel. This is done to free TIF_SYSCALL_EMU from double
use as a preparation for SYSEMU_SINGLESTEP extension.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/arch/i386/kernel/entry.S	2004-11-10 16:30:16.000000000 +0100
+++ b/arch/i386/kernel/entry.S	2004-11-10 16:44:03.000000000 +0100
@@ -341,12 +341,18 @@ syscall_trace_entry:
 	xorl %edx,%edx
 	call do_syscall_trace
 	cmpl $0, %eax
-	jne syscall_exit		# ret != 0 -> running under PTRACE_SYSEMU,
+	jne syscall_skip		# ret != 0 -> running under PTRACE_SYSEMU,
 					# so must skip actual syscall
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
+syscall_skip:
+	cli				# make sure we don't miss an interrupt
+					# setting need_resched or sigpending
+					# between sampling and the iret
+	movl TI_flags(%ebp), %ecx
+	jmp work_pending
 
 	# perform syscall exit tracing
 	ALIGN
--- a/arch/i386/kernel/ptrace.c	2004-11-10 16:29:56.000000000 +0100
+++ b/arch/i386/kernel/ptrace.c	2004-11-10 17:30:11.000000000 +0100
@@ -366,23 +366,19 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		/* If we came here with PTRACE_SYSEMU and now continue with
-		 * PTRACE_SYSCALL, entry.S used to intercept the syscall return.
-		 * But it shouldn't!
-		 * So we don't clear TIF_SYSCALL_EMU, which is always unused in
-		 * this special case, to remember, we came from SYSEMU. That
-		 * flag will be cleared by do_syscall_trace().
-		 */
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-		} else if (request == PTRACE_CONT) {
-			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
-		if (request == PTRACE_SYSCALL) {
+		else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		} else {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		}
+		else {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
 	/* make sure the single step bit is not set. */
 		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
@@ -417,8 +413,7 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		/* See do_syscall_trace to know why we don't clear
-		 * TIF_SYSCALL_EMU.*/
+		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		if ((child->ptrace & PT_DTRACE) == 0) {
 			/* Spurious delayed TF traps may occur */
@@ -591,7 +586,7 @@ out:
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu, is_systrace, is_singlestep;
+	int is_sysemu;
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -601,20 +596,9 @@ int do_syscall_trace(struct pt_regs *reg
 			audit_syscall_exit(current, regs->eax);
 	}
 	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
-	is_systrace = test_thread_flag(TIF_SYSCALL_TRACE);
-	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
 
-	if (!is_systrace && !is_sysemu)
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
 		return 0;
-	/* We can detect the case of coming from PTRACE_SYSEMU and now running
-	 * with PTRACE_SYSCALL or PTRACE_SINGLESTEP, by TIF_SYSCALL_EMU being
-	 * set additionally.
-	 * If so let's reset the flag and return without action.
-	 */
-	if (is_sysemu && (is_systrace || is_singlestep)) {
-		clear_thread_flag(TIF_SYSCALL_EMU);
-		return 0;
-	}
 	if (!(current->ptrace & PT_PTRACED))
 		return 0;
 	/* the 0x80 provides a way for the tracing parent to distinguish
@@ -632,5 +616,10 @@ int do_syscall_trace(struct pt_regs *reg
 		current->exit_code = 0;
 	}
 	/* != 0 if nullifying the syscall, 0 if running it normally */
-	return is_sysemu;
+	if ( !is_sysemu )
+		return 0;
+
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current, regs->eax);
+	return 1;
 }

--------------090402010602080506080204
Content-Type: text/plain;
 name="patch-2.6.7-skas-v7-add-SYSEMU_SINGLESTEP"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.6.7-skas-v7-add-SYSEMU_SINGLESTEP"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch is based on
   2.6.7-vanilla +
   host-skas3-2.6.7-v7.patch +
   patch-2.6.7-skas-v7-reorganize
It implements the new ptrace option PTRACE_SYSEMU_SINGLESTEP
this new option can be used by UML to singlestep a process.
Then it will receive the common syscall interceptions plus
a singlestep trap for each non syscall instruction.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/include/linux/ptrace.h	2004-11-10 18:24:59.120850808 +0100
+++ b/include/linux/ptrace.h	2004-11-10 18:26:08.894243640 +0100
@@ -21,6 +21,7 @@
 
 #define PTRACE_SYSCALL		  24
 #define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
--- a/arch/i386/kernel/ptrace.c	2004-11-10 18:20:02.047012896 +0100
+++ b/arch/i386/kernel/ptrace.c	2004-11-10 18:23:21.612674304 +0100
@@ -359,6 +359,7 @@ asmlinkage int sys_ptrace(long request, 
 		  break;
 
 	case PTRACE_SYSEMU: /* continue and stop at next syscall, which will not be executed */
+	case PTRACE_SYSEMU_SINGLESTEP: /* Same as SYSEMU, but singlestep if not syscall */
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		long tmp;
@@ -366,22 +367,31 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
+		/* prepare to reset single step bit */
+		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+		}
+		else if (request == PTRACE_SYSEMU_SINGLESTEP) {
+			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+			set_tsk_thread_flag(child, TIF_SINGLESTEP);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			/* For SYSEMU_SINGLESTEP, set single step bit */
+			tmp |= TRAP_FLAG;
 		}
 		else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		}
 		else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		}
-		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
-	/* make sure the single step bit is not set. */
-		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET,tmp);
 		wake_up_process(child);
 		ret = 0;
@@ -596,6 +606,11 @@ int do_syscall_trace(struct pt_regs *reg
 			audit_syscall_exit(current, regs->eax);
 	}
 	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
+	/* If a process stops on the 1st tracepoint with SYSCALL_TRACE
+         * and then is resumed with SYSCALL_EMU and TIF_SYSAUDIT is set,
+	 *  it will come in here. We have to check this and return */
+	if (is_sysemu && entryexit)
+		return 0;
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
 		return 0;
@@ -619,6 +634,7 @@ int do_syscall_trace(struct pt_regs *reg
 	if ( !is_sysemu )
 		return 0;
 
+	regs->orig_eax = -1; /* force skip of syscall restarting */
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(current, regs->eax);
 	return 1;

--------------090402010602080506080204
Content-Type: text/plain;
 name="patch-2.6.9-skas-v7-reorganize"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.9-skas-v7-reorganize"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch is based on 2.6.9-vanilla + host-skas3-2.6.9-v7.patch
It reorganizes the code without changing the behavior of the
host kernel. This is done to free TIF_SYSCALL_EMU from double
use as a preparation for SYSEMU_SINGLESTEP extension.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/arch/i386/kernel/entry.S	2004-11-10 16:30:16.000000000 +0100
+++ b/arch/i386/kernel/entry.S	2004-11-10 16:44:03.000000000 +0100
@@ -341,12 +341,18 @@ syscall_trace_entry:
 	xorl %edx,%edx
 	call do_syscall_trace
 	cmpl $0, %eax
-	jne syscall_exit		# ret != 0 -> running under PTRACE_SYSEMU,
+	jne syscall_skip		# ret != 0 -> running under PTRACE_SYSEMU,
 					# so must skip actual syscall
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
+syscall_skip:
+	cli				# make sure we don't miss an interrupt
+					# setting need_resched or sigpending
+					# between sampling and the iret
+	movl TI_flags(%ebp), %ecx
+	jmp work_pending
 
 	# perform syscall exit tracing
 	ALIGN
--- a/arch/i386/kernel/ptrace.c	2004-11-10 16:29:56.000000000 +0100
+++ b/arch/i386/kernel/ptrace.c	2004-11-10 17:30:11.000000000 +0100
@@ -367,21 +367,16 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		/* If we came here with PTRACE_SYSEMU and now continue with
-		 * PTRACE_SYSCALL, entry.S used to intercept the syscall return.
-		 * But it shouldn't!
-		 * So we don't clear TIF_SYSCALL_EMU, which is always unused in
-		 * this special case, to remember, we came from SYSEMU. That
-		 * flag will be cleared by do_syscall_trace().
-		 */
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-		} else if (request == PTRACE_CONT) {
-			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
-		if (request == PTRACE_SYSCALL) {
+		else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		} else {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		}
+		else {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
 		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
@@ -420,8 +415,7 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		/*See do_syscall_trace to know why we don't clear
-		 * TIF_SYSCALL_EMU.*/
+		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		if ((child->ptrace & PT_DTRACE) == 0) {
 			/* Spurious delayed TF traps may occur */
@@ -595,7 +589,7 @@ out:
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu, is_systrace, is_singlestep;
+	int is_sysemu, is_singlestep;
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -605,20 +599,11 @@ int do_syscall_trace(struct pt_regs *reg
 			audit_syscall_exit(current, regs->eax);
 	}
 	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
-	is_systrace = test_thread_flag(TIF_SYSCALL_TRACE);
 	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
 
-	if (!is_systrace && !is_singlestep && !is_sysemu)
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    !is_singlestep && !is_sysemu)
 		return 0;
-	/* We can detect the case of coming from PTRACE_SYSEMU and now running
-	 * with PTRACE_SYSCALL or PTRACE_SINGLESTEP, by TIF_SYSCALL_EMU being
-	 * set additionally.
-	 * If so let's reset the flag and return without action.
-	 */
-	if (is_sysemu && (is_systrace || is_singlestep)) {
-		clear_thread_flag(TIF_SYSCALL_EMU);
-		return 0;
-	}
 	if (!(current->ptrace & PT_PTRACED))
 		return 0;
 	/* the 0x80 provides a way for the tracing parent to distinguish
@@ -636,5 +621,10 @@ int do_syscall_trace(struct pt_regs *reg
 		current->exit_code = 0;
 	}
 	/* != 0 if nullifying the syscall, 0 if running it normally */
-	return is_sysemu;
+	if ( !is_sysemu )
+		return 0;
+
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current, regs->eax);
+	return 1;
 }

--------------090402010602080506080204
Content-Type: text/plain;
 name="patch-2.6.9-skas-v7-add-SYSEMU_SINGLESTEP"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.6.9-skas-v7-add-SYSEMU_SINGLESTEP"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch is based on
   2.6.9-vanilla +
   host-skas3-2.6.9-v7.patch +
   patch-2.6.9-skas-v7-reorganize
It implements the new ptrace option PTRACE_SYSEMU_SINGLESTEP
this new option can be used by UML to singlestep a process.
Then it will receive the common syscall interceptions plus
a singlestep trap for each non syscall instruction.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/include/linux/ptrace.h	2004-11-10 18:24:59.120850808 +0100
+++ b/include/linux/ptrace.h	2004-11-10 18:26:08.894243640 +0100
@@ -21,6 +21,7 @@
 
 #define PTRACE_SYSCALL		  24
 #define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
--- a/arch/i386/kernel/ptrace.c	2004-11-10 18:20:02.047012896 +0100
+++ b/arch/i386/kernel/ptrace.c	2004-11-10 18:23:21.612674304 +0100
@@ -360,6 +360,7 @@ asmlinkage int sys_ptrace(long request, 
 		  break;
 
 	case PTRACE_SYSEMU: /* continue and stop at next syscall, which will not be executed */
+	case PTRACE_SYSEMU_SINGLESTEP: /* Same as SYSEMU, but singlestep if not syscall */
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		long tmp;
@@ -367,22 +368,31 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
+		/* prepare to reset single step bit */
+		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+		}
+		else if (request == PTRACE_SYSEMU_SINGLESTEP) {
+			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+			set_tsk_thread_flag(child, TIF_SINGLESTEP);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			/* For SYSEMU_SINGLESTEP, set single step bit */
+			tmp |= TRAP_FLAG;
 		}
 		else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		}
 		else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		}
-		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
-	/* make sure the single step bit is not set. */
-		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET,tmp);
 		wake_up_process(child);
 		ret = 0;
@@ -599,7 +609,13 @@ int do_syscall_trace(struct pt_regs *reg
 			audit_syscall_exit(current, regs->eax);
 	}
 	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
-	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
+	/* If a process stops on the 1st tracepoint with SYSCALL_TRACE
+         * and then is resumed with SYSEMU_SINGLESTEP, it will come in
+	 * here. We have to check this and return */
+	if (is_sysemu && entryexit)
+		return 0;
+	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP */
+	is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    !is_singlestep && !is_sysemu)
@@ -624,6 +640,7 @@ int do_syscall_trace(struct pt_regs *reg
 	if ( !is_sysemu )
 		return 0;
 
+	regs->orig_eax = -1; /* force skip of syscall restarting */
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(current, regs->eax);
 	return 1;

--------------090402010602080506080204
Content-Type: text/plain;
 name="patch-SYSEMU_SINGLESTEP-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-SYSEMU_SINGLESTEP-1"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch is based on
   2.6.9-vanilla +
   all patches from uml-2.6.9-bb2-broken-out.tar.bz2 +
   patch-fix-sysemu-tt +
   patch-fix-uml-hang-on-2.6.9-host

It implements checking for the new ptrace option SYSEMU_SINGLESTEP
(advanced sysemu) and allows the values 0,1,2 for /proc/sysemu,
if advanced sysemu is available:
   0 = don't use sysemu
   1 = use sysemu, but don't use advanced sysemu
   2 = use sysemu and advanced sysemu

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/include/linux/ptrace.h	2004-11-11 13:16:35.750434832 +0100
+++ b/include/linux/ptrace.h	2004-11-11 13:16:59.676797472 +0100
@@ -21,6 +21,7 @@
 
 #define PTRACE_SYSCALL		  24
 #define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
--- a/arch/um/include/ptrace_user.h	2004-11-11 13:22:00.928000328 +0100
+++ b/arch/um/include/ptrace_user.h	2004-11-11 13:22:42.005755560 +0100
@@ -21,6 +21,9 @@ extern void ptrace_pokeuser(unsigned lon
 #ifndef PTRACE_SYSEMU
 #define PTRACE_SYSEMU 31
 #endif
+#ifndef PTRACE_SYSEMU_SINGLESTEP
+#define PTRACE_SYSEMU_SINGLESTEP 32
+#endif
 
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
--- a/arch/um/kernel/process.c	2004-11-11 13:01:48.556308840 +0100
+++ b/arch/um/kernel/process.c	2004-11-11 13:33:34.089623744 +0100
@@ -241,7 +241,7 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 static void __init check_sysemu(void)
 {
 	void *stack;
-	int pid, n, status;
+	int pid, syscall, n, status, count=0;
 
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
@@ -269,12 +269,46 @@ static void __init check_sysemu(void)
 	sysemu_supported = 1;
 	printk("OK\n");
 	set_using_sysemu(!force_sysemu_disabled);
+
+	printk("Checking advanced syscall emulation patch for ptrace...");
+	pid = start_ptraced_child(&stack);
+	while(1){
+		count++;
+		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
+			goto fail;
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		if(n < 0)
+			panic("check_ptrace : wait failed, errno = %d", errno);
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+			panic("check_ptrace : expected (SIGTRAP|SYSCALL_TRAP), "
+			      "got status = %d", status);
+		
+		syscall = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_NR_OFFSET,
+				 0);
+		if(syscall == __NR_getpid){
+			if (!count)
+				panic("check_ptrace : SYSEMU_SINGLESTEP doesn't singlestep");
+			n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
+				   os_getpid());
+			if(n < 0)
+				panic("check_sysemu : failed to modify system "
+				      "call return, errno = %d", errno);
+			break;
+		}
+	}
+	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
+		goto fail_stopped;
+
+	sysemu_supported = 2;
+	printk("OK\n");
+
+	if ( !force_sysemu_disabled )
+		set_using_sysemu(sysemu_supported);
 	return;
 
 fail:
 	stop_ptraced_child(pid, stack, 1, 0);
 fail_stopped:
-	sysemu_supported = 0;
 	printk("missing\n");
 }
 
--- a/arch/um/kernel/process_kern.c	2004-11-11 12:41:33.029097064 +0100
+++ b/arch/um/kernel/process_kern.c	2004-11-11 12:44:56.451172208 +0100
@@ -405,7 +405,9 @@ int sysemu_supported;
 
 void set_using_sysemu(int value)
 {
-	atomic_set(&using_sysemu, sysemu_supported && value);
+	if (value > sysemu_supported)
+		return;
+	atomic_set(&using_sysemu, value);
 }
 
 int get_using_sysemu(void)
@@ -428,7 +430,7 @@ static int proc_write_sysemu(struct file
 	if (copy_from_user(tmp, buf, 1))
 		return -EFAULT;
 
-	if (tmp[0] == '0' || tmp[0] == '1')
+	if (tmp[0] >= '0' && tmp[0] <= '2')
 		set_using_sysemu(tmp[0] - '0');
 	return count; /*We use the first char, but pretend to write everything*/
 }

--------------090402010602080506080204
Content-Type: text/plain;
 name="patch-SYSEMU_SINGLESTEP-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-SYSEMU_SINGLESTEP-2"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch is based on
   2.6.9-vanilla +
   all patches from uml-2.6.9-bb2-broken-out.tar.bz2 +
   patch-fix-sysemu-tt +
   patch-fix-uml-hang-on-2.6.9-host
   patch-SYSEMU_SINGLESTEP-1

It implements using the new ptrace option SYSEMU_SINGLESTEP in UML
(advanced sysemu) in SKAS and TT modes.
To have a fast selection of the appropriate ptrace option to use next,
a 2 dimensional arry is used and singlestepping is modified to return
0,1 or 2:
    0 = don't do singlestepping
    1 = singlestep a syscall
    2 = singlestep a "non syscall" instruction

In do_syscall() writing of the syscall number is supressed, if the
advanced sysemu is in use (that does it itself).

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/arch/um/include/ptrace_user.h	2004-11-11 14:00:58.000000000 +0100
+++ b/arch/um/include/ptrace_user.h	2004-11-11 14:24:24.000000000 +0100
@@ -29,4 +29,11 @@ void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
 
+#define SELECT_PTRACE_OPERATION(sysemu_mode, singlestep_mode) \
+	(((int[3][3] ) { \
+		{ PTRACE_SYSCALL, PTRACE_SYSCALL, PTRACE_SINGLESTEP }, \
+		{ PTRACE_SYSEMU, PTRACE_SYSEMU, PTRACE_SINGLESTEP }, \
+		{ PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP, PTRACE_SYSEMU_SINGLESTEP }}) \
+		[sysemu_mode][singlestep_mode])
+
 #endif
--- a/arch/um/kernel/process_kern.c	2004-11-11 14:09:12.000000000 +0100
+++ b/arch/um/kernel/process_kern.c	2004-11-11 14:32:43.000000000 +0100
@@ -465,9 +465,9 @@ int singlestepping(void * t)
 		return(0);
 
 	if (task->thread.singlestep_syscall)
-		return(0);
+		return(1);
 
-	return 1;
+	return 2;
 }
 
 /*
--- a/arch/um/kernel/skas/process.c	2004-11-11 14:14:37.000000000 +0100
+++ b/arch/um/kernel/skas/process.c	2004-11-11 14:24:48.000000000 +0100
@@ -140,15 +140,15 @@ void start_userspace(int cpu)
 
 void userspace(union uml_pt_regs *regs)
 {
-	int err, status, op, pt_syscall_parm, pid = userspace_pid[0];
+	int err, status, op, pid = userspace_pid[0];
 	int local_using_sysemu; /*To prevent races if using_sysemu changes under us.*/
 
 	restore_registers(regs);
 		
 	local_using_sysemu = get_using_sysemu();
 
-	pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
-	err = ptrace(pt_syscall_parm, pid, 0, 0);
+	op = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
+	err = ptrace(op, pid, 0, 0);
 
 	if(err)
 		panic("userspace - PTRACE_%s failed, errno = %d\n",
@@ -194,10 +194,8 @@ void userspace(union uml_pt_regs *regs)
 
 		/*Now we ended the syscall, so re-read local_using_sysemu.*/
 		local_using_sysemu = get_using_sysemu();
-		pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
 
-		op = singlestepping(NULL) ? PTRACE_SINGLESTEP :
-			pt_syscall_parm;
+		op = SELECT_PTRACE_OPERATION(local_using_sysemu, singlestepping(NULL));
 
 		err = ptrace(op, pid, 0, 0);
 		if(err)
--- a/arch/um/kernel/tt/tracer.c	2004-11-11 14:10:38.000000000 +0100
+++ b/arch/um/kernel/tt/tracer.c	2004-11-11 15:03:42.239460000 +0100
@@ -186,7 +186,7 @@ int tracer(int (*init_proc)(void *), voi
 	unsigned long eip = 0;
 	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
 	int last_index, proc_id = 0, n, err, old_tracing = 0, strace = 0;
-	int pt_syscall_parm, local_using_sysemu = 0;
+	int local_using_sysemu = 0;
 
 	signal(SIGPIPE, SIG_IGN);
 	setup_tracer_winch();
@@ -383,18 +383,14 @@ int tracer(int (*init_proc)(void *), voi
 			}
 
 			local_using_sysemu = get_using_sysemu();
-			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
 
-			if(tracing){
-				if(singlestepping(task))
-					cont_type = PTRACE_SINGLESTEP;
-				else cont_type = pt_syscall_parm;
-			}
-			else cont_type = PTRACE_CONT;
-
-			if((cont_type == PTRACE_CONT) && 
-			   (debugger_pid != -1) && strace)
+			if(tracing)
+				cont_type = SELECT_PTRACE_OPERATION(local_using_sysemu,
+				                                    singlestepping(task));
+			else if((debugger_pid != -1) && strace)
 				cont_type = PTRACE_SYSCALL;
+			else
+				cont_type = PTRACE_CONT;
 
 			if(ptrace(cont_type, pid, 0, sig) != 0){
 				tracer_panic("ptrace failed to continue "
--- a/arch/um/kernel/tt/syscall_user.c	2004-11-12 16:45:21.546136232 +0100
+++ b/arch/um/kernel/tt/syscall_user.c	2004-11-12 16:47:11.737384616 +0100
@@ -61,6 +61,10 @@ void do_syscall(void *task, int pid, int
 	   ((unsigned long *) PT_IP(proc_regs) <= &_etext))
 		tracer_panic("I'm tracing myself and I can't get out");
 
+	/* advanced sysemu mode set syscall number to -1 automatically */
+	if (local_using_sysemu==2)
+		return;
+
 	/* syscall number -1 in sysemu skips syscall restarting in host */
 	if(ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, 
 		  local_using_sysemu ? -1 : __NR_getpid) < 0)

--------------090402010602080506080204
Content-Type: text/plain;
 name="patch-fix-sysemu-tt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fix-sysemu-tt"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

The patch uml-use-sysemu-for-tt needs some small corrections:
1) local_using_sysemu must be sampled *before* the next
   ptrace(PTRACE_SYSEMU/SYSCALL) and must stay the same until do_syscall()
   has been done. Currently it is sampled before do_syscall() and is used
   after this for ptrace(PTRACE_SYSEMU/SYSCALL). Even if no problem is
   visible to the UML user, a single syscall could be executed on the host
   when switching on sysemu. The result of this then is overwritten by the
   syscall execution in UML.
   Since the first event the tracer has to handle is not a syscall, it's
   enough to initialize local_using_sysemu to 0;
2) Even if the host never *does* a syscall in SYSEMU, we have to write the
   syscall number with -1, to not have the host doing syscall restarting.
   This would happen only with an invalid syscall number equal to one of
   the -ERESTART values. But to be perfect ...
Additionally I changed do_syscall() to be void instead of int.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/arch/um/kernel/tt/include/tt.h	2004-11-11 21:27:08.405134680 +0100
+++ b/arch/um/kernel/tt/include/tt.h	2004-11-11 21:27:23.807793120 +0100
@@ -26,7 +26,7 @@ extern void set_tracing(void *t, int tra
 extern int is_tracing(void *task);
 extern void syscall_handler(int sig, union uml_pt_regs *regs);
 extern void exit_kernel(int pid, void *task);
-extern int do_syscall(void *task, int pid, int local_using_sysemu);
+extern void do_syscall(void *task, int pid, int local_using_sysemu);
 extern void do_sigtrap(void *task);
 extern int is_valid_pid(int pid);
 extern void remap_data(void *segment_start, void *segment_end, int w);
--- a/arch/um/kernel/tt/tracer.c	2004-11-12 10:28:46.776498528 +0100
+++ a/arch/um/kernel/tt/tracer.c	2004-11-12 10:34:41.381590360 +0100
@@ -186,7 +186,7 @@ int tracer(int (*init_proc)(void *), voi
 	unsigned long eip = 0;
 	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
 	int last_index, proc_id = 0, n, err, old_tracing = 0, strace = 0;
-	int pt_syscall_parm, local_using_sysemu;
+	int pt_syscall_parm, local_using_sysemu = 0;
 
 	signal(SIGPIPE, SIG_IGN);
 	setup_tracer_winch();
@@ -305,9 +305,6 @@ int tracer(int (*init_proc)(void *), voi
 			if ( tracing ) /* Assume: no syscall, when coming from user */
 				do_sigtrap(task);
 
-			local_using_sysemu = get_using_sysemu();
-			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
-
 			switch(sig){
 			case SIGUSR1:
 				sig = 0;
@@ -385,6 +382,9 @@ int tracer(int (*init_proc)(void *), voi
 				continue;
 			}
 
+			local_using_sysemu = get_using_sysemu();
+			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
+
 			if(tracing){
 				if(singlestepping(task))
 					cont_type = PTRACE_SINGLESTEP;
--- a/arch/um/kernel/tt/syscall_user.c	2004-11-12 10:30:32.181474536 +0100
+++ b/arch/um/kernel/tt/syscall_user.c	2004-11-12 10:41:04.146401264 +0100
@@ -48,7 +48,7 @@ void do_sigtrap(void *task)
 	UPT_SYSCALL_NR(TASK_REGS(task)) = -1;
 }
 
-int do_syscall(void *task, int pid, int local_using_sysemu)
+void do_syscall(void *task, int pid, int local_using_sysemu)
 {
 	unsigned long proc_regs[FRAME_SIZE];
 
@@ -61,14 +61,11 @@ int do_syscall(void *task, int pid, int 
 	   ((unsigned long *) PT_IP(proc_regs) <= &_etext))
 		tracer_panic("I'm tracing myself and I can't get out");
 
-	if(local_using_sysemu)
-		return(1);
-
+	/* syscall number -1 in sysemu skips syscall restarting in host */
 	if(ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, 
-		  __NR_getpid) < 0)
+		  local_using_sysemu ? -1 : __NR_getpid) < 0)
 		tracer_panic("do_syscall : Nullifying syscall failed, "
 			     "errno = %d", errno);
-	return(1);
 }
 
 /*

--------------090402010602080506080204
Content-Type: text/plain;
 name="patch-fix-uml-hang-on-2.6.9-host"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fix-uml-hang-on-2.6.9-host"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

The patch uml-hang-on-2.6.9-host needs to be corrected. The use
of os_kill_ptraced_process() is restricted to the tracer-thread!
No other process is allowed to do ptrace(PTRACE_KILL).
So I had "dead" processes hanging in my host system until UML
was shutdown. And I had panic()s, because processes were not
stopped.
Thus, I implemented request_kill_ptraced_process(), which lets
the tracer do the ptrace(PTRACE_KILL). Sorry, this method is
slow, but I didn't see an other solution.
Also, I modified some other places to use the new call instead
of os_kill_process(). But this didn't work on the first step.
kill_off_processes_tt() couldn't kill the remaining processes
on shutdown. This happens, because ptrace(PTRACE_KILL) doesn't
really send a SIGKILL to the process, but writes SIGKILL to the
exit_code. That does results in send_sig(SIGKILL) for processes
being stopped on a ptrace event only, but not even for all of
these events.
So I added an option to request_kill_ptraced_process() that
allows to force an additional os_kill_process() to be executed
before the os_kill_ptraced_process().
Summary: The behavior of 2.6.9 host is very uggly. You need to
do kill() and ptrace(PTRACE_KILL) to be shure, a process will
really exit. If the host is changed to be more consistent, we
should change all this again.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/include/asm-um/processor-generic.h	2004-11-11 20:08:28.382687160 +0100
+++ b/include/asm-um/processor-generic.h	2004-11-11 20:09:09.167486928 +0100
@@ -54,7 +54,8 @@ struct thread_struct {
 		union {
 			struct {
 				int pid;
-			} fork, exec;
+				int mode;
+			} fork, exec, kill;
 			struct {
 				int (*proc)(void *);
 				void *arg;
--- a/arch/um/kernel/tt/include/mode-tt.h	2004-11-11 20:05:55.383946504 +0100
+++ b/arch/um/kernel/tt/include/mode-tt.h	2004-11-11 20:06:44.263515680 +0100
@@ -8,7 +8,7 @@
 
 #include "sysdep/ptrace.h"
 
-enum { OP_NONE, OP_EXEC, OP_FORK, OP_TRACE_ON, OP_REBOOT, OP_HALT, OP_CB };
+enum { OP_NONE, OP_EXEC, OP_FORK, OP_KILL, OP_TRACE_ON, OP_REBOOT, OP_HALT, OP_CB };
 
 extern int tracing_pid;
 
--- a/arch/um/kernel/tt/exec_user.c	2004-11-11 19:43:38.511182056 +0100
+++ b/arch/um/kernel/tt/exec_user.c	2004-11-11 19:50:41.288910072 +0100
@@ -16,6 +16,7 @@
 #include "kern_util.h"
 #include "user.h"
 #include "ptrace_user.h"
+#include "os.h"
 
 void do_exec(int old_pid, int new_pid)
 {
@@ -36,7 +37,7 @@ void do_exec(int old_pid, int new_pid)
 		tracer_panic("do_exec failed to get registers - errno = %d",
 			     errno);
 
-	kill(old_pid, SIGKILL);
+	os_kill_ptraced_process(old_pid, 0);
 
 	if (ptrace(PTRACE_SETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		tracer_panic("do_exec: PTRACE_SETOPTIONS failed, errno = %d", errno);
--- a/arch/um/kernel/tt/process_kern.c	2004-11-11 20:03:15.852199016 +0100
+++ b/arch/um/kernel/tt/process_kern.c	2004-11-11 21:03:59.624261464 +0100
@@ -82,7 +82,7 @@ void *switch_to_tt(void *prev, void *nex
 	prev_sched = current->thread.prev_sched;
 	if((prev_sched->state == TASK_ZOMBIE) ||
 	   (prev_sched->state == TASK_DEAD))
-		os_kill_ptraced_process(prev_sched->thread.mode.tt.extern_pid, 1);
+		request_kill_ptraced_process( prev_sched->thread.mode.tt.extern_pid, 1);
 
 	/* This works around a nasty race with 'jail'.  If we are switching
 	 * between two threads of a threaded app and the incoming process 
@@ -119,7 +119,7 @@ void release_thread_tt(struct task_struc
 	int pid = task->thread.mode.tt.extern_pid;
 
 	if(os_getpid() != pid)
-		os_kill_process(pid, 0);
+		request_kill_ptraced_process(pid, 0);
 }
 
 void exit_thread_tt(void)
@@ -330,10 +330,10 @@ void kill_off_processes_tt(void)
 	me = os_getpid();
         for_each_process(p){
 		if(p->thread.mode.tt.extern_pid != me) 
-			os_kill_process(p->thread.mode.tt.extern_pid, 0);
+			request_kill_ptraced_process(p->thread.mode.tt.extern_pid, 2);
 	}
 	if(init_task.thread.mode.tt.extern_pid != me) 
-		os_kill_process(init_task.thread.mode.tt.extern_pid, 0);
+		request_kill_ptraced_process(init_task.thread.mode.tt.extern_pid, 2);
 }
 
 void initial_thread_cb_tt(void (*proc)(void *), void *arg)
@@ -352,6 +352,20 @@ void initial_thread_cb_tt(void (*proc)(v
 	}
 }
 
+void request_kill_ptraced_process(int pid, int mode)
+{
+	/* The tracer has to do the kill, since killing must be
+	 * done with ptrace(PTRACE_KILL, pid), which is possible
+	 * from the father only! */
+	current->thread.request.op = OP_KILL;
+	current->thread.request.u.exec.pid = pid;
+	current->thread.request.u.exec.mode = mode;
+	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
+
+	change_sig(SIGUSR1, 0);
+}
+
 int do_proc_op(void *t, int proc_id)
 {
 	struct task_struct *task;
@@ -374,6 +388,12 @@ int do_proc_op(void *t, int proc_id)
 	case OP_FORK:
 		attach_process(thread->request.u.fork.pid);
 		break;
+	case OP_KILL:
+		if ( thread->request.u.kill.mode > 1 )
+			os_kill_process(thread->request.u.kill.pid, 0);
+		os_kill_ptraced_process(thread->request.u.kill.pid,
+		                        thread->request.u.kill.mode);
+		break;
 	case OP_CB:
 		(*thread->request.u.cb.proc)(thread->request.u.cb.arg);
 		break;
--- a/arch/um/kernel/tt/include/mode-tt.h	2004-11-12 12:14:24.239057776 +0100
+++ b/arch/um/kernel/tt/include/mode-tt.h	2004-11-12 12:15:17.496961344 +0100
@@ -20,6 +20,7 @@ extern void reboot_tt(void);
 extern void halt_tt(void);
 extern int is_tracer_winch(int pid, int fd, void *data);
 extern void kill_off_processes_tt(void);
+extern void request_kill_ptraced_process(int pid, int mode);
 
 #endif
 
--- a/arch/um/kernel/reboot.c	2004-11-12 12:18:29.356794216 +0100
+++ b/arch/um/kernel/reboot.c	2004-11-12 12:19:20.996943720 +0100
@@ -22,7 +22,7 @@ static void kill_idlers(int me)
 	for(i = 0; i < sizeof(idle_threads)/sizeof(idle_threads[0]); i++){
 		p = idle_threads[i];
 		if((p != NULL) && (p->thread.mode.tt.extern_pid != me))
-			os_kill_process(p->thread.mode.tt.extern_pid, 0);
+			request_kill_ptraced_process(p->thread.mode.tt.extern_pid, 2);
 	}
 #endif
 }

--------------090402010602080506080204--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
