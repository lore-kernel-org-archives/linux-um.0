Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXOBL-00029l-7f for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 10:45:11 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BXOBK-0004rs-Cl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 10:45:10 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406071949.04220.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] The SKAS4 patch?? + ideas for 0 context-switch
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
Date: Mon, 7 Jun 2004 19:49:03 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi Jeff, I would like to ask you to make the current form of the SKAS4 patch, 
even if incomplete, public on the -devel mailing list, even if it is not yet 
ready; I rememeber there were some problems still to solve, but if you 
publish it, the community could help you in this. Also, you actually put it 
in the x86_64 patch, so it is almost ready! Please let us see it in its 
complete form! Btw, it seems that anyway SKAS mode is not truly SKAS (new_mm 
and PTRACE_SWITCH_MM users are removed); is this just a temporary hack or 
not?

You said you sometimes feel you have too much work to do; just ask for help! 
If you want to give some tasks away, just ask for help!

Besides this generic things, I would like to see how are you implementing it, 
and I have an idea to drop the number of context switches from 2 to 0 (no 
code yet - it is a bit hard to implement). But just now, I've read on your 
diary you planned to have only 1 process for each UML processor; would that 
guarantee 0 context-switches or not? Also, this requires coming back to 
having a 2,5G TASK_SIZE inside UML, with the upper part for the UML and the 
lower to the host process. Would you accept it?

I think this can improve performance even more than the SYSEMU patch, if I 
understand TLBs well, the 2 Context Switches removed by SYSEMU are the faster 
ones.
In detail (skip this if you got what I mean): to do a syscall, without SYSEMU 
there is a CS to the guest kernel (which invalidates tons of TLBs, i.e. is 
the heavier of all ones) + a few instruction + the two useless CS's deleted 
by SYSEMU, which invalidate a very few TLB entries (I think that only 1-2 
pages of code + data will have be accessed) + the syscall execution (using a 
lot of memory) + the final context switch to the userspace program, which 
will now take a lot of time to refill its TLB.

Basically the kernel memory is trapped in the child's one like in TT mode, but 
this is exploited to avoid any context switch between the two process, with 
lazy tlb switching, much like when switching from userspace to kernel-only 
threads (the kernel sees this need when PTRACE_SYSEMU is used and an option 
is set); plus, via segmentation (much like the exec-shield patch), it is 
prohibited from accessing the kernel memory. The hard part is the 
segmentation protection, since I need to change the whole GDT and the whole 
LDT! Plus I need help on this from someone knowing well protected mode 
details - I've understood what I say from the exec-shield patch + NASM guide 
about opcodes, which is not very much.

The idea can be resumed as (I don't know at all if it's clear):

- Kernel stands to UML guest (a userspace process) as UML guest stands to its 
interior processes.

- I.e. context switches for UML syscall are like the Linux Kernel ones with 
the 4G/4G patch; I want to use the same trick to avoid context switches on 
syscalls like the UML kernel.

-- NOW COMES THE DETAILED DESCRIPTION --

- Ok, actually: when PTRACE_SYSEMU switches to the father, before calling the 
scheduler, it changes the father->mm field so that it becomes the child's one 
(and restore it on exit); the new UML would set up children->mm so that it 
contains all father mappings (supposing they stay fixed; if not I must think 
some solution. HIGHMEM mappings are not fixed, but they are released before 
exiting from kernel context, so they are still Ok); so we have no context 
switch, and the father can happily work. The security issue can be fixed (see 
below). More over, it can access directly (like in tt mode) the child memory 
and use fault_catcher to catch faults, unlike the slow pagetable walking of 
SKAS mode (I speak for copy_{from, to}_user).

- To have the same mappings, if they are all shared (I do not hope to be so 
lucky) this can be done using the fork routine as they are; otherwise, either 
the UML kernel copies the mapping from userspace, or UML creates only shared 
mappings (which maybe is not a problem IMHO since it never forks), or I 
create a modified dup_mmap routine which treats all mappings as shared one; 
the stock fork routine, in fact, would not share the pages, but just COW 
them.

- Security: this is another problem, however I have the solution: 
segmentation. I thought to use the mechanism used by the Linux kernel to 
avoid userspace accessing addresses > PAGE_OFFSET, but at last I discovered 
it wouldn't work.

The kernel already solved this, since the kernel (if you don't use the 4G/4G 
patch) does almost exactly this for user-kernel space transition (but, in the 
UML way, it still requires context switch for timer routines, and any 
interrupt one, and this cannot be solved since the interrupt can happen while 
another process, not UML-related, is executing). The problem, however, is not 
that easy to solve: the kernel solution is by marking the 
userspace-accessible pages as accessible by userspace (ring 3) code, while 
kernel page tables are not marked so, and are therefore unaccessible.

Solution in by segmentation. DS points to a struct desc_struct in memory 
(which is decoded by the CPU) which can say: refuse access to virtual 
addresses > 2,5G (or whatever, I think that the UML kernel should pass its 
bottom address). At the moment, I'm studying it and the exec-shield patch: 
that patch keeps track of the maximum possible value of EIP for a task and 
sets the code segment limit to that value. This can be applied 
straight-forwardly. But here a malicious software could modify the ?S (CS, 
DS...) registers and point them anywhere inside the LDT and the GDT. So, 
sadly, making this work means reducing the size limit in each valid entry of 
the LDT and the GDT (for the GDT this is about 1 entry, actually); and the 
LDT can be modified by the user through sys_modify_ldt, so we must be 
especially careful there (i.e. restrict the limit the user has told us).

- API:

the UML kernel has to tell the host kernel:

- that the child process must be insulated when it is attached to (or when it 
sends the PTRACE_TRACEME request); a variant of the request which allows 
specifying the bottom address must be introduced (addr and data are ignored, 
so I can't make them meaningful); the names could be PTRACE_ABSTRACTME and 
PTRACE_ABSTRACT (since the child process is "abstracted" from the host). And 
that value has to be saved somewhere (if it is taken in units of at least 
64k, it could be put in the high bytes of task_struct-> ptrace, which avoids 
the need of adding members to task_struct).

- instead of PTRACE_SYSEMU, PTRACE_KERNELEMU, which would do the lazy 
tlb-switching: PTRACE_SYSEMU is IMO valuable enough to stand on its own, even 
if it is no more needed by UML.

Any comments or ideas?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
