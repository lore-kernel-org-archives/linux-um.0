Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fh70N-0006x7-P2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 May 2006 08:35:07 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fh70N-0001aY-Qj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 May 2006 08:35:07 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fh70K-0001LN-8k
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 May 2006 08:35:07 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] RFC allow PTRACE_SYSCALL to selectively skip
	syscalls
References: <Pine.LNX.4.58.0605111220070.664@ucontrol.mobiledns.com>
	<200605170820.30922.blaisorblade@yahoo.it>
	<Pine.LNX.4.58.0605171020350.664@ucontrol.mobiledns.com>
In-Reply-To: <Pine.LNX.4.58.0605171020350.664@ucontrol.mobiledns.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jGdbEDZ3NqfdjA8"
Message-Id: <200605191609.39884.blaisorblade@yahoo.it>
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
Date: Fri, 19 May 2006 16:09:39 +0200
To: Steven James <pyro@linuxlabs.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Charles P. Wright" <cwright@cs.sunysb.edu>

--Boundary-00=_jGdbEDZ3NqfdjA8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 17 May 2006 16:45, Steven James wrote:
> On Wed, 17 May 2006, Blaisorblade wrote:
> > On Saturday 13 May 2006 19:40, Steven James wrote:
> > > Greetings,
> > >
> > > I have been working on a few experimental system calls using a ptrace
> > > mechanism similar to UML to implement the calls. Naturally this lead me
> > > to look at PTRACE_SYSEMU vs. PTRACE_SYSCALL. Since the extra system
> > > calls are implemented entirely by the ptrace thread it seems a shame to
> > > take the context switch on entry and exit from the call. In some cases,
> > > I need to also implement a few of the standard Linux kernel calls in
> > > the ptrace thread as well, based on parameters of the call (for
> > > example, writes to specific open files).
> > >
> > > The patch below for x86_64 implements a scheme where a ptraced system
> > > call is skipped if the ptrace thread sets a return value (in RAX) when
> > > it handles the syscall entry. Otherwise things proceed normally.

> > Just to make things clearer: is this a different API than SYSEMU to do
> > the same thing, as it seems? If so, is it faster by any way, or just more
> > elegant in your opinion, or what? I think it's as fast as SYSEMU since
> > you must switch to the tracer on the syscall entry, look at params, set
> > the result and switch back with a ptrace call, with PTRACE_SYSEMU in my
> > case, with PTRACE_SYSCALL (?) in your case.

> It's no faster than SYSEMU and it's not necessarily any more elegant.

Ok

> > The current problem with PTRACE_SYSEMU is that you decide whether you'll
> > skip the syscall before looking at parameters (other people have already
> > complained about this). If this is the problem you have, I'll recover the
> > past discussions and let you know.

> That's exactly the problem I had. The emulator can't decide if it wants to
> handle the call itself or let the Linux kernel do it until it knows what
> syscall it is and in some cases the parameters.

> My objective in the patch was to fix that with minimal changes to the
> kernel. I did x86_64 first because I had one that was more convieniant for
> me to reboot at the time :-)

Fine then.

> > > A similar change is even easier on i386 since the needed logic is
> > > already in entry.S for SYSEMU.
> > >
> > > I chose changing RAX as the trigger since that is otherwise a useless
> > > thing for a tracing thread to do at syscall entry.

> > What if the tracing thread must set -ENOSYS as the return value?

> That's a flaw in the way I'm doing it. I would have to change orig_rax to
> an invalid syscall number

or getpid(),as we do (dunno whether it makes any difference; but you're sure 
getpid is getpid, while an invalid number may become valid).

> and take the extra context switches. 

> An alternative would be to either add yet another process flag that is
> checked after the ptrace_notify in (do_)syscall_trace or change the
> behaviour of TIF_SYSCALL_EMU by checking it after ptrace_notify.

That is more or less my idea, however I've not had the time to work on it. 
Instead of changing the semantics we must add another option - I thought to 
use a ptrace option (the ones you set with PTRACE_SETOPTIONS), Charles Wright 
coded instead a PTRACE_CHECKEMU, but this is the concept.

So, I'm going to forward you the emails containing two patches:
*) PTRACE_CHECKEMU from Charles Wright
*) PTRACE_SYSCALL_MASK - to make the debugger be notified only of some 
syscalls; the only check is via syscall number though. It's unrelated to this 
but probably useful to you.

And I'm attaching my original version of the PTRACE_CHECKEMU thing 
> > @@ -644,16 +644,24 @@
> >                 send_sig(current->exit_code, current, 1);
> >                 current->exit_code = 0;
> >         }
> > +       if(regs->rax != -ENOSYS)
> > +               return 1;
> > +
> > +       return 0;
> >  }

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_jGdbEDZ3NqfdjA8
Content-Type: text/x-diff; charset="iso-8859-1"; name="sysemu-new-interface"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysemu-new-interface"

[RFC] SYSEMU: new more powerful behaviour

The current behaviour of SYSEMU allows switching between SYSEMU and SYSTRACE,
but the kind of performed tracing must be decided before allowing the process to
start a syscall.

Charles P. Wright expressed interest in "conditional emulation", i.e. he is
writing a filesystem emulator which needs to fully emulate only some syscalls (I
guess the filesystem-related ones, more or less).

Due to the current API, this cannot exploit the SYSEMU faster API.

What happens:
a) the process starts a syscall
b) the ptracer is resumed
c) it reads the syscall number and params, possibly modifies them (in UML, this
is used to avoid syscall execution, when SYSEMU is not available), and then
resumes the process
d) depending on the state at step a), the syscall is either skipped totally, or
it is executed, leading to another ptracer resumption at the end moment.

What Charles would need:
a), b) and c): the same thing
d) the syscall is executed or skipped depending not on the state at step a), but
on the resumption command used at step c, after examining the syscall type.

It turns out that the following simple patch should implement his idea.
I've added a new ptrace option for the desired behaviour.

The current one is left unaltered, for UML use - switching to the new one would
leave existing binaries unsupported and, for UML, using the new API would need
careful testing for some edge cases (especially singlestepping) for some
details.

Testing is currently needed. I'd like to get a simple test program which uses
the syscall, but I've not right now the time to support this.

CC: Charles P. Wright <cwright@cs.sunysb.edu>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.git.orig/arch/i386/kernel/ptrace.c
+++ linux-2.6.git/arch/i386/kernel/ptrace.c
@@ -779,6 +779,12 @@ int do_syscall_trace(struct pt_regs *reg
 		current->exit_code = 0;
 	}
 	ret = is_sysemu;
+	// XXX: fix name
+	if (current->ptrace & PT_SYSEMU_CHOICE) {
+		/* The debugger might have changed the syscall intercepting mode. Apply
+		 * this update now, rather than at next syscall. */
+		ret = test_thread_flag(TIF_SYSCALL_EMU);
+	}
 out:
 	if (unlikely(current->audit_context) && !entryexit)
 		audit_syscall_entry(current, AUDIT_ARCH_I386, regs->orig_eax,
Index: linux-2.6.git/include/linux/ptrace.h
===================================================================
--- linux-2.6.git.orig/include/linux/ptrace.h
+++ linux-2.6.git/include/linux/ptrace.h
@@ -35,8 +35,10 @@
 #define PTRACE_O_TRACEEXEC	0x00000010
 #define PTRACE_O_TRACEVFORKDONE	0x00000020
 #define PTRACE_O_TRACEEXIT	0x00000040
+#define PTRACE_O_SYSEMUCHOICE	0x00000080
 
-#define PTRACE_O_MASK		0x0000007f
+/* Mask of valid codes - all the above must be or'ed here. */
+#define PTRACE_O_MASK		0x000000ff
 
 /* Wait extended result codes for the above trace options.  */
 #define PTRACE_EVENT_FORK	1
@@ -64,8 +66,14 @@
 #define PT_TRACE_VFORK_DONE	0x00000100
 #define PT_TRACE_EXIT	0x00000200
 #define PT_ATTACHED	0x00000400	/* parent != real_parent */
+#define PT_SYSEMU_CHOICE	0x00000800
 
-#define PT_TRACE_MASK	0x000003f4
+#if 0
+#define PT_TRACE_MASK	0x00000bf4
+#endif
+/* All options flags - to be cleared when using setoptions. */
+#define PT_TRACE_MASK	(PT_TRACESYSGOOD|PT_TRACE_FORK|PT_TRACE_VFORK|PT_TRACE_CLONE| \
+		PT_TRACE_EXEC|PT_TRACE_VFORK_DONE|PT_TRACE_EXIT)
 
 /* single stepping state bits (used on ARM and PA-RISC) */
 #define PT_SINGLESTEP_BIT	31
Index: linux-2.6.git/kernel/ptrace.c
===================================================================
--- linux-2.6.git.orig/kernel/ptrace.c
+++ linux-2.6.git/kernel/ptrace.c
@@ -339,6 +339,9 @@ static int ptrace_setoptions(struct task
 	if (data & PTRACE_O_TRACEEXIT)
 		child->ptrace |= PT_TRACE_EXIT;
 
+	if (data & PTRACE_O_SYSEMUCHOICE)
+		child->ptrace |= PT_SYSEMU_CHOICE;
+
 	return (data & ~PTRACE_O_MASK) ? -EINVAL : 0;
 }
 

--Boundary-00=_jGdbEDZ3NqfdjA8--

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
