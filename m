Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJfLS-0002kR-SO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 14:47:10 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CJfLR-0000qB-TN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 14:47:10 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BoDdBYEb94s2m1t"
Message-Id: <200410182347.45862.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Fwd: Re: Security patches 1- 3
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
Date: Mon, 18 Oct 2004 23:47:45 +0200
To: user-mode-linux-devel@lists.sourceforge.net


--Boundary-00=_BoDdBYEb94s2m1t
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



----------  Forwarded Message  ----------

Subject: Re: Security patches 1- 3
Date: Monday 18 October 2004 23:20
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>

Jeff Dike wrote:
> bstroesser@fujitsu-siemens.com said:
>>Did you get my 4th patch, too?
>
> No, I just went looking for it, and I don't see it.
>
> Resend or tell me exactly when you sent it originally so I can make sure I
> don't have it, please.
>
> 				Jeff

I scanned my "Sent" box and found, that I have sent the mail to you and
 Paolo, but not to the list. It contained my test-tool for breakout and the
 patch, inlined and as attachments. But anyway, here it is again:

Now, I found two problems in the syscall-security patches that I have
 submitted.

The first is the old one:
Without that patch, in SKAS mode an process that has been singlestepped,
 can't be resumed with PTRACE_SYSCALL or PTRACE_CONT, but will continue to
 singlestep. The new patch fixes this and also does some cleanup.

The second problem is a bit more sophisticated, even if the new patch is very
 short. A part of the patch syscall-security-1 is dangerous. It is designed
 to let singlestepping over syscalls work correctly on a 2.6.7-SKAS-V5 host.
 Using that version as host system, syscalls with numbers greater than
 NR_syscalls are not intercepted while doing PTRACE_SYSCALL. Instead, the
 syscall returns immediately with result -ENOSYS. If such an syscall is
 traced with PTRACE_SYSCALL, while the user wants to singlestep, the next
 singlestep-trap will occur only after the next valid syscall. So I inserted
 a check for the syscall number into is_syscall() to let an invalid syscall
 be singlestepped.
But this is dangerous if a host uses a greater NR_syscalls than that, UML had
 been compiled with. Syscalls with numbers between the two NR_syscalls values
 could be started by UML processes and would than be executed on the host.
Also, I didn't realize, that if 2.4 or >= 2.6.9 is used as host, all syscalls
 are intercepted, no matter what syscall-number. And this should be the
 normal behaviour, since debuggers obviously want to see invalid syscalls,
 too.
And this normal behaviour is needed by UML, if someone wants to have an UML
running on a host with a lower NR_syscalls.
So, this patch removes the NR_syscalls-check from is_syscall() again, but I
 would instead like to have this patch

   
 http://linux.bkbits.net:8080/linux-2.5/cset@413f1c00MHeKsQfqBGA5McsDQ71Rmg?n
av=index.html

included in the next SKAS-host patch for 2.6.7 / 2.6.8 (has to be modified
 for sysemu anyway). I took the URL for one of Paolo's recent mailings.
 Inserting this would guarantee for singlestepping to work correctly under
 all circumstances without risk.

Bodo

-------------------------------------------------------



-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_BoDdBYEb94s2m1t
Content-Type: text/plain;
  charset="us-ascii";
  name="patch-security4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-security4"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

The patch syscall-security-3 is wrong (provided by me, sorry).
I missed, that singlestepping_skas() used to reset PT_DTRACE.
This was handled differently in tt and skas. With syscall-security-3
applied, a process in SKAS that singlestepped once continues to
singlestep until the next systemcall occurs, even if it is resumed
with PTRACE_CONT or PTRACE_SYSCALL.
This fix unifies the usage of PT_DTRACE in TT and SKAS. PT_DTRACE now
is set by ptrace(PTRACE_SINGLESTEP,...) and reset by singlestepping()
and it is evaluated in kern_do_signal().


Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


--- linux-2.6.9-rc2/arch/um/kernel/process_kern.c	2004-10-01 18:42:27.000000000 +0200
+++ linux-2.6.9-rc2-orig/arch/um/kernel/process_kern.c	2004-10-05 21:09:48.303849436 +0200
@@ -405,9 +405,15 @@
 {
 	struct task_struct *task = t ? t : current;
 
+	if ( ! (task->ptrace & PT_DTRACE) )
+		return(0);
+
+	task->ptrace &= ~PT_DTRACE;
+
 	if (task->thread.singlestep_syscall)
 		return(0);
-	return(task->ptrace & PT_DTRACE);
+
+	return 1;
 }
 
 /*
--- linux-2.6.9-rc2/arch/um/kernel/skas/syscall_kern.c	2004-10-01 18:28:35.000000000 +0200
+++ linux-2.6.9-rc2-orig/arch/um/kernel/skas/syscall_kern.c	2004-10-05 21:11:04.609239526 +0200
@@ -30,7 +30,6 @@
 
 	if(current->thread.singlestep_syscall){
 		current->thread.singlestep_syscall = 0;
-		current->ptrace &= ~PT_DTRACE;
 		force_sig(SIGTRAP, current);
 	}
 
--- linux-2.6.9-rc2/arch/um/kernel/tt/syscall_kern.c	2004-10-01 18:01:35.000000000 +0200
+++ linux-2.6.9-rc2-orig/arch/um/kernel/tt/syscall_kern.c	2004-10-05 21:11:30.088029008 +0200
@@ -32,7 +32,6 @@
 
 	if(current->thread.singlestep_syscall){
 		current->thread.singlestep_syscall = 0;
-		current->ptrace &= ~PT_DTRACE;
 		force_sig(SIGTRAP, current);
 	}
 
--- linux-2.6.9-rc2/arch/um/kernel/tt/process_kern.c	2004-10-01 18:36:17.000000000 +0200
+++ linux-2.6.9-rc2-orig/arch/um/kernel/tt/process_kern.c	2004-10-05 21:12:15.933452785 +0200
@@ -524,13 +524,6 @@
 		      -err);
 }
 
-void clear_singlestep(void *t)
-{
-	struct task_struct *task = t;
-
-	task->ptrace &= ~PT_DTRACE;
-}
-
 int start_uml_tt(void)
 {
 	void *sp;
--- linux-2.6.9-rc2/arch/um/kernel/tt/tracer.c	2004-10-01 18:33:30.000000000 +0200
+++ linux-2.6.9-rc2-orig/arch/um/kernel/tt/tracer.c	2004-10-05 21:13:12.106169916 +0200
@@ -331,7 +331,6 @@
 				tracing = 0;
 				if(do_syscall(task, pid))
 					sig = SIGUSR2;
-				else clear_singlestep(task);
 				break;
 			case SIGPROF:
 				if(tracing) sig = 0;
--- linux-2.6.9-rc2/arch/um/kernel/tt/include/tt.h	2004-10-01 18:34:01.000000000 +0200
+++ linux-2.6.9-rc2-orig/arch/um/kernel/tt/include/tt.h	2004-10-05 21:13:36.778092737 +0200
@@ -24,7 +24,6 @@
 extern int set_user_mode(void *task);
 extern void set_tracing(void *t, int tracing);
 extern int is_tracing(void *task);
-extern void clear_singlestep(void *t);
 extern void syscall_handler(int sig, union uml_pt_regs *regs);
 extern void exit_kernel(int pid, void *task);
 extern int do_syscall(void *task, int pid);

--Boundary-00=_BoDdBYEb94s2m1t
Content-Type: text/plain;
  charset="us-ascii";
  name="patch-security5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-security5"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Remove an unnecessary and even dangerous check in is_syscall()
The bug was inserted by my patch syscall-security-1.


Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


--- linux-2.6.9-rc4-mm1-org/arch/um/sys-i386/ptrace.c	2004-10-14 15:45:12.000000000 +0200
+++ linux-2.6.9-rc4-mm1-new/arch/um/sys-i386/ptrace.c	2004-10-18 18:52:27.130413618 +0200
@@ -28,8 +28,7 @@ int is_syscall(unsigned long addr)
 		       addr);
 		return(0);
 	}
-	return( (instr == 0x80cd || instr == 0x340f) &&
-	        PT_REGS_EAX(&current->thread.regs) < NR_syscalls);
+	return(instr == 0x80cd || instr == 0x340f);
 }
 
 /* determines which flags the user has access to. */

--Boundary-00=_BoDdBYEb94s2m1t--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
