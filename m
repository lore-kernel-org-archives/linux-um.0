Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bx2TS-0001ui-QO for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Aug 2004 04:49:54 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1Bx2Q3-00035L-II
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Aug 2004 04:49:54 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1Bx2Q0-0000oL-3Y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Aug 2004 04:46:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id 22114216ED
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Aug 2004 13:45:01 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16710-17
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Aug 2004 13:45:00 +0200 (CEST)
Received: from [10.0.2.5] (port-212-202-42-103.dynamic.qsc.de [212.202.42.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 8BEF7216CC
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Aug 2004 13:45:00 +0200 (CEST)
Message-ID: <4121EFCB.20400@exse.net>
From: seb <seb@exse.net>
MIME-Version: 1.0
References: <4121EE8B.2090804@exse.net>
In-Reply-To: <4121EE8B.2090804@exse.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.4.26-3 crash
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
Date: Tue, 17 Aug 2004 13:45:15 +0200
To: user-mode-linux-devel@lists.sourceforge.net

another backtrace of the same problem, happens all the time I play 
around with apt-get.

Breakpoint 1, panic (fmt=0x846d000 "") at panic.c:58
58              machine_paniced = 1;
(gdb) bt
#0  panic (fmt=0x846d000 "") at panic.c:58
#1  0x080d6258 in handle_page_fault (address=138858532, ip=0, is_write=2,
    is_user=1, code_out=0x846fbfc) at trap_kern.c:56
#2  0x080d63a6 in segv (address=138858532, ip=0, is_write=2, is_user=1,
    sc=0x846d000) at trap_kern.c:133
#3  0x080d7c44 in handle_segv (pid=138858496) at process.c:56
#4  0x080d803a in userspace (regs=0x846c270) at process.c:157
#5  0x080d8944 in fork_handler (sig=10) at process_kern.c:104
#6  <signal handler called>
#7  0x40044721 in kill () from /lib/libc.so.6
#8  0x080dd3ca in os_usr1_process (pid=0) at process.c:98
#9  0x080d8112 in new_thread (stack=0x846c000, switch_buf_ptr=0x0,
    fork_buf_ptr=0x0, handler=0x80d88c0 <fork_handler>) at process.c:199
#10 0x080d89df in copy_thread_skas (nr=0, clone_flags=17, sp=0, stack_top=0,
    p=0x846c000, regs=0x0) at process_kern.c:133
#11 0x080d251b in copy_thread (nr=0, clone_flags=0, sp=0, stack_top=0,
    p=0x846c000, regs=0x0) at process_kern.c:165
#12 0x09a1fb94 in ?? ()
#13 0x0b967b20 in ?? ()
#14 0x00000000 in ?? ()
#15 0x0846c000 in ?? ()
#16 0x0816dec0 in warn.2 ()
#17 0x00000003 in ?? ()
---Type <return> to continue, or q <return> to quit---
#18 0x09b41560 in ?? ()
#19 0x09a1fb3c in ?? ()
#20 0x0000019d in ?? ()
#21 0x00000000 in ?? ()
#22 0x00000000 in ?? ()
#23 0x09a1fbbc in ?? ()
#24 0x08057743 in sys_wait4 (pid=17, stat_addr=0x9b41560, options=161595392,
    ru=0x80d5f6a) at exit.c:580
Previous frame identical to this frame (corrupt stack?)



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
