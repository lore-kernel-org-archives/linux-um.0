Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXJR3-00069y-BR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 08:54:41 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HXJR1-0002zk-Hb
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 08:54:41 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 30 Mar 2007 17:54:27 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703301754.27335.blaisorblade@yahoo.it>
Subject: [uml-devel] "Stracing" guest from gdb on the host and examining its
	memory.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Today I ran -mm as UML.

To debug some hard problems (in the end that udev on Dapper doesn't like -mm 
kernels, while the one on Breezy does - so /dev/tty* doesn't get created and 
getty never starts), I found an efficient enough way to strace system calls 
from the guest.

Note that YMMV - below I reference various concept which are explained 
elsewhere without links, and it took me some time to learn how to debug UML 
efficiently and address the various quirks of gdb.

It's a personal note to remember, but may be useful to motivated hackers. 
Probably I should put this inside Documentation/ ... 

Btw, I discovered recently that when you boot UML inside gdb, it's the first 
break call to confuse gdb: breakpoints set before cease working when that 
call is done, i.e. very early (I remember that was in init_aio).

The basic idea is to break at handle_syscall, to intercept all syscall, have 
some nice gdb displays for parameters, and display which is the syscall.

First, let's get some parameters; we want to be able to access current.

1) CONFIG_KERNEL_STACK_ORDER is normally 2, so the stack is 16K wide. Since 
This means that struct thread_info* current_thread_info() is given by this:

((struct thread_info*)((long)$rsp & 0xffffc000))
As a check, current_thread_info() == current_thread_info()->task->thread_info 
is always true, so you can verify whether 
((struct thread_info*)((long)$rsp & 0xffffc000))->task->thread_info ==
((struct thread_info*)((long)$rsp & 0xffffc000))

After this, I can create a display for the pid and name of the current 
executing process:

display ((struct thread_info*)((long)$rsp & 0xffffc000))->task->pid
display ((struct thread_info*)((long)$rsp & 0xffffc000))->task->comm

(there is some garbage in comm after the first NULL, that's normal).
That's for x86_64; on i386 replace $rsp with $esp.

2) I want at times to print the process IP.

I compile with O=$OUT, i.e. using KBUILD_OUTPUT ($OUT points to a folder), to 
place object files elsewhere than sources.

So to get HOST_IP I can do:

$ grep -r HOST_IP $OUT/arch/um/
Currently it is in user_constants, so I can do:
$ grep HOST_IP $OUT/arch/um/include/user_constants.h
(if you build without O=, use the following:)
$ grep HOST_IP arch/um/include/user_constants.h

I get
#define HOST_IP 16 /* RIP       # */

3) now I break on handle_syscall.

The best for me was to break on "result = EXECUTE_SYSCALL(syscall, regs);".

Here, union uml_pt_regs * r represents the registers of the userspace process.
To print the current syscall, you can do:
(gdb) print r->skas->syscall
to get the syscall number, but
(gdb) print sys_call_table[r->skas->syscall]
prints the associated function, and that's clearer.

Finally, the IP is r->skas->regs[HOST_IP], but HOST_IP is a macro, so we need 
the actual value we got earlier:

display  r->skas->regs[16]

And we have all! By stepping into EXECUTE_SYSCALL, we can also debug the 
syscall execution and see the parameters (most times you must wait for 
copy_from_user to see parameters value, if just a pointer is passed).

We can also look at the guest memory - that was thought me by Jeff years ago.

While the given guest process is stopped inside UML:
1) get the pid of the host process representing the guest process. That's 
print userspace_pid[$CPU], where $CPU must always be 0 for now (until SMP will 
be implemented).
Let that be $PID

2) The child memory is mapped from a deleted temp file, named 
$TEMP/vm_file-XXXXXX. We must look to the page table, and that's simple 
through the host. Suppose we want to look at 0x405ac012 (because that's the 
IP where a process gets a SIGSEGV and dies); first let's split this into page 
address and offset, getting 0x405ac012 == 0x405ac000 + 0x12.

cat /proc/$PID/maps will show this, like (sample row):

405ac000-405ad000 rwxs 03fb4000 00:13 
85912                              /tmp/vm_file-IUCpfE (deleted)

The first column is the range mapped with mmap(), the third is the offset 
inside the file. So 0x405ac012 is located at 0x03fb4000 + 0x12 in that file.
How to look at it, since it's deleted? Uml has mapped the whole of it, 
starting from the address stored in uml_physmem onwards.

So in gdb I must just look (with the 'x' or 'disassemble' command) to 
uml_physmem + 0x03fb4000 + 0x12.

These are the basic ideas, very condensed.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
