Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzzKl-0002df-IF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Jan 2006 08:41:55 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzzKe-0001VA-Ki
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Jan 2006 08:41:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS4 design question
References: <43CBF532.8020103@gmail.com>
	<200601190137.45303.blaisorblade@yahoo.it>
	<43D01171.8090807@gmail.com>
In-Reply-To: <43D01171.8090807@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601201741.40602.blaisorblade@yahoo.it>
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
Date: Fri, 20 Jan 2006 17:41:39 +0100
To: user-mode-linux-devel@lists.sourceforge.net, jcb62281@gmail.com

On Thursday 19 January 2006 23:23, Jacob Bachmeyer wrote:
> Blaisorblade wrote:
> >On Thursday 19 January 2006 00:52, Jacob Bachmeyer wrote:
> >>Blaisorblade wrote:
> >>>On Monday 16 January 2006 20:34, Jacob Bachmeyer wrote:
> >>>>Has any thought been given to making SKAS4 suitably generic that it
> >>>>could be used for more than just UML?
> >>>
> >>>Not yet, thoughts welcome.
> >>
> >>Let's see:
> >>
> >>to support HURD (which uses the Mach ABI):
> >>
> >>    -- existing facilities plus trap lcall gates

> >I.e. extend ptrace to trap lcall gates, right? That's another thing, could
> > be done, but it relates more to the Linux-ABI project... at least this
> > can't be merged in mainline since we don't support lcall gates.

> Why not?  And for that matter, why does ptrace not currently catch lcalls?

The lcall stub was removed from arch/i386/kernel/entry.S a little time ago 
(about 2.6.12 IIRC). So vanilla Linux can't handle lcalls. Clear now?

> >>to support WINE (which follows Win32 conventions (ick!)): (x86 only)
> >>
> >>    --existing facilities plus
> >>     -- trap on access to specified pages
> >
> >We do that: make them unmapped and trap SIGSEGV through ptrace. Doesn't
> > work for accesses from kernel-space (you don't get SIGSEGV, just, likely,
> > -EFAULT). And it's horribly slow. And trapping for kernelspace accesses
> > is bad.

> You don't have to trap kernelspace accesses;  (-EFAULT there would be a
> good thing--the host kernel shouldn't be looking in these pages anyway)
> this is only to apply to userspace code, but SIGSEGV is slow--why should
> it be fast?  It's an error path.

Yes, it is thought to be only an error path, but UML abuses of it for normal 
control, and I said that the kernel supports "fasttrap", but only via 
SIGSEGV, i.e. in a slow way.

> >We do that: make them unmapped and trap SIGSEGV through ptrace. 

> >>These DLLs
> >>are mapped into the process' address space on Windows and under current
> >>WINE, much like shared objects in normal Linux.  This idea would enable
> >>WINE to not actually map these DLLs, but rather simply set the pages
> >>where the DLLs would be mapped as "fasttrap".

> >Which is the reason to trap to the kernel? It's going to be slow. A page
> >fault, like a syscall, is costly (and probably more since it's an
> > interrupt).

> >If there is a good reason not to map the DLLs, it may at least make sense,
> > but WINE users aren't going to use special patches, and getting such an
> > hackish thing in mainline may be a hard sell (except the reason is
> > _really_ good).

> The overhead is not all that large, as most Win32 API calls ultimately
> go into the kernel anyway.

A kernel switch only costs about some thousands TSC units (see the rdtsc 
assembly instruction), while a signal delivery to a foreign process can cost 
a lot more (I measure it in the order of 4* 10^5 TSC units, even without a 
memory switch).

> This also should allow WINE to work well on 
> platforms such as x86-64, without needing multiple WINE binaries.
> (64-bit control process managing mix of 32 and 64 bit address spaces)

Writing 64-bit code handling cleanly 32-bit syscalls is hard. Compiling 32-bit 
code in 32-bit mode to do the same is simpler.

> Also, what exactly are vsyscalls?

> Executables are already demand-paged--so page faults routinely happen
> anyway.

Not the same thing - assuming the working set fits in memory, you get page 
faults only for the first access to a given page, and they just jump to the 
kernel.

What you're proposing is that for each call to GDI functions, for instance, or 
whatever, a signal delivery (or in the best case, just a context switch) is 
triggered. That's another thing.

> The reason to trap is to allow WINE to intercept the call while 
> sitting in another address space.  (Each Win32 process would have its
> own guest address space.)  The idea is to have the interfaces UML uses
> be generic enough for WINE to also use.

> The reason is simple--improved security by enforcing a sandbox around
> WINE.

> >>Then, when the program
> >>attempts to access a DLL's memory image, the kernel would intercept the
> >>request and quickly pass it to a userspace thread,

> >Good saying, quickly pass it... signals are slow. There faster but more
> >complicated primitives (I remind netlink for instance).

> User DLLs (those from the program itself) would actually be mapped.  The
> system DLLs (kernel32, user32, etc.) that WINE itself implements on
> Linux and that must trap to kernelspace on Windows would be loaded this
> way.

> One benefit is to reduce the chance of conflict, as various 
> internal modules in WINE that don't exist in Windows could thus be
> removed from the visible (to the Win32 app) address space.  This could
> have uses other than WINE, too.  One possibility is as a "padded cell"
> of sorts--a process is started in a guest address space under a control
> program that intercepts and discards all syscalls.  However, certain
> pages in that address space are used as a restricted system
> interface--accessing them blocks the accessing thread and causes a
> (host) syscall to return in the control process.  This syscall would
> block until a guest thread trips a "fasttrap" page and then returns
> information such as exact address accessed, read or write, and if write,
> value written.  This syscall need not be new--read or ioctl on an
> appropriate fd (netlink socket perhaps?) would be enough.  The control
> thread then carries out the requested action (whatever that maybe) and
> permits the jailed thread to again run.

Andrea Arcangeli merged such a "padded cell" functionality, but the allowed 
interface is read, not a page fault. The former is faster and easier to use, 
and also allows writing arbitrary amounts of data.

It's called secure computing (see kernel/seccomp.c for details, and/or look on 
LWN.net for an article about it).

> "fasttrap" may have been a poor choice of terms.  The idea is to have
> more or less generic kernel-in-userspace functionality with one process
> as a"usermode supervisor" watching a set of other processes.

> >Also, for security reasons it's not possible to let userspace trap OS
> > accesses (as the OS is more privileged - search TENEX at
> >http://www.isi.edu/~faber/cs402/notes/lecture19.html to see how bad is
> > that).

> Perform the API call.  It would alter the CPU context, possibly, (if the
> call requires it) also changing the guest address space.  There should
> be no OS accesses to these pages--those would not trap, but would return
> -EFAULT because the pages would not actually be allocated.  (Win32
> programs should not be making Linux syscalls--a version of WINE that
> uses this would need to catch and ignore any Linux syscalls made.)

> >>     -- read/write in guest address space
> >>        Explanation:  mmap is fine for big changes to an address space
> >>(such as loading modules), but one capability WINE would need for this
> >>to be truly useful is 1/2/4/8/16-byte PEEK and POKE.  (Some Win32
> >>programs like to do wierd things with Windows' system code--in
> >>conjunction with "fasttrap", this would allow WINE to keep such programs
> >>happy.)  As I understand, ptrace already provides this, hopefully
> >>adequetely.

> >It provides this, it could be made a bit faster (I've reviewed a patch
> > from another project which uses heavily ptrace, which makes that faster).

> >>     -- intercept arbitrary interrupts in guest address space
> >>        Explanation:  Many older Windows programs (Win16 era)
> >>occasionally directly invoke various soft interrupts (these are
> >>basically DOS syscalls).  The ability to intercept these is necessary,
> >>but need not be particularly efficient or fast.

> >I recall that hardware IRQ n. x is mapped to k+x, where k is fixed and
> > low; we now have with ACPI 32 IRQs I guess (on my machine the kernel uses
> > up to 22 IRQs), so I guess int 0x21 it's going to conflict somewhere.

> >That said, this could be added too for interrupts not reserved by the
> > kernel (that is CPU exceptions). But DOSEMU already runs x86 programs, so
> > WINE should be able to do it too... ah, yep, it uses vm86, while you need
> > to do that on a paged system.

> The only requirement here is to call vm86 in another address space,
> which is already doable--except on 64-bit hardware, where vm86 doesn't
> exist anyway.

Wait a moment - Windows 3.1 uses 286 paging, and Win16 userspace progs use up 
to 16M of Ram. You don't have this on vm86(), right?

> This is exactly it--I wanted to be sure that distinct threads can share
> an address space, while one control process can manage as many address
> spaces as are needed/wanted.  There should be no addition here--this was
> mentioned for completeness.

UML will need to have this functionality debugged and working sooner or later 
- when it will do SMP with SKAS, it'll need exactly this (you have multiple 
managed threads, corresponding to multiple virtual CPUs, and a thread and its 
address space can be executed on each of those virtual CPUs).

> How about a PTRACE_SET_THREAD_RUNNABLE that takes a 1 (RUN) or 0 (STOP)
> as its argument and has immediate effects?  The problem (IIRC) with
> SIGSTOP is that signals are delivered to all threads in a process,

Isn't there tkill() for this purpose (signals to a specific thread)? And if it 
doesn't work, it should be fixed. Having tons of incoherent APIs is bad, as 
long as things can be done with current ones.

> >However, currently the idea is sys_mm_indirect , taking an fd representing
> > an mm context, a syscall number and its parameters, plus a syscall to get
> > afd representing a mm context.

> How are address spaces manipulated?  Could ioctls on the mm context's fd
> be useful?

We don't use ioctls, they are inelegants; SKAS3 uses write which is just as 
bad.

For SKAS4, instead, you'd use sys_mm_indirectI(); you say:

mm_indirect(addr_space_fd, __NR_MMAP, <mmap_args>)
mm_indirect(addr_space_fd, __NR_MUNMAP, <munmap_args>)

and so on, for each syscall (excluding fork and exit, for now). To destroy an 
address space you simply call close on its fd.

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
