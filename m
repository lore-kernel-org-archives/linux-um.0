Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzKDA-0002rc-SH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 11:42:48 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzKD6-00033O-GR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 11:42:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xj7CCXUMCrm9Mxt"
Message-Id: <200502102041.37170.blaisorblade@yahoo.it>
Subject: [uml-devel] Cleanups about SYSEMU_SINGLESTEP / fixes about
	sysaudit-singlestep-umlhost
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
Date: Thu, 10 Feb 2005 20:41:36 +0100
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_xj7CCXUMCrm9Mxt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, the first thing is the cleanup of PTRACE_SYSEMU_SINGLESTEP. I've carefully 
moved the handling to go near to PTRACE_SINGLESTEP. As said, it's needed also 
to port this stuff to 2.6.10 easily (wrt the introduction of 
{clear,set}_singlestep).

The patch is attached both with only my changes, to go on top of the 
add-SYSEMU_SINGLESTEP one, and in the merged form. They are both for 2.6.9.

I'm also going to release both 2.6.9-V8-rc2 and 2.6.10-V8-rc2 with this stuff.

I also added a patch about mm->dumpable (still in doubt whether to merge it).

Second thing: I've analyzed sysaudit-singlestep-umlhost.... the important 
thing is #2 below.

1) there is some moving around of do_syscall_trace vars, which I've merged in 
my cleanup (it's needed for item #3, however it's nice anyway); so I've 
modified and reattached it.

2) I guess that the ptrace_disable() change (which clears TIF_SYSCALL_TRACE  
and TIF_SYSCALL_EMU) is just cosmetical.

I verified that in kernel/ and arch/i386/kernel the only caller is 
ptrace_detach (as the comment says), which later clears child->ptrace through 
__ptrace_unlink.

Since everything (I took this for granted) tests current->ptrace | PT_PTRACED, 
correctness should be ok.

It hurts a bit performance, however, because we don't run inside the syscall 
fastpath, and do one more conditional jump. We must discuss this with 
mainline, too.

3) a real fix for TIF_SYSCALL_AUDIT | TIF_SINGLESTEP, which is also correct 
when setting TIF_SYSCALL_EMU too (I had doubts about this, since I was 
missing that is_singlestep == 1 only for PTRACE_SINGLESTEP and not when doing 
PTRACE_SYSEMU_SINGLESTEP).

I want to merge it before 2.6.11.

We must in fact avoid to do the tracing for syscall entry, since 
TIF_SINGLESTEP does not trigger inside entry.S the syscall tracing (see the 
marked "testb" line below).

(around line 277 of arch/i386/kernel/entry.S):

ENTRY(system_call)
        pushl %eax                      # save orig_eax
        SAVE_ALL
        GET_THREAD_INFO(%ebp)
# system call tracing in operation / emulation


//in the mask _TIF_SINGLESTEP is not set !!! <<<<<<<<<<<<<<
        testb $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|
_TIF_SYSCALL_AUDIT),TI_flags(%ebp)


        jnz syscall_trace_entry
        cmpl $(nr_syscalls), %eax
        jae syscall_badsys
syscall_call:
        call *sys_call_table(,%eax,4)
        movl %eax,EAX(%esp)             # store the return value
syscall_exit:


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_xj7CCXUMCrm9Mxt
Content-Type: text/x-diff; charset="us-ascii";
	name="skas-SYSEMU_SINGLESTEP-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="skas-SYSEMU_SINGLESTEP-cleanup.patch"


1) Move around a couple of vars as done in the other Bodo's cleanup, which
requires it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c |   39 ++++++++------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~skas-SYSEMU_SINGLESTEP-cleanup arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.9/arch/i386/kernel/ptrace.c~skas-SYSEMU_SINGLESTEP-cleanup	2005-02-10 18:03:36.385950040 +0100
+++ vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c	2005-02-10 18:13:21.860944312 +0100
@@ -360,7 +360,6 @@ asmlinkage int sys_ptrace(long request, 
 		  break;
 
 	case PTRACE_SYSEMU: /* continue and stop at next syscall, which will not be executed */
-	case PTRACE_SYSEMU_SINGLESTEP: /* Same as SYSEMU, but singlestep if not syscall */
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		long tmp;
@@ -368,31 +367,20 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		/* prepare to reset single step bit */
-		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
-		}
-		else if (request == PTRACE_SYSEMU_SINGLESTEP) {
-			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-			set_tsk_thread_flag(child, TIF_SINGLESTEP);
-			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-			/* For SYSEMU_SINGLESTEP, set single step bit */
-			tmp |= TRAP_FLAG;
-		}
-		else if (request == PTRACE_SYSCALL) {
+		} else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
-		}
-		else {
+		} else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		}
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
+	/* make sure the single step bit is not set. */
+		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET,tmp);
 		wake_up_process(child);
 		ret = 0;
@@ -419,14 +407,21 @@ asmlinkage int sys_ptrace(long request, 
 		break;
 	}
 
+	case PTRACE_SYSEMU_SINGLESTEP: /* Same as SYSEMU, but singlestep if not syscall */
 	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
 		long tmp;
 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+
+		if (request == PTRACE_SYSEMU_SINGLESTEP)
+			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		else
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+
 		if ((child->ptrace & PT_DTRACE) == 0) {
 			/* Spurious delayed TF traps may occur */
 			child->ptrace |= PT_DTRACE;
@@ -601,7 +596,10 @@ out:
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu, is_singlestep;
+	int is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
+	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP */
+	int is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
+
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -610,14 +608,11 @@ int do_syscall_trace(struct pt_regs *reg
 		else
 			audit_syscall_exit(current, regs->eax);
 	}
-	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
 	/* If a process stops on the 1st tracepoint with SYSCALL_TRACE
 	 * and then is resumed with SYSEMU_SINGLESTEP, it will come in
 	 * here. We have to check this and return */
 	if (is_sysemu && entryexit)
 		return 0;
-	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP */
-	is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    !is_singlestep && !is_sysemu)
_

--Boundary-00=_xj7CCXUMCrm9Mxt
Content-Type: text/x-diff; charset="us-ascii";
	name="skas-add-SYSEMU_SINGLESTEP.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="skas-add-SYSEMU_SINGLESTEP.patch"


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
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c |   28 ++++++++++++++------
 vanilla-linux-2.6.9-paolo/include/linux/ptrace.h    |    1 
 2 files changed, 21 insertions(+), 8 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~skas-add-SYSEMU_SINGLESTEP arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.9/arch/i386/kernel/ptrace.c~skas-add-SYSEMU_SINGLESTEP	2005-02-10 19:49:52.577621568 +0100
+++ vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c	2005-02-10 19:50:05.294688280 +0100
@@ -370,12 +370,10 @@ asmlinkage int sys_ptrace(long request, 
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		}
-		else if (request == PTRACE_SYSCALL) {
+		} else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-		}
-		else {
+		} else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
@@ -409,14 +407,21 @@ asmlinkage int sys_ptrace(long request, 
 		break;
 	}
 
+	case PTRACE_SYSEMU_SINGLESTEP: /* Same as SYSEMU, but singlestep if not syscall */
 	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
 		long tmp;
 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+
+		if (request == PTRACE_SYSEMU_SINGLESTEP)
+			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		else
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+
 		if ((child->ptrace & PT_DTRACE) == 0) {
 			/* Spurious delayed TF traps may occur */
 			child->ptrace |= PT_DTRACE;
@@ -591,7 +596,10 @@ out:
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu, is_singlestep;
+	int is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
+	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP */
+	int is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
+
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -600,8 +608,11 @@ int do_syscall_trace(struct pt_regs *reg
 		else
 			audit_syscall_exit(current, regs->eax);
 	}
-	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
-	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
+	/* If a process stops on the 1st tracepoint with SYSCALL_TRACE
+	 * and then is resumed with SYSEMU_SINGLESTEP, it will come in
+	 * here. We have to check this and return */
+	if (is_sysemu && entryexit)
+		return 0;
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    !is_singlestep && !is_sysemu)
@@ -626,6 +637,7 @@ int do_syscall_trace(struct pt_regs *reg
 	if ( !is_sysemu )
 		return 0;
 
+	regs->orig_eax = -1; /* force skip of syscall restarting */
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(current, regs->eax);
 	return 1;
diff -puN include/linux/ptrace.h~skas-add-SYSEMU_SINGLESTEP include/linux/ptrace.h
--- vanilla-linux-2.6.9/include/linux/ptrace.h~skas-add-SYSEMU_SINGLESTEP	2005-02-10 19:49:52.579621264 +0100
+++ vanilla-linux-2.6.9-paolo/include/linux/ptrace.h	2005-02-10 19:49:52.582620808 +0100
@@ -21,6 +21,7 @@
 
 #define PTRACE_SYSCALL		  24
 #define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
_

--Boundary-00=_xj7CCXUMCrm9Mxt
Content-Type: text/x-diff; charset="us-ascii";
	name="sysaudit-singlestep-umlhost.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sysaudit-singlestep-umlhost.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Roland McGrath <roland@redhat.com>

This patch applies on top of SKAS/SYSEMU patches, however the bug it fixes is
of general relevance:

			/* With TIF_SYSCALL_AUDIT | TIF_SINGLESTEP we
			 * come in here, but must not continue with
			 * ptrace_notify()

In fact, we must avoid to do the tracing for syscall entry, since
TIF_SINGLESTEP does not trigger inside entry.S the syscall tracing (see the
testb line below):

(around line 277 of arch/i386/kernel/entry.S):

ENTRY(system_call)
        pushl %eax                      # save orig_eax
        SAVE_ALL
        GET_THREAD_INFO(%ebp)
# system call tracing in operation / emulation
#in the mask _TIF_SINGLESTEP is not set !!! <<<<<<<<<<<<<<
        testb $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
        jnz syscall_trace_entry
        cmpl $(nr_syscalls), %eax
        jae syscall_badsys
syscall_call:
        call *sys_call_table(,%eax,4)
        movl %eax,EAX(%esp)             # store the return value
syscall_exit:

So, it means that auditing a SINGLESTEP'ed process causes the tracer to get
one more trap on the syscall entry path, beyond the one on the syscall exit
path.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/ptrace.c~sysaudit-singlestep-umlhost arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.9/arch/i386/kernel/ptrace.c~sysaudit-singlestep-umlhost	2005-02-10 18:15:41.262752016 +0100
+++ vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c	2005-02-10 18:38:46.874107072 +0100
@@ -151,6 +151,8 @@ void ptrace_disable(struct task_struct *
 	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 	tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 	put_stack_long(child, EFL_OFFSET, tmp);
+	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 }
 
 /*
@@ -601,10 +603,20 @@ int do_syscall_trace(struct pt_regs *reg
 	int is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
 
 	if (unlikely(current->audit_context)) {
-		if (!entryexit)
+		if (!entryexit) {
 			audit_syscall_entry(current, regs->orig_eax,
 					    regs->ebx, regs->ecx,
 					    regs->edx, regs->esi);
+			/* With TIF_SYSCALL_AUDIT | TIF_SINGLESTEP &&
+			 * !TIF_SYSCALL_EMU we come in here, but must not
+			 * continue with ptrace_notify().
+			 * In the SINGLESTEP && ! _AUDIT case (i.e. normal one),
+			 * entry.S will call us only on syscall exit and not on
+			 * the syscall entry path, so let's be consistent.
+			 */
+			if (is_singlestep)
+				return 0;
+		}
 		else
 			audit_syscall_exit(current, regs->eax);
 	}
_

--Boundary-00=_xj7CCXUMCrm9Mxt--




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
