Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ast6U-0002c2-3p
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 16:28:46 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Asswv-0000Jm-VV
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 16:18:54 -0800
Message-Id: <200402170052.i1H0qQsq025107@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in schedule() for 2.6! 
In-Reply-To: Your message of "Mon, 16 Feb 2004 20:27:03 +0100."
             <20040216192703.GA13746@elte.hu> 
References: <200402151911.11890.blaisorblade_spam@yahoo.it> <20040216095335.GA27377@elte.hu> <200402162025.24853.blaisorblade_spam@yahoo.it>  <20040216192703.GA13746@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Feb 2004 19:52:26 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

mingo@elte.hu said:
> i cannot reproduce using 2.6.2-rc3-mm1, so it's likely some recent
> breakage. 

I can.  At least the original panic that BlaisorBlade found.  The stack shows
schedule() recursing through switch_to because of a signal arriving at the
wrong time, and the interrupt handler calling schedule():

#6  schedule () at kernel/sched.c:1680
#7  0xa00154f9 in interrupt_end () at arch/um/kernel/process_kern.c:138
#8  0xa001f5aa in userspace (regs=0xa03233b8)
    at arch/um/kernel/skas/process.c:174
#9  0xa001fd9a in fork_handler (sig=10)
    at arch/um/kernel/skas/process_kern.c:103
#10 <signal handler called>
#11 0xa016974d in syscall ()
#12 0x00000001 in ?? ()
#13 0xa7fd388c in ?? ()
#14 0xa7fd395c in ?? ()
#15 0xa0015351 in external_pid (t=0xa0323080)
    at arch/um/kernel/process_kern.c:69
#16 0xa0015487 in set_current (t=0xa0323080)
    at arch/um/kernel/process_kern.c:126
#17 0xa001fb69 in switch_to_skas (prev=0xa0a97740, next=0xa0323080)
    at arch/um/kernel/skas/process_kern.c:40
#18 0xa00154c7 in _switch_to (prev=0xa0a97740, next=0xa0323080, 
    last=0xa0a97740) at arch/um/kernel/process_kern.c:132
#19 0xa0030845 in schedule () at kernel/sched.c:919

So, this seems very wrong.  It's not obvious to me offhand what the correct
fix is, since the scheduler runs with interrupts enabled.  Time to look at what
x86 does, I guess.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
