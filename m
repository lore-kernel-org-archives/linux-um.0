Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFx47-000684-ID for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 08:53:55 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CFx42-0004Bv-Uo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 08:53:55 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel panic: check_ptrace : child exited with status
	0x100
References: <200410081159.i98Bxgr03954@trolli.pdb.fsc.net>
In-Reply-To: <200410081159.i98Bxgr03954@trolli.pdb.fsc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410081745.10551.blaisorblade_spam@yahoo.it>
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
Date: Fri, 8 Oct 2004 17:45:10 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: bodo.stroesser@fujitsu-siemens.com, Lars.Ellenberg@linbit.com, jdike@addtoit.com

On Friday 08 October 2004 13:59, bodo.stroesser@fujitsu-siemens.com wrote:
> caker@theshore.net said:
> > Ok, so a new combination.  This is 2.4.27 + 2.4.26-um + all the
> > incremental + Bodo's sysemu-panic patch.  It works fine on non-sysemu
> > hosts, and on a host with the original version of sysemu.
> >
> > I think the key here is that this host has the latest (v5) SKAS patch,
> > whereas the 2.6.7 host kernel used the standard sysemu patch.

> Please note, my knowledge about this only comes from reading the source
> code only. Thus, if I'm wrong, tell me.
>
> AFAICS, the behavior of the latest skas patches for 2.4 and 2.6 regarding
> sysemu is *very* different. And I believe, the 2.6 is wrong!
I have some problems on 2.6 hosts with SYSEMU, too. So I've been trying to 
find what's the difference between 2.4 and 2.6 hosts.

> Problem:

> On both host versions a process will stop, if it is started with
> PTRACE_SYSEMU and if it tries to execute a systemcall. But what happens
> with the traced systemcall when it is resumed differs between the two host
> versions.

> On host 2.4 the syscall will immediately return to user presenting the
> result that had been written to the stack via ptrace(). This is done no
> matter if the process is resumed with PTRACE_SYSEMU, PTRACE_SYSCALL,
> PTRACE_SINGLESTEP or PTRACE_CONT.

> On host 2.6 the syscall will immediately 
> return to user only if the process is restarted with PTREACE_SYSEMU! In the
> other cases the syscall will be executed on the host, the result from this
> will overwrite the result written via ptrace().

In fact, my problem is that UML crashes only on 2.6 hosts when I disable the 
use of SYSEMU at runtime (possible IIRC on 2.6.9-rc2, by "echo 0 
> /proc/sysemu).

This happened even with the original SYSEMU patch, however, but I think 
LaurentVivier+roland host sysemu was correct for the problem you describe; so 
I'm not able to understand which is the problem.

That patch, actually, suffers from this bug:

-               clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+               clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE|
TIF_SYSCALL_EMU);

Actually, clear_tsk_thread_flag does not take a bitmask, so this code is 
wrong. But this is invoked only on PTRACE_SINGLESTEP.

> The check for host's 
> sysemu-support done in UML differs between the sysemu-patches for UML-2.4
> and UML-2.6:

Which trees are you using? The 2.6.8.1-1um + incremental tree and 2.4 tree 
contain the guest SYSEMU implementation from Jeff Dike, which has some 
differences from the original one included in 2.6.9-rc2. For instance, the 
original one has not got the 1st bug you identified when running on a 
SYSEMUless host. From what you describe

> - In UML-2.4 "getpid()" is written as result (eax) of the systemcall, which
> fakes the syscall-result on a 2.4-host,
I.e., the 2.4 behaviour is correct.
> but does nothing on a 2.6, where it 
> again is overwritten by running the syscall on the host!
So the patch below for SKAS is needed.
> Thus, a UML-2.4 
> will run on hosts with sysemu-support only, if it is a 2.4 host!
If the host != 2.4 it won't use sysemu, correct?

> - In UML-2.6 "getpid()" is written to the number of the systemcall! But the
> result in eax is not written, it still contains the original syscall
> number. On a 2.4-host this number is returned. In most cases this will let
> the further checks in UML succeed, but no guarantee...

I.e. you mean that this code (which is only in the 2.6/2.4 Jeff Dike tree)

+               n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
+                          os_getpid());
(which writes the return code value) is not the same as this code (which is in 
the 2.6.9-rc2 and following kernels):

               if (ptrace(PTRACE_GETREGS, pid, 0, &regs) < 0)
                        panic("check_ptrace : failed to read child "
                              "registers, errno = %d", errno);
                regs.orig_eax = pid;
                if (ptrace(PTRACE_SETREGS, pid, 0, &regs) < 0)
                        panic("check_ptrace : failed to modify child "
                              "registers, errno = %d", errno);
(which writes to orig_eax, i.e. the syscall number)? I guess that they are 
actually different, but in this case I think that the correct code is the one 
found in the first case, i.e. in the jdike kernel tree. But I thought you 
used the jdike 2.6.8.1-1um kernel tree.

So using the jdike code in both kernels (for the guest problem) and the patch 
below for the host should solve all the issues, right?

>   On a 2.6-host the systemcall with the faked number now will be processed
> on the host. In most cases the number should be invalid, thus the result is
> -ENOSYS, the checks in UML will succeed. But what happens, if the faked
> syscall number is a number known on the host ...

>   Thus a UML-2.6 will run on all host versions (in most cases ...)

Please clarify what you mean by "a certain UML will run only on certain 
hosts". You mean a SYSEMU patched UML will use SYSEMU only on certain hosts, 
right?

> Solution:

> - the host-patch for 2.6 should be modified. Before calling ptrace_notify()
>   do_syscall_trace() should save the state of the PTRACE_SYSEMU
> (true/false) and should use that saved state as return value.

Yes! Oh what fucking error! Is this patch correct (it's cut and paste, so you 
may apply it by hand)?

--- 
vanilla-linux-2.6.7-SKAS/arch/i386/kernel/ptrace.c~fix-sysemu-when-changing-state   
2004-10-08 17:08:03.992893504 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ptrace.c    2004-10-08 
17:08:59.626435920 +0200
@@ -585,6 +585,7 @@ out:
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
+       int is_sysemu;
        if (unlikely(current->audit_context)) {
                if (!entryexit)
                        audit_syscall_entry(current, regs->orig_eax,
@@ -593,8 +594,9 @@ int do_syscall_trace(struct pt_regs *reg
                else
                        audit_syscall_exit(current, regs->eax);
        }
+       is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);

-       if (!test_thread_flag(TIF_SYSCALL_TRACE) 
&& !test_thread_flag(TIF_SYSCALL_EMU))
+       if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
                return 0;
        if (!(current->ptrace & PT_PTRACED))
                return 0;
@@ -613,5 +615,5 @@ int do_syscall_trace(struct pt_regs *reg
                current->exit_code = 0;
        }
        /* != 0 if nullifying the syscall, 0 if running it normally */
-       return test_thread_flag(TIF_SYSCALL_EMU);
+       return is_sysemu;
 }



> - check_sysemu() in UML-2.6 should be modified to write the result, not the
> sycall number. And it should do it in a portable way.

> By the way: it is not enough to change the checks only. The 2.6-host's
> behavior will cause problems as well, if a process in UML is singlestepped.
> And there will be problems, if someone switches off sysemu while UML is
> running.
In fact, as I said above.
> Bodo

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
