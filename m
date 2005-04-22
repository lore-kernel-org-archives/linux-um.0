Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <3BCB5FB76AFFF646BCFBC02A889B64F3027D46E3@ZCH07EXM05.corp.mot.com>
From: Wu Haibao-a15761 <a15761@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: [uml-devel] UML 2.4.26um panic
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
Date: Fri, 22 Apr 2005 18:56:17 +0800
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hi,
	I encountered a panic in linux-2.4.26um, and it happends almost all the time. I will appreciate it if any one could help as this is really a trouble for us.

	Here are the stacks printed by gdb,
stack1:
==================
#0  panic (fmt=0xa01de769 "kernel BUG at %s:%d!\n") at panic.c:60
#1  0xa000daba in schedule () at sched.h:770
#2  0xa00e69ee in __down (sem=0xa0228b9c) at semaphore.c:80
#3  0xa00e6b64 in __down_failed () at proc_fs.h:150
#4  0xa0228b9c in vts ()
==================
stack2:
==================
#0  0xa019af4d in read () at proc_fs.h:154
#1  0xa3274000 in ?? ()
#2  0xa00e7d13 in file_io (fd=76, buf=0xa329bc6f, len=1, 
    io_proc=0xa019af30 <read>, copy_user_proc=0xa00da418 <copy_from_user_proc>)
    at file.c:491
#3  0xa00e7d8a in os_read_file (fd=76, buf=0xa329bc6f, len=1) at file.c:507
#4  0xa00dfe71 in _switch_to_tt (prev=0xa3298000, next=0xa3274000)
    at process_kern.c:71
#5  0xa000da6a in schedule () at sched.c:695
#6  0xa00d9f75 in interrupt_end () at process_kern.c:142
#7  0xa00e2041 in sig_handler_common_tt (sig=12, sc_ptr=0xa329bd28)
    at trap_user.c:46
#8  0xa00de7f3 in sig_handler (sig=1, sc=
      {gs = 7, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 1073831144, esi = 3, ebp = 2684349128, esp = 2684349036, ebx = 2684349152, edx = 0, ecx = 0, eax = 4294967294, trapno = 14, err = 4, eip = 1073812260, cs = 35, __csh = 0, eflags = 2097798, esp_at_signal = 2684349036, ss = 43, __ssh = 0, fpstate = 0xa329bd80, oldmask = 134283264, cr2 = 1073771440})
    at trap_user.c:109
#9  <signal handler called>
#10 0x40011324 in ?? ()
Previous frame inner to this frame (corrupt stack?)
=================

	Only one thread's stack is like stack 2, while all the other threads' stacks are like stack 1.


Regards,
Wu Haibao
===============================
Tel:65641776
------------------------------------------------------ 
[X ] General Business Information 
[] Motorola Internal Use Only 
[ ] Motorola Confidential Proprietary 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
