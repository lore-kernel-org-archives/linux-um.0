Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxQ89-0004uf-QM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 04:33:13 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AxPgj-0003l7-JH for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 04:04:53 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] System Call Mechanism
References: <40352B06.3030406@users.sourceforge.net>
	<200402251652.52680.blaisorblade_spam@yahoo.it>
	<403FFCED.7060201@users.sourceforge.net>
In-Reply-To: <403FFCED.7060201@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402291326.24054.blaisorblade_spam@yahoo.it>
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
Date: Sun, 29 Feb 2004 13:26:24 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Kuas <ku4s@users.sourceforge.net>

Alle 03:29, sabato 28 febbraio 2004, Kuas ha scritto:
> Hi Blaisor,
> Thanks for the response and info.

Hi Kuas, sorry for answering this late. However, next time be clearer in how 
you write your email. I skipped to other things when I first noticed your 
mail was not enough fast to read - caring about spaces and marks is 
important; writing the way one speaks makes a harder job for the reader.

> I am still confused in how the system
> call arrive at process.c->userspace().

And I am learning it while answering you since I never started learning it 
properly. So, thanks for the stimulus to learn it.

> I guess the proposal in the
> presentation
> (http://user-mode-linux.sourceforge.net/slides/ols2002/img21.html), it
> said the next implementation would be to convert trap call to signal has
> never been implemented.

No idea, not yet read that.

> I checked in SKAS and TT mode, the idtr value is the same as the host
> machine and I can see from where you pointed, SKAS and TT has the same
> trap handler for system_call. But I don't really understand ptrace
> control, I am not totally sure how the system call is being intercepted
> and sent back to uml ends up in process.c->userspace().

> Does every time
> interrupt is called, it will be caught by the host kernel ptrace and for
> system call (int 0x80) will be redirected back to the UML process. 

This means you'll soon read "man ptrace" and check for PTRACE_SYSCALL.
However, for SKAS mode: every time a process is created, a thread is created 
which executes new_thread_handler or fork_handler. They call userspace(), and 
it has a while(1) loop which wait()'s for the child stopping and when it gets 
a SIGTRAP, executes handle_trap which handles the syscall.

grep -e '\<userspace\>' arch/um/kernel/skas/*.c

> How
> does the information about the process that's requesting system call,
> syscall#, and arguments being passed to the UML Kernel.

This is done by inspecting the registers. See this:

static void handle_trap(int pid, union uml_pt_regs *regs)
{
        int err, syscall_nr, status;

        syscall_nr = PT_SYSCALL_NR(regs->skas.regs);

PT_SYSCALL_NR is defined in arch/um/include/sysdep-i386/ptrace_user.h and 
means read_PTrace_SYSCALL_NumbeR.

Note: I hope for you that you use either LXR or Exuberant Ctags with an editor 
supporting it, or Freescope (I do not use it but it's good): i.e. from an 
identifier get its definition and where it is used (ctags gives you only the 
definition). Google is your friend while searching for these tools. If you do 
not use them, do not hope to understand anything (yes, the code is there, but 
avoiding using those tools is like reading directly the disassembled vmlinux 
file)

> I understand
> since SKAS mode has collection of Virtual Address Spaces. Correct me if
> I'm wrong, will PTRACE_SWITCH_MM first change to the UML kernel process
> Address Space.

No - it changes the address space, but see below.

> But in SKAS mode, the UML kernel is also in the host
> address space (>0xc0000000), during this state we are already in the
> kernel space.

Wait a moment - the host kernel lives at addresses >0xc0000000. The UML kernel 
lives below that address - it starts from the START address defined in the 
linker script - see arch/um/Makefile:
 -DSTART=$$(($(TOP_ADDR) - $(SIZE)))
Where TOP_ADDR is normally 0xc0000000 (changes with CONFIG_HOST_2g_2g), while 
SIZE is 512 Mega * CONFIG_KERNEL_HALF_GIGS.

> So which child memory that PTRACE_SWITCH_MM switches when
> the system call? I am assuming the active Virtual Memory that's being
> replaced in UML process is the current uml process that generate the
> system call.

1)There is one virtual address space for each process (i.e. one mm_struct, 
task_struct->mm). Multiple thread share one single mm_struct.

2)What Uml does in SKAS mode is to have:
- one ptraced host thread which runs the guest userspace code, called 
userspace thread (with ps auxw, it gets a T in his state because it's 
ptraced);
- one ptracing host thread, called kernel thread, which executes only code 
from the Uml binary, called UML kernel thread. It is the one with lower pid, 
normally.

3)When it must switch to another guest process, the UML kernel thread stops 
the userspace thread and resumes it with a different EIP; but it must also 
make sure that it uses the correct mm_struct and correct memory mappings. 
Those mappings are not done directly through the hardware MMU but with mmaps 
from the /tmp/vmfile-XXXXXX which contains the "physical" memory of the 
guest; the host kernel then uses the hardware MMU to realize those mmaps.

So, the UML kernel thread sends a PTRACE_SWITCH_MM to the userspace thread. So 
in sys_ptrace current is the kernel thread. With the supplied pid, sys_ptrace 
finds the userspace thread, and changes its ->mm field. The next time it 
runs, the kernel will load the mappings of the other guest process.

PTRACE_MMAP and so on are to modify the various mm_struct's the child can use.

Reference about 2.4 kernel internals (this explains in 2.2 what active_mm is):
http://www.moses.uklinux.net/patches/lki.html
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
