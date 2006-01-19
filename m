Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EziB4-0006bi-7O for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 14:22:46 -0800
Received: from wproxy.gmail.com ([64.233.184.203])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EziB2-0007bg-CR
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 14:22:46 -0800
Received: by wproxy.gmail.com with SMTP id 68so343114wri
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 19 Jan 2006 14:22:43 -0800 (PST)
Message-ID: <43D01171.8090807@gmail.com>
From: Jacob Bachmeyer <jcb62281@gmail.com>
Reply-To: jcb62281@gmail.com, user-mode-linux-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS4 design question
References: <43CBF532.8020103@gmail.com>
	<200601181258.34474.blaisorblade@yahoo.it>
	<43CED4AE.4020101@gmail.com>
	<200601190137.45303.blaisorblade@yahoo.it>
In-Reply-To: <200601190137.45303.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 19 Jan 2006 16:23:45 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:

>On Thursday 19 January 2006 00:52, Jacob Bachmeyer wrote:
>
>>Blaisorblade wrote:
>>
>>>On Monday 16 January 2006 20:34, Jacob Bachmeyer wrote:
>>>
>>>>Has any thought been given to making SKAS4 suitably generic that it
>>>>could be used for more than just UML?
>>>>
>>>Not yet, thoughts welcome.
>>>
>>Let's see:
>>
>>to support HURD (which uses the Mach ABI):
>>
>>    -- existing facilities plus trap lcall gates
>
>I.e. extend ptrace to trap lcall gates, right? That's another thing, could be 
>done, but it relates more to the Linux-ABI project... at least this can't be 
>merged in mainline since we don't support lcall gates.

Why not?  And for that matter, why does ptrace not currently catch lcalls?

>>to support WINE (which follows Win32 conventions (ick!)): (x86 only)
>>
>>    --existing facilities plus
>>     -- trap on access to specified pages
>
>We do that: make them unmapped and trap SIGSEGV through ptrace. Doesn't work 
>for accesses from kernel-space (you don't get SIGSEGV, just, likely, 
>-EFAULT). And it's horribly slow. And trapping for kernelspace accesses is 
>bad.

You don't have to trap kernelspace accesses;  (-EFAULT there would be a
good thing--the host kernel shouldn't be looking in these pages anyway)
this is only to apply to userspace code, but SIGSEGV is slow--why should
it be fast?  It's an error path.

>>        Explanation:  Win32 API calls are not syscalls in the normal
>>sense--rather they are made by calling into a system DLL.
>
>Yep, it then can decide whether to trap into the kernel or not (depending on 
>that version's implementation).
>
>>These DLLs 
>>are mapped into the process' address space on Windows and under current
>>WINE, much like shared objects in normal Linux.  This idea would enable
>>WINE to not actually map these DLLs, but rather simply set the pages
>>where the DLLs would be mapped as "fasttrap". 
>
>Which is the reason to trap to the kernel? It's going to be slow. A page 
>fault, like a syscall, is costly (and probably more since it's an interrupt).
>
>If there is a good reason not to map the DLLs, it may at least make sense, but 
>WINE users aren't going to use special patches, and getting such an hackish 
>thing in mainline may be a hard sell (except the reason is _really_ good).

The overhead is not all that large, as most Win32 API calls ultimately
go into the kernel anyway.  This also should allow WINE to work well on
platforms such as x86-64, without needing multiple WINE binaries.
(64-bit control process managing mix of 32 and 64 bit address spaces)

Also, what exactly are vsyscalls?

Executables are already demand-paged--so page faults routinely happen
anyway.  The reason to trap is to allow WINE to intercept the call while
sitting in another address space.  (Each Win32 process would have its
own guest address space.)  The idea is to have the interfaces UML uses
be generic enough for WINE to also use.

The reason is simple--improved security by enforcing a sandbox around
WINE.

>>Then, when the program 
>>attempts to access a DLL's memory image, the kernel would intercept the
>>request and quickly pass it to a userspace thread,
>
>Good saying, quickly pass it... signals are slow. There faster but more 
>complicated primitives (I remind netlink for instance).

User DLLs (those from the program itself) would actually be mapped.  The
system DLLs (kernel32, user32, etc.) that WINE itself implements on
Linux and that must trap to kernelspace on Windows would be loaded this
way.  One benefit is to reduce the chance of conflict, as various
internal modules in WINE that don't exist in Windows could thus be
removed from the visible (to the Win32 app) address space.  This could
have uses other than WINE, too.  One possibility is as a "padded cell"
of sorts--a process is started in a guest address space under a control
program that intercepts and discards all syscalls.  However, certain
pages in that address space are used as a restricted system
interface--accessing them blocks the accessing thread and causes a
(host) syscall to return in the control process.  This syscall would
block until a guest thread trips a "fasttrap" page and then returns
information such as exact address accessed, read or write, and if write,
value written.  This syscall need not be new--read or ioctl on an
appropriate fd (netlink socket perhaps?) would be enough.  The control
thread then carries out the requested action (whatever that maybe) and
permits the jailed thread to again run.

"fasttrap" may have been a poor choice of terms.  The idea is to have
more or less generic kernel-in-userspace functionality with one process
as a"usermode supervisor" watching a set of other processes.


>>which handles the "page fault". 
>>
>>The page remains set as "fasttrap", and the control 
>>process modifies the address space and CPU context appropriately before
>>allowing execution to continue.
>
>"Modifies" to return the call or to map the page in? You seem to imply it 
>performs the call and sets the return value in EAX, right?
>
>Also, for security reasons it's not possible to let userspace trap OS accesses 
>(as the OS is more privileged - search TENEX at 
>http://www.isi.edu/~faber/cs402/notes/lecture19.html to see how bad is that).

Perform the API call.  It would alter the CPU context, possibly, (if the
call requires it) also changing the guest address space.  There should
be no OS accesses to these pages--those would not trap, but would return
-EFAULT because the pages would not actually be allocated.  (Win32
programs should not be making Linux syscalls--a version of WINE that
uses this would need to catch and ignore any Linux syscalls made.)

>>     -- read/write in guest address space
>>        Explanation:  mmap is fine for big changes to an address space
>>(such as loading modules), but one capability WINE would need for this
>>to be truly useful is 1/2/4/8/16-byte PEEK and POKE.  (Some Win32
>>programs like to do wierd things with Windows' system code--in
>>conjunction with "fasttrap", this would allow WINE to keep such programs
>>happy.)  As I understand, ptrace already provides this, hopefully
>>adequetely.
>
>It provides this, it could be made a bit faster (I've reviewed a patch from 
>another project which uses heavily ptrace, which makes that faster).
>
>>     -- intercept arbitrary interrupts in guest address space
>>        Explanation:  Many older Windows programs (Win16 era)
>>occasionally directly invoke various soft interrupts (these are
>>basically DOS syscalls).  The ability to intercept these is necessary,
>>but need not be particularly efficient or fast.
>
>I recall that hardware IRQ n. x is mapped to k+x, where k is fixed and low; we 
>now have with ACPI 32 IRQs I guess (on my machine the kernel uses up to 22 
>IRQs), so I guess int 0x21 it's going to conflict somewhere.
>
>That said, this could be added too for interrupts not reserved by the kernel 
>(that is CPU exceptions). But DOSEMU already runs x86 programs, so WINE 
>should be able to do it too... ah, yep, it uses vm86, while you need to do 
>that on a paged system.

The only requirement here is to call vm86 in another address space,
which is already doable--except on 64-bit hardware, where vm86 doesn't
exist anyway.

>>     -- transparently use threads in guest address spaces, if desired
>>        Explanation:  WINE currently uses the host's scheduler.
>>Changing it to this new API shouldn't adversely affect that ability.
>>(And on second thought, using a UML library might not be an option.)
>>
>>I shall clarify my proposal:  each thread is assigned an address space,
>>
>and (you forget to say) it can be changed through PTRACE_SWITCH_MM you mean... 
>(otherwise I don't see the addition).
>
>>while an address space can contain multiple threads.
>
>you can PTRACE_SWITCH_MM multiple threads to the same address space

This is exactly it--I wanted to be sure that distinct threads can share
an address space, while one control process can manage as many address
spaces as are needed/wanted.  There should be no addition here--this was
mentioned for completeness.

>>Each thread also 
>>has a STOP/RUN flag, which if set to RUN, causes the host scheduler to
>>consider that thread for execution (along with all other runnable
>>threads).  This flag allows either the userspace control process to make
>>scheduling decisions itself, (by only setting one of its threads to RUN)
>>or to punt and have the kernel handle all scheduling for its threads (by
>>setting them all to RUN and using STOP only to block a thread).
>
>Hmm, sleeping like that is easy if you mean that only a thread can switch 
>itself from RUN to STOP. The thread can use some mutex/semaphore thing, at 
>that point.
>
>To switch a thread from RUN to STOP from the exterior, you can currentlykill 
>it with -STOP. Beware it's maybe slow, but I don't know whether it matters 
>and if it can be made much faster.
>
>The problem (I think) is that SIGSTOP will be processed not at kill() time, 
>but at delivery time, i.e. after a context switch to the receiving thread, 
>before returning to userspace. I've not checked for SIGSTOP and am not sure 
>for the rest, but I think it's this way.

How about a PTRACE_SET_THREAD_RUNNABLE that takes a 1 (RUN) or 0 (STOP)
as its argument and has immediate effects?  The problem (IIRC) with
SIGSTOP is that signals are delivered to all threads in a process, while
a userspace scheduler needs to wake up or block exactly one thread at a
time.  Blocking a thread would be done from the control process, not
from the thread itself.  (The call that resulted in it being blocked was
made by touching a page that triggered the control process.)

>>Could all SKAS4 APIs be multiplexed through one syscall?  (Perhaps
>>simply as more ptrace functions, or as a new "skas4" syscall?)
>
>"multiplexing" like ipc(2) is a bad idea. 
>
>However, currently the idea is sys_mm_indirect , taking an fd representing an 
>mm context, a syscall number and its parameters, plus a syscall to get afd 
>representing a mm context.

How are address spaces manipulated?  Could ioctls on the mm context's fd
be useful?






-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
