Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ChEdy-0003ob-NY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Dec 2004 14:07:42 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1ChEdw-00047D-JR for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Dec 2004 14:07:42 -0800
Message-ID: <41C9F025.60208@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Memory corruption/errors?
References: <63806.222.152.52.159.1103583370.squirrel@222.152.52.159>
	<41C9EF67.1030407@fujitsu-siemens.com>
In-Reply-To: <41C9EF67.1030407@fujitsu-siemens.com>
Content-Type: multipart/mixed; boundary="------------080400000209000904080109"
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
Date: Wed, 22 Dec 2004 23:07:33 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Carl <lists@outervoid.net>

This is a multi-part message in MIME format.
--------------080400000209000904080109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bodo Stroesser wrote:
> Carl wrote:
> 
>> Hi,
>>
>> Running the piece of code from the URL below is generating errors on
>> various UML kernels:
>>
>> http://downloads.rimuhosting.com/memtest.c
>>
>> Kernels tested are: 2.4.27, 2.4.27-bs1, 2.6.9-bb4.
>>
Sorry for forgetting to attach the testtool.
Here it is.

Bodo

>> Different UML host servers have been tried too, and only UMLs running on
>> SMP (dual Xeon) servers seem to have the problem (P4s with HT are fine).
>>
>> Can anyone else reproduce the errors? Any ideas?
>>
>> Thanks, Carl
> 
> 
> After having found a bug in SKAS-signal-handling, I modified memtest.c to
> trigger that bug (attached: memtest2.c). This probably is the same problem,
> Carl saw. If so, Carl's problem shouldn't happen in TT-mode.
> 
> 
> That's the problem:
> 
> In SKAS userspace(), when the kernel is entered, all regs including fpregs
> are saved by save_registers() to skas_regs and restored on exit by
> restore_registers() from skas_regs.
> If an signal handler has to be started, the original fpstate is saved in 
> the
> sigcontext and must be restored, when sys_sigreturn is called.
> When the kernel is entered for sys_sigreturn on return from the signal 
> handler,
> the fpregs again are saved with save_registers(). Thus skas_regs hold the
> fpstate from the end of the signal handler.
> Now copy_sc_from_user_skas() tries to restore the original state. But the
> fpstate from the sigcontext isn't written to skas_regs, but directly to the
> fp-registers of the userspace process with set_fpregs().
> When exit from kernel is done after that, restore_registers() overwrites
> the fp-registers of the userspace-process with the fpstate from skas_regs,
> which is the wrong one that comes from the signal handler!
> 
> There is another problem in UML-signal-handling, that makes the problem 
> very
> hard to reproduce:
> Normally, on sighandler-entry, the fpu-registers should be cleared. But UML
> doesn't clear the fpu. So, the original values in the fpu-registers stay
> alive, if the signal-handler doesn't push to many new values. In most
> cases, even if the sighandler uses the fpu, only the compare-result-flags
> have changed after return from sighandler. If fp-values have to be 
> compared,
> AFAICS an fp-compare-instruction is used, followed immediately by a move
> of the compare-result-flags to the ax-register. So, only a sighandler
> hitting exactly between those two instructions, will hurt in most cases!
> 
> 
> Solution:
> 
> I started to do a patch, but stopped, since it will need a big patch to
> make this area clean (and I will be offline for about 2 weeks ...):
> 
> 1) In SKAS, copy_sc_from_user_skas() should build the _fpstate in
>    sigcontext from skas_regs, not from new values read in by get_fpregs().
>    The current code even lacks writing i387_fsave_struct.status containing
>    the magic which flags the _fpstate format.
>    The "format" of the written _fpstate should depend on
>    have_fpx_regs. This means, convert_fxsr_to_user_tt() should be
>    modified and made generally available to help cover the case of
>    (have_fpx_regs == 1), where skas_regs don't contain fsave, but
>    fxsave only.
> 2) When having created a sigcontext, UML should clear the fpregs in
>    skas_regs resp. tt_regs.sc->_fpstate, to make the sighandler see
>    a cleared fpu.
> 3) copy_sc_from_user_skas() should copy the _fpstate from sigcontext
>    to skas_regs. To handle the different formats of the _fpstate,
>    convert_fxsr_from_user_tt() should be modified and made available.
>    copy_sc_from_user_skas() should check sigcontext->_fpstate. If
>    this is NULL, skas_regs.fp/fpx should be cleared. (SKAS doesn't
>    write that NULL, but on the host or in TT, the kernel sometimes
>    writes it. So, I would like to have SKAS tolerate a NULL here
>    instead of segfaulting).
> 4) set_fpregs, get_fpregs, set_fpxregs, get_fpxregs currently support
>    TT-mode only. set_fpxregs and get_fpxregs should return -EIO, if
>    (!have_fpx_regs). Therefore, the check for availability of
>    PTRACE_GET_FPXREGS should be done in SKAS and TT, and have_fpx_regs
>    should be available in both modes.
> 5) get_fpregs in TT mode simply should copy the first (fp-reg) part of
>    tt_regs.sc->fpstatus to user without converting. This part of fpstate
>    always is written correctly by the host kernel. Also set_fpregs has to
>    copy that part from user. If (have_fpx_regs == 1) the fpx-parts of
>    fpstatus should be reconstructed from that, to have them available for
>    the next possible get_fpxregs.
> 6) get_fpxregs and set_fpxregs in TT for (have_fpx_regs == 1) may work
>    immediately with the fpx-part of tt_regs.sc->fpstatus, but set_fpxregs
>    also has to write the fp-part accordingly.
> 7) get_fpregs, set_fpregs, get_fpxregs and set_fpxregs should support SKAS.
>    This could be done by simply ripping code or method from i386.
>    SKAS holds the data needed in skas_regs.fp or skas_regs.fpx
> 
> I hope, this helps a bit. Sorry for not having the time to do the patch
> by myself.
> 
> Bodo
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


--------------080400000209000904080109
Content-Type: text/plain;
 name="memtest2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memtest2.c"

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/time.h>

#define N (20*1024)

void sighdlr(int sig)
{
    double a;

    a = 256;

    double observed = a;
    double expected = 257;

    if ( observed == expected )
	printf("Error in sighdlr()\n");
}

int
main (void)
{
    size_t i, k;
    struct itimerval itimer = { { 0, 10000}, { 0, 10000} };

    signal(SIGALRM, sighdlr);
    setitimer( ITIMER_REAL, &itimer, NULL);

    for (k = 1; k < 1000; k++) {
	double *a = malloc (N * sizeof (double));
	if (a == 0) {
	    printf ("malloc failed at k=%u\n", k);
	    exit (1);
	}

	for (i = 0; i < N; i++) {
	    a[i] = (double) i;
	    double observed = a[i];
	    double expected = (double) i;
	    if (observed != expected) {
		printf ("failed at i=%u, k=%u (obs %.18g vs exp %.18g)\n", i, k,
		        observed, expected);
	    }
	}

	for (i = 0; i < N; i++) {
	    double observed = a[i];
	    double expected = (double) i;
	    if (observed != expected) {
		printf ("failed at i=%u, k=%u (obs %.18g vs exp %.18g)\n", i, k,
		        observed, expected);
//		exit (1);
	    }
	}
	free (a);
    }
    exit (0);
}

--------------080400000209000904080109--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
