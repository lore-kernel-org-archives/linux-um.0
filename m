Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbOIK-000203-4g for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 11:40:56 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BbOIJ-0003Gz-EZ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 11:40:55 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Xlz0AvqMajdqf/Y"
Message-Id: <200406182049.59129.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] SYSEMU for 2.6.7
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
Date: Fri, 18 Jun 2004 20:49:59 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Laurent Vivier <LaurentVivier@wanadoo.fr>, roland <for_spam@gmx.de>



--Boundary-00=_Xlz0AvqMajdqf/Y
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm attaching the host patch, adapted a bit for 2.6.7. I'm sure it needs this 
change (it's just a case change to entry.S) but I didn't compile it yet... I 
checked the other file but there is no relevant change in 2.6.7.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_Xlz0AvqMajdqf/Y
Content-Type: text/x-diff; charset="us-ascii"; name="host-sysemu-2.6.7-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="host-sysemu-2.6.7-1.patch"

---

 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/entry.S       |    7 ++
 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ptrace.c      |   31 +++++++++-
 vanilla-linux-2.6.7-SKAS-paolo/include/asm-i386/thread_info.h |    2 
 vanilla-linux-2.6.7-SKAS-paolo/include/linux/ptrace.h         |    1 
 4 files changed, 40 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/entry.S~sysemu-2.6.7 arch/i386/kernel/entry.S
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/entry.S~sysemu-2.6.7	2004-06-18 14:23:23.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/entry.S	2004-06-18 14:29:22.000000000 +0200
@@ -280,6 +280,9 @@ ENTRY(system_call)
 	GET_THREAD_INFO(%ebp)
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
+					# system call emulation
+	testb $(_TIF_SYSCALL_EMU),TI_flags(%ebp)
+	jnz syscall_emu_entry
 					# system call tracing in operation
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
@@ -333,6 +336,10 @@ work_notifysig_v86:
 	call do_notify_resume
 	jmp restore_all
 
+	# perform syscall emulation
+syscall_emu_entry:
+	call do_syscall_emu
+	jmp syscall_exit
 	# perform syscall exit tracing
 	ALIGN
 syscall_trace_entry:
diff -puN arch/i386/kernel/ptrace.c~sysemu-2.6.7 arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/ptrace.c~sysemu-2.6.7	2004-06-18 14:28:54.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ptrace.c	2004-06-18 14:29:22.000000000 +0200
@@ -358,6 +358,7 @@ asmlinkage int sys_ptrace(long request, 
 		  }
 		  break;
 
+	case PTRACE_SCEMU: /* continue and replace next syscall */
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		long tmp;
@@ -365,6 +366,12 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
+		if (request == PTRACE_SCEMU) {
+			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		}
+		else {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		}
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
@@ -405,7 +412,7 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE|TIF_SYSCALL_EMU);
 		if ((child->ptrace & PT_DTRACE) == 0) {
 			/* Spurious delayed TF traps may occur */
 			child->ptrace |= PT_DTRACE;
@@ -605,3 +612,25 @@ void do_syscall_trace(struct pt_regs *re
 		current->exit_code = 0;
 	}
 }
+
+void do_syscall_emu(void)
+{
+	if (!test_thread_flag(TIF_SYSCALL_EMU))
+		return;
+	if (!(current->ptrace & PT_PTRACED))
+		return;
+	/* the 0x80 provides a way for the tracing parent to distinguish
+	   between a syscall stop and SIGTRAP delivery */
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
+
+	/*
+	 * this isn't the same as continuing with a signal, but it will do
+	 * for normal use.  strace only continues with a signal if the
+	 * stopping signal is not SIGTRAP.  -brl
+	 */
+	if (current->exit_code) {
+		send_sig(current->exit_code, current, 1);
+		current->exit_code = 0;
+	}
+}
diff -puN include/asm-i386/thread_info.h~sysemu-2.6.7 include/asm-i386/thread_info.h
--- vanilla-linux-2.6.7-SKAS/include/asm-i386/thread_info.h~sysemu-2.6.7	2004-06-18 14:28:59.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/include/asm-i386/thread_info.h	2004-06-18 14:29:22.000000000 +0200
@@ -143,6 +143,7 @@ static inline unsigned long current_stac
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
+#define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
@@ -152,6 +153,7 @@ static inline unsigned long current_stac
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
+#define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
diff -puN include/linux/ptrace.h~sysemu-2.6.7 include/linux/ptrace.h
--- vanilla-linux-2.6.7-SKAS/include/linux/ptrace.h~sysemu-2.6.7	2004-06-18 14:29:05.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/include/linux/ptrace.h	2004-06-18 14:29:22.000000000 +0200
@@ -20,6 +20,7 @@
 #define PTRACE_DETACH		0x11
 
 #define PTRACE_SYSCALL		  24
+#define PTRACE_SCEMU		  31
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200

_

--Boundary-00=_Xlz0AvqMajdqf/Y--



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
