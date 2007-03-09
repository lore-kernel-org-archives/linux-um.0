Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HPmzO-00033I-RX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Mar 2007 13:51:03 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HPmzL-0007D3-Pr
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Mar 2007 13:51:02 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 9 Mar 2007 22:50:48 +0100
References: <20070131224504.GA7698@ccure.user-mode-linux.org>
	<20070305231044.GB9525@ccure.user-mode-linux.org>
	<200703060026.53253.blaisorblade@yahoo.it>
In-Reply-To: <200703060026.53253.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4ad8Fd/w6+qX3X8"
Message-Id: <200703092250.48861.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] x86_64 32-bit ptrace mangles sixth system
	call argument
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Cc: Jeff Dike <jdike@addtoit.com>

--Boundary-00=_4ad8Fd/w6+qX3X8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 06 March 2007 00:26, Blaisorblade wrote:
> On Tuesday 06 March 2007 00:10, Jeff Dike wrote:
> > On Tue, Mar 06, 2007 at 12:03:26AM +0100, Blaisorblade wrote:
> > > > No, RCX corruption is different - that happens when a sysexit is done
> > > > from a system call where userspace wasn't prepared to save and
> > > > restore RCX.  sigreturn is the best example.
> > >
> > > Hmm... we should finally fix that, at some point. Or... now that you
> > > explain it this way, it could even seem unfixable... is it? Or maybe
> > > sysreturn should become a syscall where the return must happen through
> > > the slow return path (iret), if that exists for x86_64.
> >
> > This is fixed, and has been for a while.  The fix was, as you suggest,
> > return through iret in this case.

Hmm, return through IRET is implemented for sys_rt_sigreturn since 2.6.0 (with 
a couple of changes, yeah, but...).

Was the original Bodo's report bogus? No, he actually found a much harder 
issue.

I've attached the log of that IRC here for reference.

> Also the 32bit emulation case? That would be interesting for SKAS with
> 64bit host and 32bit guest (which I haven't tested for a long time). Also
> this means that I could test the needed trivial fixes for 64 on 64 (like
> opening /proc/mm64, using PTRACE_EX_FAULTINFO which I introduced...).

I looked and it doesn't seem to have been fixed. Andi, can you give a look to 
this problem (sigreturn returning through iret and corrupting ECX for 32-bit 
processes)?

If I added in arch/x86_64/ia32/ia32_signal.c: sys32_sigreturn() a call to 
set_thread_flag(TIF_IRET), would that fix the problem?

I see no use of this in x86_64, even if this flag is defined and it is 
(implicitly) implemented in *entry.S - it is never mentioned but it is tested 
though _TIF_WORK_MASK / _TIF_ALLWORK_MASK, and separate stubs are used for 
execve and sigreturn. Is there a good reason not to use IRET there?

Bye
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_4ad8Fd/w6+qX3X8
Content-Type: text/plain;
  charset="iso-8859-1";
  name="Bodo_chat_saved"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Bodo_chat_saved"

[16:08:52] Canali in comune con bodo [~bo@217.115.74.14]: #uml
[16:09:02] <Blaisorblade> Hey, Bodo!
[16:09:51] <bodo> Hello Blaisorblade!
[16:09:59] <Blaisorblade> Ok, so?
[16:10:14] <Blaisorblade> I've tried guessing the problem:
[16:10:33] <Blaisorblade> But didn't found it...
[16:10:34] <bodo> Blaisorblade: First, let us check: entry.S on x86_64 isn't modified by the patch, true?
[16:10:43] <Blaisorblade> Exactly.
[16:11:16] <bodo> Blaisorblade: So, assume a process was scheduled out not on a syscall, but on a interrupt
[16:11:17] <Blaisorblade> But for 32-bit binaries the file to look at is ia32/ia32entry.S. And normal SKAS doesn't touch that file either.
[16:11:30] <Blaisorblade> Hmm, ok...
[16:11:44] <Blaisorblade> The interrupt handler will lazely share the MM.
[16:12:03] <bodo> Blaisorblade: now, assume when it is scheduled next, this will happen on a syscall done by the outgoing process
[16:12:17] <Blaisorblade> Ok.
[16:12:40] <bodo> Blaisorblade: in that case, RCX and R11 of the process will be destroyed
[16:12:55] <Blaisorblade> Hmm...
[16:13:22] <Blaisorblade> What is the difference between SKAS and normal processes?
[16:13:53] <bodo> Blaisorblade: SKAS does a UML context-switch while the host-process still is the same
[16:14:23] <bodo> this happens in SKAS0, too. In case of threads sharing the same mm
[16:14:25] <Blaisorblade> Yes, exactly... by "outgoing process" you refer to the UML one or the host one.
[16:14:38] <bodo> host one
[16:14:48] <bodo> err. UML one
[16:15:15] <Blaisorblade> Because UML will read the values saved by the interrupt handler context, right?
[16:15:34] <Blaisorblade> But is the interrupt handler preemptible?
[16:15:44] <bodo> yes. And *all* registers need to be restored. But this won't be done on a return from syscall
[16:16:24] <bodo> Blaisorblade: think of timer tick interrupting the process
[16:16:43] <Blaisorblade> You mean a host interrupt or a UML interrupt, i.e. a signal?
[16:17:32] <bodo> both.
[16:17:46] <bodo> think of a timer tick interrupting the host.
[16:18:12] <bodo> host see an timer running out and queues a SIGALRM for UML-process
[16:18:44] <bodo> on return from interrupt, this signal will be processed, so the UML kernel is started
[16:18:48] <Blaisorblade> Ok. A host interrupt must be finished before UML continues running, except on a multiprocessor host...
[16:19:22] <Blaisorblade> bodo: the UML kernel is started, it does the context switch, and the registers of the process have been saved somewhere on the host...
[16:19:23] <bodo> UML decides to schedule another process
[16:20:07] <bodo> and while the kernel runs, the user-process still is "in interrupt"
[16:20:37] <bodo> as so_signal is called before returning to user
[16:21:02] <Blaisorblade> bodo: Wait a moment: what you're describing is a race condition on ptrace()...
[16:21:02] <Blaisorblade> Anyhow, hardware interrupt *don't* send signals anywhere... they must schedule softirqs or something else to do the long work.
[16:21:09] <bodo> the host schedules out the user-process and schules the kernel-process
[16:21:20] <bodo> No, no race condition!!!
[16:21:36] <bodo> let's try again:
[16:21:46] <bodo> assume in UML process A is running
[16:21:50] <Blaisorblade> Wait a moment: where do you see the call to do_signal?
[16:21:59] <bodo> in the host
[16:22:13] <Blaisorblade> and where in the code?
[16:22:34] <Blaisorblade> In entry.S this isn't found.
[16:23:39] <Blaisorblade> Ok, found sysret_signal and do_notify_resume().
[16:23:57] <Blaisorblade> -> and do_signal.
[16:24:17] <bodo> retint_signal
[16:24:59] <bodo> May I try to explain better?
[16:25:06] <Blaisorblade> Ok, let me look...
[16:25:29] <Blaisorblade> Ok, go... I'm starting understanding the problem...
[16:25:52] <bodo> Let's assume, process A on UML is running
[16:26:18] <bodo> user-process is interrupted by a timer-tick
[16:26:27] <Blaisorblade> Yes, perfectly... And then it's interrupted by a host timer tick and a SIGALRM sent to UML which then schedules another process, right?
[16:26:40] <bodo> yes!!!
[16:27:34] <Blaisorblade> The problem is that in that point, PTRACE_GETREGS will access the interrupt values of the registers, while saving the registers for the old process, right?
[16:27:34] <bodo> now, UML's process is interrupt while *running*, that means, we have to save *all* regs and also to restore *all* regs later
[16:28:04] <bodo> Blaisorblade: yes, and that is OK. , as we will read all register values.
[16:28:28] <bodo> the problem will come up later
[16:28:39] <bodo> assume, now process B is running on UML
[16:28:44] <Blaisorblade> Ok, it will be later, so the values we read are correct.
[16:29:01] <bodo> process B does a syscall, that leads to process A being scheduled
[16:29:44] <bodo> A's registers are read in a "syscall-context", which is no problem
[16:29:51] <Blaisorblade> Hmm, ok, this means that we must restore all registers of process A...
[16:30:23] <Blaisorblade> bodo: You said that we interrupted A while it was inside the *interrupt* code...
[16:30:43] <bodo> but B's registers are written to a syscall-context, which is wrong, as RCX must contain return-address on syscall and R11 must contain RFLAGS
[16:31:31] <bodo> yes. we interrupted A while it was inside the *interrupt* code, but we bring it back in syscall-code --> ERROR
[16:31:58] <bodo> this is specific x86_64
[16:32:52] <bodo> I don't know, if this is *your* problem, but it is *one* problem
[16:34:10] <Blaisorblade> Hmm...
[16:34:31] <Blaisorblade> Ok, what I'm currently testing for now is support for 32-bit binaries...
[16:34:49] <bodo> AFAICS, Jeff also should see problems with sys_rt_sigreturn, if the process was interrupted while not doing a syscall
[16:35:22] <Blaisorblade> I.e. I mean 32-bit UML binaries, which run inside ia32entry.S...
[16:35:51] <Blaisorblade> Wait a moment: what's the problem about B's registers?
[16:36:16] <bodo> No problem about B, only about A
[16:36:48] <Blaisorblade> What I understood is that we restored our registers of process A, not the registers of the interrupt handler, thus preventing the interrupt handler from returning, right?
[16:37:24] <Blaisorblade> bodo: You said "B's registers are written to a syscall context, which is wrong, [.....]RCX[...] R11[...]"
[16:37:32] <bodo> the registers of the interrupt handler *are* A's registers
[16:37:53] <bodo> the problem is, on x86_64 a syscall *will* clobber RCX and R11
[16:38:21] <bodo> a syscall returns using SYSRET, while a interrupt returns using IRET
[16:39:28] <Blaisorblade> Well, wait a moment, the registers we(UML) saved with ptrace about A are the ones which were on A's stack, right?
[16:39:41] <bodo> yes.
[16:40:12] <Blaisorblade> And B is a UML process?
[16:40:16] <bodo> yes.
[16:40:42] <Blaisorblade> So B is doing a syscall which is captured by PTRACE_SYSCALL, hmmm, ok...
[16:40:52] <bodo> yes.
[16:41:43] <Blaisorblade> on x86_64 a syscall will *save* and clobber RCX and R11, right? And those values will be used by SYSRET.
[16:41:57] <bodo> yes.
[16:42:00] <Blaisorblade> The registers we read on A's stack were the ones from the userspace process before the syscall...
[16:42:26] <Blaisorblade> right?
[16:42:27] <bodo> yes. And RCX and R11 have to contain the previous value on resume
[16:43:13] <bodo> But we return from a syscall, that clobbers them
[16:43:56] <bodo> Unfortunately, I have no x86_64, so all this is from reading the source only.
[16:44:00] <Blaisorblade> Ok. In normal activity, or even TT or SKAS0, when process A is suspended the host saves again the registers, this time the ones from inside the current frame.
[16:44:29] <Blaisorblade> bodo: again, would this affect 32bit processes in your opinion?
[16:44:46] <Blaisorblade> They are handled by ia32entry.S, which is different.
[16:44:54] <bodo> Wait a moment, I'll try to find out
[16:46:49] <Blaisorblade> Well, what the hell! It seems that ia32 emulated syscalls through vsyscall page are done by either sysenter or syscall... while the ones in libc are done by int 0x80.
[16:47:57] <bodo> I see. At least SYSCALL method should be affected, maybe sysenter also, wait a moment
[16:48:55] <Blaisorblade> Ok, sysenter is enabled only if the vendor is INTEL. arch/x86_64/ia32/syscall32.c
[16:50:27] <Blaisorblade> So, this means that saving the registers of a tracee while it's in interrupt context will read the ones from syscall context, i.e. the one from userspace (except for a few clobbered ones). I.e. we return abruptly from the interrupt handler.
[16:51:08] <bodo> Maybe, vsyscall-page will repair all changed values, as for i386-programs, it has to look like a i386
[16:52:31] <bodo> What are the problems you see on your x86_64?
[16:52:48] <Blaisorblade> bodo: from looking at arch/i386/kernel/vsyscall-sysenter.S, it seems that a syscall done through sysenter will save and clobber some i386 registers...
[16:53:19] <Blaisorblade> bodo: the problem I see is IIRC a crash during boot...
[16:53:46] <Blaisorblade> with a BUG in mmap.c (or memory.c)...
[16:54:19] <Blaisorblade> For instance, a old 2.4 kernel spit out, some time ago:
[16:54:19] <Blaisorblade> 
[16:54:19] <Blaisorblade> VFS: Mounted root (ext2 filesystem) readonly.
[16:54:19] <Blaisorblade> Unable to load interpreter
[16:54:19] <Blaisorblade> Kernel panic: kernel BUG at memory.c:377!
[16:54:21] <bodo> Do you boot an UML/i386 or UML/x86_64
[16:54:27] <Blaisorblade> UML/i386...
[16:54:41] <Blaisorblade> I've not yet modified UML/x86_64...
[16:55:16] <bodo> UML/x86_64 isn't yet ready for SKAS3?
[16:55:37] <Blaisorblade> The changes are at least:
[16:55:37] <Blaisorblade> 1) use /proc/mm64
[16:55:37] <Blaisorblade> 2) use PTRACE_EX_FAULTINFO which also returns trap_no
[16:55:37] <Blaisorblade> 3) use trap_no
[16:55:37] <Blaisorblade> 4) do everything else that might be needed, which I must investigate.
[16:56:06] <Blaisorblade> For 4), I guess that there will be some SKAS specific code in sys-i386 or in sysdep, but I still must find out.
[16:57:11] <bodo> So, currently you use UML/i386 on a x86_64
[16:57:22] <Blaisorblade> Exactly...
[16:57:29] <bodo> and that crashes on boot
[16:57:52] <Blaisorblade> Yes... actually maybe I missed testing the last version but I think I did...
[16:58:37] <Blaisorblade> I'll post updated results on the status when I'll have time, but for now I must go back to more urgent stuff, sorry... I have to finish this by today...
[16:58:54] <Blaisorblade> Thanks for the help anyway, I'll save this chat and look more carefully after...
[16:59:12] <Blaisorblade> Anyhow, this is something which *can* be solved by fiddling with entry.S, right?
[16:59:47] <Blaisorblade> I'll understand it more fully when I'll have studied the SYSENTER and SYSCALL instructions, anyhow.
[17:00:28] <bodo> right. It should use int_ret_from_sys_call. which kind of syscall does the glibc on UML use?
[17:01:17] <bodo> and don't forget: I couldn't test anything, so maybe I'm totally wrong ...
[17:02:31] <Blaisorblade> Ok, I'll look at what happens... glibc inside UML uses int 0x80 however...
[17:02:43] <Blaisorblade> Because I mostly tested with a slack10...
[17:03:25] <Blaisorblade> Slackware 10.0, which has a old glibc... however maybe I tested with Sarge more recently... earlier tests didn't work for a double >> PAGE_SHIFT problem.

--Boundary-00=_4ad8Fd/w6+qX3X8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_4ad8Fd/w6+qX3X8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_4ad8Fd/w6+qX3X8--
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

