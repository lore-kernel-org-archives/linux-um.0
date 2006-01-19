Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzNoK-0002i8-7G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 16:37:56 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzNoG-000145-FG
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 16:37:56 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS4 design question
References: <43CBF532.8020103@gmail.com>
	<200601181258.34474.blaisorblade@yahoo.it>
	<43CED4AE.4020101@gmail.com>
In-Reply-To: <43CED4AE.4020101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601190137.45303.blaisorblade@yahoo.it>
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
Date: Thu, 19 Jan 2006 01:37:44 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jacob Bachmeyer <jcb62281@gmail.com>

On Thursday 19 January 2006 00:52, Jacob Bachmeyer wrote:
> Blaisorblade wrote:
> >On Monday 16 January 2006 20:34, Jacob Bachmeyer wrote:
> >>Has any thought been given to making SKAS4 suitably generic that it
> >>could be used for more than just UML?
> >
> >Not yet, thoughts welcome.
>
> Let's see:
>
> to support HURD (which uses the Mach ABI):
>
>     -- existing facilities plus trap lcall gates

I.e. extend ptrace to trap lcall gates, right? That's another thing, could be 
done, but it relates more to the Linux-ABI project... at least this can't be 
merged in mainline since we don't support lcall gates.

> to support WINE (which follows Win32 conventions (ick!)): (x86 only)

>     --existing facilities plus
>      -- trap on access to specified pages

We do that: make them unmapped and trap SIGSEGV through ptrace. Doesn't work 
for accesses from kernel-space (you don't get SIGSEGV, just, likely, 
-EFAULT). And it's horribly slow. And trapping for kernelspace accesses is 
bad.

>         Explanation:  Win32 API calls are not syscalls in the normal
> sense--rather they are made by calling into a system DLL.

Yep, it then can decide whether to trap into the kernel or not (depending on 
that version's implementation).

> These DLLs 
> are mapped into the process' address space on Windows and under current
> WINE, much like shared objects in normal Linux.  This idea would enable
> WINE to not actually map these DLLs, but rather simply set the pages
> where the DLLs would be mapped as "fasttrap". 

Which is the reason to trap to the kernel? It's going to be slow. A page 
fault, like a syscall, is costly (and probably more since it's an interrupt).

If there is a good reason not to map the DLLs, it may at least make sense, but 
WINE users aren't going to use special patches, and getting such an hackish 
thing in mainline may be a hard sell (except the reason is _really_ good).

> Then, when the program 
> attempts to access a DLL's memory image, the kernel would intercept the
> request and quickly pass it to a userspace thread,

Good saying, quickly pass it... signals are slow. There faster but more 
complicated primitives (I remind netlink for instance).

> which handles the 
> "page fault". 

> The page remains set as "fasttrap", and the control 
> process modifies the address space and CPU context appropriately before
> allowing execution to continue.

"Modifies" to return the call or to map the page in? You seem to imply it 
performs the call and sets the return value in EAX, right?

Also, for security reasons it's not possible to let userspace trap OS accesses 
(as the OS is more privileged - search TENEX at 
http://www.isi.edu/~faber/cs402/notes/lecture19.html to see how bad is that).

>      -- read/write in guest address space

>         Explanation:  mmap is fine for big changes to an address space
> (such as loading modules), but one capability WINE would need for this
> to be truly useful is 1/2/4/8/16-byte PEEK and POKE.  (Some Win32
> programs like to do wierd things with Windows' system code--in
> conjunction with "fasttrap", this would allow WINE to keep such programs
> happy.)  As I understand, ptrace already provides this, hopefully
> adequetely.

It provides this, it could be made a bit faster (I've reviewed a patch from 
another project which uses heavily ptrace, which makes that faster).

>      -- intercept arbitrary interrupts in guest address space
>
>         Explanation:  Many older Windows programs (Win16 era)
> occasionally directly invoke various soft interrupts (these are
> basically DOS syscalls).  The ability to intercept these is necessary,
> but need not be particularly efficient or fast.

I recall that hardware IRQ n. x is mapped to k+x, where k is fixed and low; we 
now have with ACPI 32 IRQs I guess (on my machine the kernel uses up to 22 
IRQs), so I guess int 0x21 it's going to conflict somewhere.

That said, this could be added too for interrupts not reserved by the kernel 
(that is CPU exceptions). But DOSEMU already runs x86 programs, so WINE 
should be able to do it too... ah, yep, it uses vm86, while you need to do 
that on a paged system.

>      -- modify guest address space's LDT

>         Explanation:  Again, Win16 support.  Old Windows actually
> allowed processes to request segments for whatever purpose.  This may or
> may not be doable on all modern hardware.

PTRACE_LDT exists, and performs a remove modify_ldt, like MM_MMAP is a remote 
mmap().

>      -- transparently use threads in guest address spaces, if desired

>         Explanation:  WINE currently uses the host's scheduler.
> Changing it to this new API shouldn't adversely affect that ability.
> (And on second thought, using a UML library might not be an option.)

> I shall clarify my proposal:  each thread is assigned an address space,
and (you forget to say) it can be changed through PTRACE_SWITCH_MM you mean... 
(otherwise I don't see the addition).

> while an address space can contain multiple threads.

you can PTRACE_SWITCH_MM multiple threads to the same address space

> Each thread also 
> has a STOP/RUN flag, which if set to RUN, causes the host scheduler to
> consider that thread for execution (along with all other runnable
> threads).  This flag allows either the userspace control process to make
> scheduling decisions itself, (by only setting one of its threads to RUN)
> or to punt and have the kernel handle all scheduling for its threads (by
> setting them all to RUN and using STOP only to block a thread).

Hmm, sleeping like that is easy if you mean that only a thread can switch 
itself from RUN to STOP. The thread can use some mutex/semaphore thing, at 
that point.

To switch a thread from RUN to STOP from the exterior, you can currently kill 
it with -STOP. Beware it's maybe slow, but I don't know whether it matters 
and if it can be made much faster.

The problem (I think) is that SIGSTOP will be processed not at kill() time, 
but at delivery time, i.e. after a context switch to the receiving thread, 
before returning to userspace. I've not checked for SIGSTOP and am not sure 
for the rest, but I think it's this way.

> Could all SKAS4 APIs be multiplexed through one syscall?  (Perhaps
> simply as more ptrace functions, or as a new "skas4" syscall?)

"multiplexing" like ipc(2) is a bad idea. 

However, currently the idea is sys_mm_indirect , taking an fd representing an 
mm context, a syscall number and its parameters, plus a syscall to get a fd 
representing a mm context.
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
