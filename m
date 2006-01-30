Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F3Ww9-00085i-0e for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jan 2006 03:11:09 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1F3Ww5-0004ix-FN
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jan 2006 03:11:08 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS4 design question
References: <43CBF532.8020103@gmail.com>
	<200601201741.40602.blaisorblade@yahoo.it>
	<43D53584.9020707@gmail.com>
In-Reply-To: <43D53584.9020707@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601301209.10333.blaisorblade@yahoo.it>
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
Date: Mon, 30 Jan 2006 12:09:09 +0100
To: user-mode-linux-devel@lists.sourceforge.net, jcb62281@gmail.com

On Monday 23 January 2006 20:59, Jacob Bachmeyer wrote:
> Blaisorblade wrote:
> >On Thursday 19 January 2006 23:23, Jacob Bachmeyer wrote:
> >>Blaisorblade wrote:
> >>>On Thursday 19 January 2006 00:52, Jacob Bachmeyer wrote:

> >>>I.e. extend ptrace to trap lcall gates, right? That's another thing,
> >>> could be done, but it relates more to the Linux-ABI project... at least
> >>> this can't be merged in mainline since we don't support lcall gates.
> >>
> >>Why not?  And for that matter, why does ptrace not currently catch
> >> lcalls?
> >
> >The lcall stub was removed from arch/i386/kernel/entry.S a little time ago
> >(about 2.6.12 IIRC). So vanilla Linux can't handle lcalls. Clear now?

> Yes, the last time I looked into that part of the kernel was back in
> 2.4.  So, does this mean that lcalls can no longer be potentially used
> to escape from UML?

Yes, and IIRC that was also fixed directly time ago via LDT clearing, IIRC.

> >Yes, it is thought to be only an error path, but UML abuses of it for
> > normal control, and I said that the kernel supports "fasttrap", but only
> > via SIGSEGV, i.e. in a slow way.

> That is the exact problem.  It shouldn't be abused--a proper interface
> that has acceptable performance should be devised.  (You mention
> netlink--was it looked into?

No, and I while I mentioned netlink it's not an interface of which I've a deep 
knowledge. However it's being used for various things, including a proposed 
rewrite of the wireless API, and the already existing implementation of 
userspace packet filtering, so we can assume it has reasonable performance, 
momentum, user base and thus maintainance.

> This might help with some UML performance 
> issues.)

Possibly yes, but Ingo Molnar already designed a custom API for this purpose - 
it is grown up for UML usage.

> Basically what is needed is a means to set a page to no access 
> but cause some other action to occur rather than generate SIGSEGV.

> >>>We do that: make them unmapped and trap SIGSEGV through ptrace.
> >>
> >>The overhead is not all that large, as most Win32 API calls ultimately
> >>go into the kernel anyway.
> >
> >A kernel switch only costs about some thousands TSC units (see the rdtsc
> >assembly instruction), while a signal delivery to a foreign process can
> > cost a lot more (I measure it in the order of 4* 10^5 TSC units, even
> > without a memory switch).
>
> Then a more efficient interface is needed.  Besides, this would need to
> be synchronous.
>
> >>This also should allow WINE to work well on
> >>platforms such as x86-64, without needing multiple WINE binaries.
> >>(64-bit control process managing mix of 32 and 64 bit address spaces)
> >
> >Writing 64-bit code handling cleanly 32-bit syscalls is hard. Compiling
> > 32-bit code in 32-bit mode to do the same is simpler.
>
> The problem is that they need to communicate, especially once Win64
> actually hits.  WINE currently has a (confusing) "relay" layer that
> already does similar tasks for 16/32 bit.  Furthermore, the Win32 API
> calling convention is fairly well defined, (parameters on stack; return
> in EAX) so this shouldn't be more of a problem than has been solved in
> the past.  (That doesn't mean it won't be a real PITA.)
>
> >>The reason to trap is to allow WINE to intercept the call while
> >>sitting in another address space.  (Each Win32 process would have its
> >>own guest address space.)  The idea is to have the interfaces UML uses
> >>be generic enough for WINE to also use.
> >>
> >>The reason is simple--improved security by enforcing a sandbox around
> >>WINE.

> Seccomp (see below--thanks for bringing it up) could more easily be used
> to solve this.  (Why bother with trapping all the time when only a few
> pages really need protection?  Furthermore, the external control thread
> would thus have veto power over all syscalls made, so the sandbox can be
> easily enforced.)

> >Andrea Arcangeli merged such a "padded cell" functionality, but the
> > allowed interface is read, not a page fault. The former is faster and
> > easier to use, and also allows writing arbitrary amounts of data.
> >
> >It's called secure computing (see kernel/seccomp.c for details, and/or
> > look on LWN.net for an article about it).
>
> I had looked at this earlier, but hadn't realized that it could be used
> to implement this--provided that mm_indirect can make syscalls in a
> seccomp address space (bypassing the restriction),

Wait a moment - you're clearly talking about the runtime thread calling 
mm_indirect(), or I mistook something?

In this case there's no problem - seccomp jails the process only. If we tried 
to inject in the process code to perform syscalls (like UML does in SKAS0 
mode, which is not a host patch) it wouldn't work, but mm_indirect is a 
normal syscall borrowing the foreign address space.

> this can do 
> everything that "fasttrap" could (using some help from appropriate code
> in userspace). 

> Maybe SKAS4 should add a new seccomp level?

I don't remember about "levels" in seccomp... and that was intended to be 
simple. Beyond they shouldn't be needed (see above).

> >Wait a moment - Windows 3.1 uses 286 paging, and Win16 userspace progs use
> > up to 16M of Ram. You don't have this on vm86(), right?

> No, but as I said vm86 is gone on x86-64, which means that DOS soft ints
> are somehow caught--inside the address space in question.  (WINE
> currently runs in-process, I am trying to lay the groundwork to change
> that--thus all the crazy stuff previously about "fasttrap" to another
> userspace.)  Current WINE can use vm86 on i386 platform, however.

> This (Win16 programs with 16MiB of RAM) also means that WINE could
> always intercept soft interrupts--even without use of vm86.
Good.

> The other catch is that 64 and 32 bit code doesn't mix very well, and
> they must be kept in separate processes normally--thus the reason for a
> 64-bit control process to be able to handle both 32 and 64 bit address
> spaces.  The entire kernel is 64-bit anyway, so leaving the option open
> can't be too insanely hard.

> The other problem is that a more specific interface could be much
> faster.  OTOH, perhaps a better strategy would be to improve the
> signals--thus also lessening the other problem (slowness of SIGSEGV) as
> well as improving performance generally.

Signals are very slow, but in many ways they can't be optimized. The only big 
optimization which can be done is when _tracing_ a process which gets a 
signal. The signal is first delivered to the target process, a context switch 
is made towards it, and only afterwards, before returning to user mode, is 
the signal notification delivered to the tracing process, a context switch is 
performed towards it and then the traced process is switched again to ready 
state and then scheduled. I.e. the first switch to the target process is 
totally useless.

> >>>However, currently the idea is sys_mm_indirect , taking an fd
> >>> representing an mm context, a syscall number and its parameters, plus a
> >>> syscall to get a fd representing a mm context.

> >>How are address spaces manipulated?  Could ioctls on the mm context's fd
> >>be useful?

> >We don't use ioctls, they are inelegants; SKAS3 uses write which is just
> > as bad.

> What is inelegant about an ioctl on a special fd?  I say that ioctls are
> far preferrable to more fds (on other files), or the extra complexity of
> implementing some other interface (maybe using netlink?).

ioctl is totally unstructured and thus inelegant, and 32/64-bit compatibility 
is a PITA.

Using them for devices is tolerable, for general APIs isn't. Many recently 
included APIs were born as ioctl()s set and were rewritten as either syscalls 
sets or special filesystems (say inotify(), for instance).

Device mapper uses ioctls only because it was merged in the dark age of 2.5 
and it was really needed.

> Besides, if 
> you implement your own struct file_operations, you get ioctl support by
> writing the handler function for it.

> (If I understand the Linux 2.6.14 
> VFS correctly).

You do, that's not the problem... and the inelegance is not totally in the 
implementation, but in the API.

> OTOH, if no operations that fall into ioctl's area are 
> needed, then implementing ioctl for its own sake is silly.

> >For SKAS4, instead, you'd use sys_mm_indirectI(); you say:
> >
> >mm_indirect(addr_space_fd, __NR_MMAP, <mmap_args>)
> >mm_indirect(addr_space_fd, __NR_MUNMAP, <munmap_args>)
> >
> >and so on, for each syscall (excluding fork and exit, for now). To destroy
> > an address space you simply call close on its fd.

> How do you map region X of the guest address space to region Y (or
> somewhere) in your own?  mmap/munmap on the address space's fd would
> make sense here.

That's not possible, to my knowledge, unless you use a shared backing storage, 
i.e. a tmpfs file.

I.e. the memory must be set up as shareable from the very beginning.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
