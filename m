Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyIY2-0005z9-1q for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 14:39:34 -0800
Received: from zcars04e.nortelnetworks.com ([47.129.242.56])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AyI38-0000D2-14 for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 14:07:38 -0800
Message-ID: <40450A08.8090608@nortelnetworks.com>
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
References: <4043B42A.10803@nortelnetworks.com>
	<200403020100.i2210dM9025649@ccure.user-mode-linux.org>
	<4044A368.8050406@nortelnetworks.com>
	<200403022054.i22KslWo003006@ccure.user-mode-linux.org>
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
Date: Tue, 02 Mar 2004 17:26:16 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>


I've found something interesting.

I'm hitting a code path in activate_fd(), where the call to um_kmalloc() 
returns a chunk of memory that is still pointed to in the active_fds 
linked list!

Hence, it updates the fd and type to the ones passed in, then scans the 
list and of course it finds a conflict and starts complaining about 
duplicate activations.

Somehow memory is being freed without it being removed from the 
active_fds list.

I put a check in kfree() to scan the arg against the active_fds list. 
Here's the backtrace of the first call that tried to free up memory 
still on the active_fds list.


#0  kfree (objp=0xa032c820) at slab.c:1622
#1  0xa00d03d6 in activate_fd (irq=3, fd=47, type=1, dev_id=0xa02309f8)
     at irq_user.c:230
#2  0xa00cf9ed in um_request_irq (irq=3, fd=47, type=1,
     handler=0xa010e340 <line_write_interrupt>, irqflags=872415232,
     devname=0xa01e7fa5 "console-write", dev_id=0xa02309f8) at irq.c:430
#3  0xa010e436 in line_setup_irq (fd=47, input=1, output=1, data=0xa02309f8)
     at line.c:211
#4  0xa010d1c9 in enable_chan (chans=0xa0230a00, data=0xa02309f8)
     at chan_kern.c:164
#5  0xa010e568 in line_open (lines=0xa02309a0, tty=0xaf0ec000, 
opts=0xa0230920)
     at line.c:258
#6  0xa010cca9 in open_console (tty=0xaf0ec000) at stdio_console.c:135
#7  0xa00e3a2f in tty_open (inode=0xafc27c00, filp=0xaf2d9a60) at 
tty_io.c:1433
#8  0xa0084dc4 in devfs_open (inode=0xafc27c00, file=0xaf2d9a60) at 
base.c:2799
#9  0xa0035e48 in dentry_open (dentry=0xafc5d5a0, mnt=0xa032f320, flags=2)
     at open.c:698
#10 0xa0035d3b in filp_open (filename=0xaff49000 "/dev/ttys/1", flags=2,
     mode=0) at open.c:656
#11 0xa00360aa in sys_open (filename=0x9ffffd20 "/dev/ttys/1", flags=2, 
mode=0)
     at open.c:798
#12 0xa00d98fc in execute_syscall_tt (r=0xaefd8274) at syscall_kern.c:120
#13 0xa00d99b9 in syscall_handler_tt (sig=12, regs=0xaefd8274)
---Type <return> to continue, or q <return> to quit---
     at syscall_user.c:37
#14 0xa00daacb in sig_handler_common_tt (sig=12, sc_ptr=0xaefdbd28)
     at trap_user.c:37
#15 0xa00d71ed in sig_handler (sig=12, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2684353860, esi = 2684353824
, ebp = 2684354024, esp = 2684353800, ebx = 2684353824, edx = 0, ecx = 
2, eax = 4294967258, trapno = 14, err = 4, eip =
  1074733544, cs = 35, __csh = 0, eflags = 582, esp_at_signal = 
2684353800, ss = 43, __ssh = 0, fpstate = 0xaefdbd80, ol
dmask = 134283264, cr2 = 1074737568})
     at trap_user.c:101
#16 <signal handler called>
#17 0x400f21e8 in ?? ()
#18 0x08049799 in ?? ()
#19 0x4002f9a7 in ?? ()




Chris



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
