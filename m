Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsRwf-0004PQ-Lm
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 11:28:49 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AsRtY-0000ow-Tb
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 11:25:37 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Message-Id: <200402151911.11890.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_897LAX8drOt2cXM"
Subject: [uml-devel] Diagnosed and repeatable kernel mode panic in schedule() for 2.6!
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 15 Feb 2004 19:50:36 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Dike <jdike@addtoit.com>



--Boundary-00=_897LAX8drOt2cXM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While searching the archives, I noticed that this command:

while /bin/true ; do /bin/true ; done

created some problems (task_struct leak and OOM) time ago (at least until 
2.6.0-test2, more or less). See "Re: [uml-devel] oops and memory leak with 
uml-patch-2.5.67-1".

I've rerun this command under a 2.6.2 with my patch collection (but with the 
/proc/meminfo bug, i.e. MemTotal = 0) and host 2.4.24-skas (which contains 
the Ingo Molnar's fixlet about LDT loading) and got, instead, this:

Kernel panic: Kernel mode fault at addr 0x1f, ip 0x400d1397
Kernel panic: kernel BUG at kernel/exit.c:793!

And then the kernel exited (even if it tried to trigger some other panics, see 
the end of the attached output). If anyone is able to reproduce the bug, then 
he can go straight debugging, if he doesn't want to read this. I think I 
cannot give you the binary, since I have a 56k modem and it's 6,7Mega even 
compressed (stripping debug symbols is useless for debug). However I could 
try stripping the config and such things, if you absolutely can't reproduce 
it.

The second message is of interest because the BUG line of interest reads as:
  schedule();
  BUG();

and this is fairly interesting. But this report is all a fun: the kernel 
continues to run after a panic call because the call suddenly exited without 
a return (search this message for "sudden"), the runqueue datas are 
inconsistent (maybe because of the memory leak in the above message), we 
don't know where the "array" value comes from (a compiler bug? An error 
in the debugging info? A reused variable? Do you need the gdb disassemble of 
schedule?). Also, since the problems appear in schedule(), this could relate 
with the hang after the "NET: Registered protocol family 2" message, since 
that comes from a not-working wait queue.

Note: in that moment about 10/20 processes were running.

I was able to reproduce both ones under gdb, and I've attached the whole 
debugging session output; here I summarize it, since that output is way too 
long and this is the offending code, inside schedule():

        idx = sched_find_first_bit(array->bitmap);
        queue = array->queue + idx;
        next = list_entry(queue->next, task_t, run_list);

        if (next->activated > 0) { //THIS IS THE LINE!

With gdb, I got this:
(gdb) where
#0  panic (fmt=0xa018f8e0 "Kernel mode fault at addr 0x%lx, ip 0x%lx") at 
include/asm/thread_info.h:49
#1  0xa0018ac8 in segv (address=31, ip=1074598807, is_write=0, 
is_user=1074598807, sc=0xa1e59148)
    at arch/um/kernel/trap_kern.c:167
#2  0xa0018e97 in segv_handler (sig=11, regs=0xa1e59148) at 
arch/um/kernel/trap_user.c:67
#3  0xa001e573 in sig_handler_common_skas (sig=11, sc_ptr=0x58) at 
arch/um/kernel/skas/trap_user.c:33
#4  0xa0018fa0 in sig_handler (sig=0, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, 
__dsh = 0, edi = 2694560988, esi = 2716176348, ebp = 2694560956, esp = 
2694560884, ebx = 3, edx = 2687144876, ecx = 4294967267, eax = 140, trapno = 
14, err = 4, eip = 2684545927, cs = 35, __csh = 0, eflags = 66179, 
esp_at_signal = 2694560884, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 
369106944, cr2 = 31})
    at arch/um/kernel/trap_user.c:103
#5  <signal handler called>
#6  schedule () at kernel/sched.c:1677
#7  0xa0014584 in interrupt_end () at arch/um/kernel/process_kern.c:138
#8  0xa001d498 in userspace (regs=0xa1e59148) at 
arch/um/kernel/skas/process.c:174
#9  0xa001dd54 in fork_handler (sig=10) at 
arch/um/kernel/skas/process_kern.c:103
#10 <signal handler called>
#11 0xa01559dd in syscall () at include/linux/slab.h:92
#12 0xa002cd76 in os_usr1_process (pid=26614) at arch/um/os-Linux/process.c:96
#13 0xa001d53f in new_thread (stack=Cannot access memory at address 0x8
) at arch/um/kernel/skas/process.c:197
Previous frame inner to this frame (corrupt stack?)

(gdb) print next
$2 = (task_t *) 0xffffffe3
(gdb) print &next->activated
$3 = (int *) 0x1f (the address in the fault message)

(gdb) print array
$4 = (prio_array_t *) 0x3

(gdb) print rq
No symbol "rq" in current context.

Contents of this_rq are in the attached debug session log.

Also, in the panic call, I discovered that current->pid was 99, and that is 
the father of the true processes:

root [~: slack90: 6 (0)] # ps -ef
...
root        99     1  0  1997 tty1     00:00:01 -bash
root       100     1  0  1997 tty6     00:00:00 -bash
root       383    99  0  1997 tty1     00:00:00 /bin/true

About array = 0x3, I would point to someone else getting the same problem:
"[uml-devel] wait queues broken?" (but there, array was NULL).

While going on in the panic call, all of a sudden (maybe after 
local_irq_enable, which on UML is unblock_signals() ) I got to this point, 
and then to the BUG() call above (missing details are in the attached 
output):

(gdb) next
69                      sys_sync();
(gdb) next
thread_wait (sw=0xa001d578, fb=0xa09bb554) at 
arch/um/kernel/skas/process.c:210
210     }
(gdb) where
#0  thread_wait (sw=0xa001d578, fb=0xa09bb554) at 
arch/um/kernel/skas/process.c:210
#1  0xa001dd07 in fork_handler (sig=10) at 
arch/um/kernel/skas/process_kern.c:94
#2  <signal handler called>
#3  0xa01559dd in syscall () at include/linux/slab.h:92
Previous frame inner to this frame (corrupt stack?)

Then, it seems that running notifier_chan_list called some function that 
sleeped and that the calls to scheduled panicked and then tended to loop 
infinitely (at least, until I debugged it; when doing continue, finally the 
program exited).

Hope you have fun figuring it out!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729







--Boundary-00=_897LAX8drOt2cXM
Content-Type: application/x-bzip2;
  name="debugOutput.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="debugOutput.bz2"

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
woSBQWXryA==

--Boundary-00=_897LAX8drOt2cXM--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
