Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMFmp-0000zJ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 16:01:35 -0800
Received: from pisces.lunarpages.com ([64.235.234.123])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AMFmp-0002Jn-8c
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 18 Nov 2003 16:01:35 -0800
Received: from nat6-176.cs.ucdavis.edu ([169.237.6.176] helo=osiris)
	by pisces.lunarpages.com with esmtp (Exim 4.23)
	id 1AMFma-0003kR-VD
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 18 Nov 2003 16:01:21 -0800
From: sean whalen <swhalen@denature.org>
Message-ID: <20031119000020.GD16634@osiris.cs.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] wait queues broken?
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
Date: Tue, 18 Nov 2003 16:00:20 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Hi All --
Has anyone had any problems with wait queues in 2.6.0-test9 under UML?  
I have the following in my code:

wait_queue_head_t wq;
init_waitqueue_head(&wq);
interruptible_sleep_on_timeout(&wq, 5*HZ);

And the UML kernel dies when it reaches the  
interruptible_sleep_on_timeout.
Here is a gdb trace:

Program received signal SIGSEGV, Segmentation fault.
schedule () at kernel/sched.c:327
327             array->nr_active--;
(gdb) bt
#0  schedule () at kernel/sched.c:327
#1  0xa004394f in schedule_timeout (timeout=-1608944988) at kernel/ 
timer.c:1046
#2  0xa0031eab in interruptible_sleep_on_timeout (q=0xa0197354,  
timeout=500)
    at kernel/sched.c:1792
#3  0xa016c42a in wait_for_response () at net/bridge/br_stp_bpdu.c:159
#4  0xa016c63e in br_stp_handle_bpdu (skb=0x1) at net/bridge/ 
br_stp_bpdu.c:240
#5  0xa016a28f in br_handle_frame (skb=0xa1fd56ec) at net/bridge/ 
br_input.c:136
#6  0xa0118492 in netif_receive_skb (skb=0xa1fd56ec) at net/core/dev. 
c:1522
#7  0xa0118637 in process_backlog (backlog_dev=0xa01c5a48,  
budget=0xa019748c)
    at net/core/dev.c:1611
#8  0xa0118746 in net_rx_action (h=0xa01bcd78) at net/core/dev.c:1676
#9  0xa003abfa in do_softirq () at kernel/softirq.c:98
#10 0xa0014fdb in do_IRQ (irq=5, regs=0xa0198e90) at arch/um/kernel/ 
irq.c:340
#11 0xa00159da in sigio_handler () at wait.h:60
#12 0xa0022551 in sig_handler_common_skas () at wait.h:60
#13 0xa001fc58 in sig_handler () at wait.h:60
#14 <signal handler called>
#15 0x400b0e64 in setitimer () from /lib/libc.so.6
#16 0xa001ea1b in switch_timers () at wait.h:60
#17 0xa0197854 in init_thread_union ()
(gdb) display array
1: array = (prio_array_t *) 0x0

So array is a null pointer being dereferenced in sched.c.  Am I doing  
something stupid, could this possibly be a UML bug, or should I forward  
to lkml?  Any help is appreciated.

Thanks,
	-Sean


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
