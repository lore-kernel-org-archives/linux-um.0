Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyJei-0005XV-Pq for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 15:50:32 -0800
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyJS8-0006vh-1d for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 15:37:32 -0800
Message-ID: <40451AAB.5050304@nortelnetworks.com>
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
References: <4043B42A.10803@nortelnetworks.com>
	<200403020100.i2210dM9025649@ccure.user-mode-linux.org>
	<4044A368.8050406@nortelnetworks.com>
	<200403022054.i22KslWo003006@ccure.user-mode-linux.org>
	<40450A08.8090608@nortelnetworks.com>
	<200403022322.i22NM8Wo003853@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: problems with UML -- new data with memory debugging on
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
Date: Tue, 02 Mar 2004 18:37:15 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>


I turned on memory debugging, and got the following.  Line 1439 in 
slab.c is

/* Either write before start, or a double free. */

Here's the backtrace:

Breakpoint 1, panic (fmt=0xa01e2d8a "kernel BUG at %s:%d!\n") at panic.c:60
60              bust_spinlocks(1);
(gdb) bt
#0  panic (fmt=0xa01e2d8a "kernel BUG at %s:%d!\n") at panic.c:60
#1  0xa002dc8a in kfree (objp=0xa032c89c) at slab.c:1439
#2  0xa0103ac8 in hostfs_read_super (sb=0xaf332400, data=0xaf036000, 
silent=0)
     at hostfs_kern.c:932
#3  0xa003cae9 in get_sb_nodev (fs_type=0xa022d62c, flags=0,
     dev_name=0xaf037000 "none", data=0xaf036000) at super.c:756
#4  0xa003cc82 in do_kern_mount (fstype=0xaf0d8000 "hostfs", flags=0,
     name=0xaf037000 "none", data=0xaf036000) at super.c:808
#5  0xa004fd62 in do_add_mount (nd=0xaefcbb94, type=0xaf0d8000 "hostfs",
     flags=0, mnt_flags=0, name=0xaf037000 "none", data=0xaf036000)
     at namespace.c:626
#6  0xa0050049 in do_mount (dev_name=0xaf037000 "none",
     dir_name=0xaff46000 "/vob/neptune", type_page=0xaf0d8000 "hostfs",
     flags=3236757504, data_page=0xaf036000) at namespace.c:740
#7  0xa0050416 in sys_mount (dev_name=0x8059e20 "none",
     dir_name=0x8059e30 "/vob/neptune", type=0x8059e48 "hostfs",
     flags=3236757504, data=0x8059eb8) at namespace.c:853
#8  0xa00da41c in execute_syscall_tt (r=0xaefc8274) at syscall_kern.c:120
#9  0xa00da4d9 in syscall_handler_tt (sig=12, regs=0xaefc8274)
     at syscall_user.c:37
#10 0xa00db5eb in sig_handler_common_tt (sig=12, sc_ptr=0xaefcbd28)
     at trap_user.c:37
#11 0xa00d7d0d in sig_handler (sig=12, sc=
---Type <return> to continue, or q <return> to quit---
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 134586040, esi = 3236757504, ebp = 2684353448, esp 
= 2684353408, ebx = 134585888, edx = 134585928, ecx = 134585904, eax = 
4294967258, trapno = 14, err = 4, eip = 1074791518, cs = 35, __csh = 0, 
eflags = 582, esp_at_signal = 2684353408, ss = 43, __ssh = 0, fpstate = 
0xaefcbd80, oldmask = 134283264, cr2 = 1074791488}) at trap_user.c:101
#12 <signal handler called>
#13 0x4010045e in ?? ()
#14 0x0804a8b8 in ?? ()
#15 0x0804b4d1 in ?? ()
#16 0x0804c125 in ?? ()
#17 0x0804cf1d in ?? ()
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
