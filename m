Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wnzy-0002M7-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 12:17:58 -0700
Received: from home.linuxhacker.ru ([194.67.236.68] helo=linuxhacker.ru)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19wnzx-0003tn-1N
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 12:17:57 -0700
Message-Id: <200309091914.h89JE6ja000983@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] "Kernel panic: Segfault with no mm"
References: <20030909180126.GC10485@marowsky-bree.de>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 9 Sep 2003 23:14:06 +0400
To: lmb@suse.de, user-mode-linux-devel@lists.sourceforge.net

Hello!

Lars Marowsky-Bree <lmb@suse.de> wrote:

LMB> with the UML kernel on 2.4.21 I am seeing the above. I can trigger it by
LMB> a NULL pointer dereference in the kernel (ie, my buggy code / module
LMB> ;-).

Well. This is expected.

LMB> Instead of a regular panic, I get the above. It appears something is
LMB> going astray with the mm handling.
LMB> #0  panic (fmt=0xa01b8ad2 "Segfault with no mm") at panic.c:59

So it said you had segfault in kernel.

LMB> #1  0xa00af3b4 in segv (address=1074944004, ip=2706132208, is_write=0, 
LMB>     is_user=0, sc=0xa1468280) at trap_kern.c:119
LMB> #2  0xa00af866 in segv_handler (sig=11, regs=0xa1468280) at trap_user.c:69
LMB> #3  0xa00b351c in sig_handler_common_tt (sig=11, sc_ptr=0x58) at trap_user.c:37
LMB> #4  0xa00af990 in sig_handler (sig=1, sc=
LMB>       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2694189056, esi = 2694189056, ebp = 2705767004, esp = 2705766988, ebx = 4294967295, edx = 0, ecx = 2705766824, eax = 2706243584, trapno = 13, err = 0, eip = 2706132208, cs = 35, __csh = 0, eflags = 66118, esp_at_signal = 2705766988, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 436281344, cr2 = 1074944004})
LMB>     at trap_user.c:104
LMB> #5  <signal handler called>

This is signal kernel and one step up is your buggy code.
You just need to go up to that point to see what's wrong.

LMB> I wonder whether anyone has seen that before or whether it is something
LMB> peculiar to my setup. (Which also includes the aa patches for the VM)

I always see this stuff when kernel does such bad things and I sort of
understand that it should be this way.


Bye,
    Oleg


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
