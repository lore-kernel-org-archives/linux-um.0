Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BeJrd-0008UA-SC for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Jun 2004 13:33:29 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BeJrc-0007Jj-5H for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Jun 2004 13:33:28 -0700
Message-ID: <40DDDB91.9050304@exse.net>
From: =?ISO-8859-1?Q?Sebastian_B=F6hm?= <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] backtrace of uml crash on mysql-server start
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
Date: Sat, 26 Jun 2004 22:24:49 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>

Hi,

finally I was able to produce this stracktrace with 2.4.26-um1 (host 
also 2.4.26)
It happend during a mysql-server start. (I can reproduce this quite 
constant, if you have further questions ...)

maybe something with ipc ?




Breakpoint 1, panic (fmt=0x0) at panic.c:58
58              machine_paniced = 1;
(gdb) bt
#0  panic (fmt=0x0) at panic.c:58
#1  0xa008e04b in segv (address=28, ip=1818324839, is_write=2, is_user=0,
    sc=0x0) at trap_kern.c:144
#2  0xa008e3d7 in segv_handler (sig=11, regs=0xa13ec274) at trap_user.c:67
#3  0xa0090ea4 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
    at trap_user.c:35
#4  0xa008e408 in sig_handler (sig=0, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2, esi = 28, ebp = 2705260500, esp = 2705260428, 
ebx = 0, edx = 0, ecx = 2684354560, eax = 28, trapno = 14, err = 6, eip 
= 2684935257, cs = 35, __csh = 0, eflags = 66194, esp_at_signal = 
2705260428, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 134217728, cr2 
= 28}) at trap_user.c:101
#5  <signal handler called>
#6  0xa008dc59 in handle_page_fault (address=1881171332, ip=0, is_write=2,
    is_user=0, code_out=0xa13f0024) at rwsem.h:101
#7  0xa008df56 in segv (address=1881171332, ip=0, is_write=2, is_user=0,
    sc=0x1c) at trap_kern.c:133
#8  0xa008e3d7 in segv_handler (sig=11, regs=0xa13f0274) at trap_user.c:67
#9  0xa0090ea4 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
    at trap_user.c:35
#10 0xa008e408 in sig_handler (sig=28, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 0, esi = 1881171332, ebp = 2705261644, esp = 
2705261572, ebx = 188117---Type <return> to continue, or q <return> to 
quit---

/sebastian


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
