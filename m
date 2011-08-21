Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QvB5s-0008B6-Ms
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2011 16:41:52 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvB5p-0006Aq-9A
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2011 16:41:52 +0000
Date: Sun, 21 Aug 2011 17:41:24 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110821164124.GL2203@ZenIV.linux.org.uk>
References: <20110820011845.GC2203@ZenIV.linux.org.uk> <4E4FD12F.70508@nod.at>
	<20110820201406.GF2203@ZenIV.linux.org.uk>
	<4E501F51.9060905@nod.at>
	<CAObL_7FoPHu6AKneswjEmiU4UBjUuKpYahakOaTNXM3=ZCpYaA@mail.gmail.com>
	<CAObL_7H8E1fde-d_Kfjrg2mQ5PdAp9X=fVRTqXJKzzYmQ1vAQQ@mail.gmail.com>
	<20110821063443.GH2203@ZenIV.linux.org.uk>
	<20110821084230.GI2203@ZenIV.linux.org.uk>
	<CAObL_7GXyzAzNjBtgye9BwXLyHm337oBTdjRDjbSPqoKZGWyyA@mail.gmail.com>
	<20110821144352.GJ2203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110821144352.GJ2203@ZenIV.linux.org.uk>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] SYSCALL,
 ptrace and syscall restart breakages (Re: [RFC] weird crap with
 vdso on uml/i386)
To: Andrew Lutomirski <luto@mit.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Aug 21, 2011 at 03:43:52PM +0100, Al Viro wrote:

> We do not lie to ptrace and iret.  At all.  We do just what you have
> described.  And fuck up when restart returns us to the SYSCALL / SYSENTER
> instruction again, which expects the different calling conventions,
> so the values arranged in registers in the way int 0x80 would expect
> do us no good.

FWIW, what really happens (for 32bit task on amd64) is this:
	* both SYSCALL and SYSENTER variants of __kernel_vsyscall are
entered with the same calling conventions; eax contains syscall number,
ebx/ecx/edx/esi/edi/ebp contain arg1..6 resp.  Same as what int 0x80
would expect.
	* they arrange slightly different calling conventions for
actual SYSCALL/SYSENTER instructions.  SYSENTER one: ecx and edx saved
on user stack to undo the effect of SYSEXIT clobbering them, arg6 (from
ebp) pushed to stack as well (for kernel side of SYSENTER to pick it
from there) and userland esp copied to ebp (SYSENTER clobbers esp).
SYSCALL one: arg6 (from ebp) pushed to stack (again, for kernel to pick
it from there), arg2 (from ecx) copied to ebp (SYSCALL clobbers ecx).
Then we hit the kernel.
	* Both codepaths start with arranging the same thing on the kernel
stack frame; one 64bit int 0x80 would create.  For the good and simple
reason: they all have to be able to leave via IRET.  Stack layout is the
same, but we need to fill it accordingly to calling conventions we are
stuck with.  I.e. ->cx should be initialized with arg2 and ->bp with
arg6, wherever those currently are on given codepath.  _That_ is what
"lying to ptrace" is about - we store there registers according to how
they were when we entered __kernel_vsyscall(), not as they are at the
moment of actual SYSCALL insn.  Which is precisely the right thing to do,
since if we *are* ptraced, the tracer expects to find the syscall argument
in the same places, whichever variant of syscall tracee happens to be using.
	* In both variants it means picking arg6 from userland stack; if
that pagefaults, we act as if we returned -EFAULT in normal way.  Again,
the value is stored in the expected place - ->bp, same as it would on int 0x80
path.
	* If we are traced, we grow the things on stack to full pt_regs,
including the callee-saved registers.  And call syscall_trace_enter(&regs).
If tracer decides to change registers, it can do so.  After that call we
restore the registers from pt_regs on stack and rejoin the corresponding
common codepath.
	* In both cases we reshuffle registers to match amd64 C calling
conventions; the only subtle part is that SYSCALL path has arg6 in r9d (and
ebp same as we had on entry, i.e. the original arg2, unaffected by whatever
ptrace might have done to regs->cx, BTW) while SYSENTER path has it in ebp,
same as int 0x80 one.  After reshuffling arg6 ends up r9 in all cases and
in all cases ptrace changes to regs->bp (aka where ptrace expects to see
arg6) do affect what's in r9.
	* The actual sys_whatever() is called in all cases.  If there's
any work to do after it (signals, still being traced, need to be rescheduled,
etc.), we go for the good old IRET path (after having cleaned r8--r12 in
pt_regs - IRET path is shared with 64bit and we don't want random kernel values
leaking to userland).
	* If there's no non-trivial work to do, int 0x80 *still* cleans
r8--r12 in pt_regs and goes for IRET path.  End of story for it.
	* In the same case, SYSENTER path will restore the contents of si and
di from pt_regs (bx is unaffected by sys_whatever(), ax holds return value
and cx/dx are going to be clobbered anyway; bp is not restored to the
conditions it had when hitting SYSENTER, but it's redundant - it was equal
to userland sp and *that* we do restore, of course).  r8--r11 are cleared
in actual CPU registers and off we bugger, back to vdso32.  Where we pop
ebp/ecx/edx and return to caller.  Note that syscall restart couldn't have
happened on that path - it would qualify as "work to do after syscall"
(specifically, signal handling) as we'd be off to IRET path.
	* In the same case, SYSCALL path will restore the contents of
si, di and dx from pt_regs (bx is unaffected by sys_whatever(), ax contains
the return value and bp is actually the same as it was on entry, after all
dances).  r8-r11 are cleaned in registers, cx is clobbered by SYSRET and
we are off to __kernel_vsyscall(), again.  This time back in there we
restore cx to what it used to be on entry to __kernel_vsyscall() [*NOTE*:
unaffected by ptrace manipulations; we probably don't care about that] and
restore bp (from stack).  We also restore %ss along the way, but that's
a separate story.  Again, no syscall restarts on that path.
	* If there *was* a syscall restart to be done, we are guaranteed to
have left via IRET path.  In all cases the syscall arguments end up in
registers, in the same way int 0x80 expected them.  What happens afterwards
depends on how we entered, though.
		+ int 0x80: all registers are restored (with ptrace
manipulations, if any, having left their effect) as they'd been the last
time around.  In we go and that's it.
		+ SYSENTER: return address had been set *not* to the
insn right next after SYSENTER when we'd been setting the stack frame
up.  That's the dirty trick Linus had come up with - return ip is set
to insn in vfso32 (SYSENTER loses the original ip for good, unlike SYSCALL
that would store it in cx, so it has to be at fixed location anyway).
Normally we just pop ecx/edx/ebp from stack and we are done.  However,
two bytes prior to that insn (i.e. where syscall restart would land us)
we have jump to just a bit before SYSENTER.  Namely, to the point where
we had copied esp to ebp.  That, combined with what IRET path has done,
will get us the layout SYSENTER expects once we get to SYSENTER again.
Except that ptrace modifications to arg6 will be lost - *ebp is where
SYSENTER picks it from and it's not updated.  Modified value is in ebp
on return from kernel and it's overwritten (with esp) and lost.  That's
ptrace vs. restarts bug I've mentioned in SYSENTER case.
		+ SYSCALL: buggered.  On restart we end up repeating
the call, with arg2 replaced with whatever had been in ebp when we
entered __kernel_vsyscall().  Simply because nobody cared to move it
from ecx (where IRET path has put it) to ebp (where SYSCALL expects
to find it).  ebp gets what used to be in arg6 (again, IRET path doing).
Oh, and ptrace modifications, if any, are lost as well - both in arg2
and in arg6.

	I *think* the above is an accurate description of what happens,
but I could certainly be wrong - that's just from RTFS of unfamiliar
and seriously convoluted code, so I'd very much appreciate ACK/NAK on
the analysis above from the people actually familiar with that thing...

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

