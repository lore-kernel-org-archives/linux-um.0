Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QvhDk-00035z-9v
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 03:00:08 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvhDh-0000ou-Tl
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 03:00:08 +0000
Date: Tue, 23 Aug 2011 03:59:44 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110823025944.GB2203@ZenIV.linux.org.uk>
References: <4E52B7F8.3050002@zytor.com>
	<CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
	<4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk>
	<4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<CA+55aFygGyi8HRr8wNVDw5xk46D5QDOhis18u2qV-9+h0-4ReA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFygGyi8HRr8wNVDw5xk46D5QDOhis18u2qV-9+h0-4ReA@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Aug 22, 2011 at 06:59:48PM -0700, Linus Torvalds wrote:

> And the system call restart should actually work fine too, because at
> syscall entry we save %ebp *both* in the slot for ebp and ecx when we
> enter the first time. So the second time, we'll re-load the third
> argument from ebp again, but that's fine - it's still going to be the
> right value. Yes? No?
> 
> However, I note that the cstar entrypont has a comment about not saving ebp:
> 
>  * %ebp Arg2    [note: not saved in the stack frame, should not be touched]
> 
> which sounds odd. Why don't we save it? If we take a signal handler
> there, don't we want %ebp on the kernel stack in pt_regs, in order to
> do everything right?

That's exactly because it's callee-saved.  amd64 doesn't build full
pt_regs on stack; there's a part built always (5 words needed for iret
to work + syscall number + rdi + rsi + rdx + rcx + rax + r8--r11) and
the rest of registers is not saved in regular cases.  Reason: as long
as what we are calling follows amd64 ABI, we are guaranteed that
values of rsp/rbp/rbx/r12--r15 will not change.  So we don't waste
cycles and stack space unless we need to.  Which is to say,
	* in fork/clone/vfork - there we want full pt_regs to copy it into
child's pt_regs.
	* in {rt_,}sigreturn - we don't care about the current contents of
those registers, but we want to set them.  Thus the full pt_regs on stack,
filled by sys_{rt_,}sigreturn() and these extra registers filled with
values from pt_regs.
	* execve() - we want all registers reset to know state after
sys_execve(), so it fills the full pt_regs and we get the extra regs filled
out of it.
	* sigaltstack() - there full pt_regs is an overkill, but we do want
userland sp.
	* signal delivery - we want these registers preserved across the
duration of handler and we can't depend on handler following ABI.  So we
fill the entire pt_regs, and copy it into sigcontext, to be eventually
picked up by sigreturn and reconstruct the entire state.
	* ptrace - we want to be able to read/modify *all* these guys.
So we fill the entire pt_regs, let ptrace play with it and read extra regs
back.  NOTE: ia32_cstar_tracesys() takes pains to prevent buggering ebp
there - we read the arg6 into r9, then swap it with ebp for duration of
that stuff.  So ptrace will see arg6 in regs.bp, but when it's time
to go into syscall the (possibly modified) value will end in r9.  Which
is how it's passed to C functions, so we are fine, but it'll be really
lost before we reach the userland.  However, on the way *OUT* we are not
that nice, and SETREGS/POKEUSER hitting us there will end up modifying
ebp.  Which will play hell on __kernel_vsyscall()...

Hell, you have done something very similar on alpha yourself...  As for
ebp, it doesn't make any sense to save it on stack - ia32_cstar_entry()
itself takes care of not stomping on it just fine and IRET path
(int_ret_from_sys_call) modifies rbp only if explicitly asked to do so...
Which is most likely where it hits the fan for uml.  Normally it wouldn't
hurt to ask PTRACE_PUTREGS to put into ebp the value we just got from
PTRACE_GETREGS.  However, it *does* hurt when it happens on the second
stop per syscall - i.e. when we are on the way out.  I'm not 100% sure
that this is what's going on (it's using PTRACE_SYSEMU, which is supposed
to avoid the second stop completely), but it looks like what I'm seeing...

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

