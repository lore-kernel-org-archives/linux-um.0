Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QvtsG-0005Jk-8m
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:30:48 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvtsF-00057z-3d
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:30:48 +0000
Date: Tue, 23 Aug 2011 17:30:10 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110823163010.GE2203@ZenIV.linux.org.uk>
References: <4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk>
	<4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<20110823142608.GB12669@aftab>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110823142608.GB12669@aftab>
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
To: Borislav Petkov <bp@amd64.org>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>

On Tue, Aug 23, 2011 at 04:26:08PM +0200, Borislav Petkov wrote:
> On Tue, Aug 23, 2011 at 02:15:31AM -0400, Al Viro wrote:
> > Almost, but not quite.  What happens is:
> > * process hits syscall insn
> > * it's stopped and tracer (guest kernel) does GETREGS
> > 	+ looks at the registers (mapped to the normal layout)
> > 	+ decides to call sys_brk()
> > 	+ notices pages to kick out
> > 	+ queues munmap request for stub
> > * tracer does SETREGS, pointing the child's eip to stub and sp to stub stack
> > * tracer does CONT, letting the child run
> > * child finishes with syscall insn, carefully preserving ebp.  It returns to
> >   userland, in the beginning of the stub.
> > * child does munmap() and hits int 3 in the end of stub.
> > * the damn thing is stopped again.  The tracer had been waiting for it.
> > * tracer finishes with sys_brk() and returns success.
> > * it does SETREGS, setting eax to return value, eip to original return
> > address of syscall insn... and ebp to what it had in regs.bp.  I.e. the
> > damn arg6 value.
> 
> Ok, stupid question: can a convoluted ptracing case like this be created
> in "normal" userspace, i.e. irrespective of UML and only by using gdb,
> for example?

I don't know...

> I.e., from what I understand from above, you need to stop the tracee at
> syscall and "redirect" it to the stub after it finishes the syscall so
> that in another syscall it gets a debug exception... sounds complicated.

Basically, we need to do things that tracer can't do via ptrace() - i.e.
play with mappings in the child.  I.e. we need to do several syscalls
in child, then return it to traced state.  And all of that - before we
return to execution of instructions past the syscall.

BTW, booting 32bit uml with nosysemu on such boxen blows up instantly, since
there we have *all* SETREGS done on the way out of syscall (with sysemu we
use PTRACE_SYSEMU, which will stop on syscall entry, let you play with
registers and suppress both the sys_...() call itself and the stop on
the way out; without sysemu it'll use PTRACE_SYSCALL, replace syscall
number with something harmless (getpid(2)), let it execute, stop on
the way out and update the registers there).  Same issue, only here it
really happens from within the syscall handler itself.

Hell knows...  I have no idea what kind of weirdness ptrace users exhibit.
FWIW, I suspect that there's another mess around signals in uml - signal
frame is built by tracer and it *has* to contain ebp.  And have eip pointing
to insn immediately past the syscall.  What should sigreturn do?  It got
to restore ebp - can't rely on signal handler not having buggered the
register.  And we are again in for it - ebp set to arg6 as we return to
insn right after syscall one.

OTOH, making GETREGS/PEEKUSER return registers without arg2 -> ecx, arg6 -> ebp
would instantly break both uml and far less exotic things.  strace(1), for
one.  Anything that wants to examine the arguments of stopped syscall will
be broken.

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

