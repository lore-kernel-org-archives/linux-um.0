Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyBi5-0003Q0-MA for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 07:21:29 -0800
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyBVi-0001cV-0o for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 07:08:42 -0800
Message-ID: <4044A368.8050406@nortelnetworks.com>
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
References: <4043B42A.10803@nortelnetworks.com>
	<200403020100.i2210dM9025649@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: problems with UML, issues with includes
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
Date: Tue, 02 Mar 2004 10:08:24 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>

Jeff Dike wrote:
> cfriesen@nortelnetworks.com said:
> 
>>1) How do I fix the build  process to pick up the kernel includes (and
>>why doesn't it do that by  default?).  
>>
> 
> You don't.  The host's libc headers and the UML pool's kernel headers are
> fundamentally incompatible.  You can't mix them, as you're trying to do
> by including sched.h into a userspace file.

Maybe I'm just confused about how the various things get compiled.  In a 
normal kernel build, including <linux/sched.h> gets you the kernel 
headers, not the libc headers. I had assumed that I would be able to get 
at the UML kernel's sched.h from within the arch/um code.  Is this a 
false assumption?  Or am I just doing it wrong?


>>2) Any ideas why I'm getting
>>the descriptor thing?
>>
> 
> No, but get a stack trace or two from that printk, and that should help figure
> it out.

Here's a backtrace from just where the code would print the registering 
twice message.  Am I right in assuming that since we're hitting this it 
seems to indicate some messed-up reference counting somewhere?


#0  activate_fd (irq=3, fd=47, type=1, dev_id=0xa02309f8) at irq_user.c:157
#1  0xa00cf9bd in um_request_irq (irq=3, fd=47, type=1,
     handler=0xa010e230 <line_write_interrupt>, irqflags=872415232,
     devname=0xa01e7e85 "console-write", dev_id=0xa02309f8) at irq.c:430
#2  0xa010e326 in line_setup_irq (fd=47, input=1, output=1, data=0xa02309f8)
     at line.c:211
#3  0xa010d0b9 in enable_chan (chans=0xa0230a00, data=0xa02309f8)
     at chan_kern.c:164
#4  0xa010e458 in line_open (lines=0xa02309a0, tty=0xaf1f7000, 
opts=0xa0230920)
     at line.c:258
#5  0xa010cb99 in open_console (tty=0xaf1f7000) at stdio_console.c:135
#6  0xa00e391f in tty_open (inode=0xafc13c00, filp=0xafe7ef20) at 
tty_io.c:1433
#7  0xa0084d94 in devfs_open (inode=0xafc13c00, file=0xafe7ef20) at 
base.c:2799
#8  0xa0035e18 in dentry_open (dentry=0xafcd15a0, mnt=0xa032f320, flags=2)
     at open.c:698
#9  0xa0035d0b in filp_open (filename=0xaff49000 "/dev/ttys/1", flags=2,
     mode=0) at open.c:656
#10 0xa003607a in sys_open (filename=0x9ffffd20 "/dev/ttys/1", flags=2, 
mode=0)
     at open.c:798
#11 0xa00d97ec in execute_syscall_tt (r=0xaefd8274) at syscall_kern.c:120
#12 0xa00d98a9 in syscall_handler_tt (sig=12, regs=0xaefd8274)
     at syscall_user.c:37
#13 0xa00da9bb in sig_handler_common_tt (sig=12, sc_ptr=0xaefdbd28)
---Type <return> to continue, or q <return> to quit---
     at trap_user.c:37
#14 0xa00d70dd in sig_handler (sig=12, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2684353860, esi = 2684353824, ebp = 2684354024, esp 
= 2684353800, ebx = 2684353824, edx = 0, ecx = 2, eax = 4294967258, 
trapno = 14, err = 4, eip = 1074733544, cs = 35, __csh = 0, eflags = 
582, esp_at_signal = 2684353800, ss = 43, __ssh = 0, fpstate = 
0xaefdbd80, oldmask = 134283264, cr2 = 1074737568})
     at trap_user.c:101
#15 <signal handler called>
#16 0x400f21e8 in ?? ()
#17 0x08049799 in ?? ()
#18 0x4002f9a7 in ?? ()


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
