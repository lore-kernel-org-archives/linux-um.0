Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOraw-0000ZI-CK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 May 2004 22:20:22 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOrav-0002tu-Tt for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 May 2004 22:20:22 -0700
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BOras-0003tQ-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 15 May 2004 07:20:19 +0200
Received: from c-67-166-61-25.client.comcast.net ([67.166.61.25])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 15 May 2004 07:20:18 +0200
Received: from bjohnson-dated-1082612068.17fb8c by
	c-67-166-61-25.client.comcast.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 15 May 2004 07:20:18 +0200
From: "Bernard Johnson" <bjohnson-dated-1082612068.17fb8c@symetrix.com>
Message-ID: <c840cm$o89$1@sea.gmane.org>
Subject: [uml-devel] Kernel mode fault 2.4.26-um1
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
Date: Fri, 14 May 2004 20:47:51 -0600
To: user-mode-linux-devel@lists.sourceforge.net

I'm getting this crash on 2.4.26-um1

Breakpoint 1, panic (
fmt=0xa01d8b00 "Kernel mode fault at addr 0x%lx, ip 0x%lx, ip 0x%lx") at
panic.c:60
60 bust_spinlocks(1);
(gdb) bt
#0 panic (fmt=0xa01d8b00 "Kernel mode fault at addr 0x%lx, ip 0x%lx")
at panic.c:60
#1 0xa00d1019 in segv (address=8, ip=2685769919, is_write=0, is_user=0,
sc=0xa4a44274) at trap_kern.c:149
#2 0xa00d1416 in segv_handler (sig=11, regs=0xa4a44274) at trap_user.c:67
#3 0xa00d4b3c in sig_handler_common_tt (sig=11, sc_ptr=0xa4a47d28)
at trap_user.c:43
#4 0xa00d14f3 in sig_handler (sig=0, sc=
{gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh =
0, edi = 2762227712, esi = 2762235236, ebp = 2762235212, esp = 2762235188,
ebx = 0, edx = 4294901759, ecx = 2685202592, eax = 4, trapno = 14, err = 4,
eip = 2685769919, cs = 35, __csh = 0, eflags = 66182, esp_at_signal =
2762235188, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 134285824, cr2 =
8}) at trap_user.c:101
#5 <signal handler called>
#6 rwsem_down_failed_common (sem=0x0, waiter=0xa4a45d64, adjustment=-65537)
at list.h:40
Previous frame inner to this frame (corrupt stack?)





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
