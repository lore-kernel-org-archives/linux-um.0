Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lczerner@redhat.com>) id 1OBWJB-0002ZZ-EG
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 May 2010 16:58:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OBWJ9-0003oV-TC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 May 2010 16:58:21 +0000
Received: from int-mx08.intmail.prod.int.phx2.redhat.com
	(int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o4AGwEZJ006715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 10 May 2010 12:58:14 -0400
Date: Mon, 10 May 2010 18:58:25 +0200 (CEST)
From: Lukas Czerner <lczerner@redhat.com>
In-Reply-To: <alpine.LFD.2.00.1005101719500.21053@localhost>
Message-ID: <alpine.LFD.2.00.1005101849460.21053@localhost>
References: <alpine.LFD.2.00.1005101719500.21053@localhost>
MIME-Version: 1.0
Subject: Re: [uml-devel] uml: Error with Linked list debugging on
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Lukas Czerner <lczerner@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, 10 May 2010, Lukas Czerner wrote:

> Hi,
> 
> I have got an error when booting uml with Linked list manipulation
> debugging turned on. The crash occurs in the exact moment when the
> consoles are showing up - it just blinks and crush. Here is the
> backtrace:
> 
> 
> #0  0x0000003cb8233e14 in abort () from /lib64/libc.so.6
> #1  0x00000000600220b2 in os_dump_core () at arch/um/os-Linux/util.c:119
> #2  0x00000000600147c1 in panic_exit (self=<value optimized out>, unused1=<value optimized out>, 
>     unused2=<value optimized out>) at arch/um/kernel/um_arch.c:233
> #3  0x0000000060045996 in notifier_call_chain (nl=<value optimized out>, val=0, v=0x602ffb40, 
> nr_to_call=-2, nr_calls=<value optimized out>) at kernel/notifier.c:93
> #4  0x00000000600459e4 in __atomic_notifier_call_chain (nh=<value optimized out>, 
> val=<value optimized out>, v=<value optimized out>) at kernel/notifier.c:182
> #5  atomic_notifier_call_chain (nh=<value optimized out>, val=<value optimized out>, 
> v=<value optimized out>) at kernel/notifier.c:191
> #6  0x00000000601a56d0 in panic (fmt=0x601f3050 "Kernel mode fault at addr 0x%lx, ip 0x%lx")
> at kernel/panic.c:115
> #7  0x00000000600145df in segv (fi=..., ip=1611852984, is_user=0, regs=0x6024fa10)
> at arch/um/kernel/trap.c:201
> #8  0x000000006001463e in segv_handler (sig=<value optimized out>, regs=<value optimized out>)
> at arch/um/kernel/trap.c:147
> #9  0x00000000600211a4 in sig_handler_common (sig=11, sc=0x6024fbe8) at arch/um/os-Linux/signal.c:49
> #10 0x00000000600212ea in sig_handler (sig=<value optimized out>, sc=<value optimized out>)
> at arch/um/os-Linux/signal.c:226
> #11 0x000000006002151c in handle_signal (sig=<value optimized out>, sc=0x6024fbe8)
>     at arch/um/os-Linux/signal.c:158
> #12 0x0000000060022e9c in hard_handler (sig=<value optimized out>)
> at arch/um/os-Linux/sys-x86_64/signal.c:15
> #13 <signal handler called>
> #14 0x000000006012ecb8 in list_del (entry=0x807bcf00) at lib/list_debug.c:46
> #15 0x0000000060016724 in free_winch (winch=0x807bcf00, free_irq_ok=0) at arch/um/drivers/line.c:731
> #16 0x0000000060016ad7 in winch_interrupt (irq=<value optimized out>, data=0x807bcf00)
> at arch/um/drivers/line.c:760
> #17 0x0000000060055b45 in __free_irq (irq=10, dev_id=0x807bcf00) at kernel/irq/manage.c:937
> #18 0x0000000060055bc0 in free_irq (irq=10, dev_id=0x807bcf00) at kernel/irq/manage.c:986
> #19 0x0000000060016765 in free_winch (winch=0x807bcf00, free_irq_ok=1) at arch/um/drivers/line.c:740
> #20 0x0000000060017211 in unregister_winch (tty=0x8072a800, filp=<value optimized out>)
> at arch/um/drivers/line.c:836
> #21 line_close (tty=0x8072a800, filp=<value optimized out>) at arch/um/drivers/line.c:477
> #22 0x00000000601335d9 in tty_release (inode=0x7eff4190, filp=0x7fc9abc0) at drivers/char/tty_io.c:1580
> #23 0x000000006007e6a8 in __fput (file=0x7fc9abc0) at fs/file_table.c:254
> #24 0x000000006007e79c in fput (file=<value optimized out>) at fs/file_table.c:200
> #25 0x000000006007b995 in filp_close (filp=0x7fc9abc0, id=0x7fc720c0) at fs/open.c:1124
> #26 0x000000006007ba4a in sys_close (fd=3) at fs/open.c:1153
> #27 0x0000000060014c7c in handle_syscall (r=0x7e1ba418) at arch/um/kernel/skas/syscall.c:35
> #28 0x0000000060023e7f in handle_trap (regs=0x7e1ba418) at arch/um/os-Linux/skas/process.c:201
> #29 userspace (regs=0x7e1ba418) at arch/um/os-Linux/skas/process.c:417
> #30 0x000000006001265b in fork_handler () at arch/um/kernel/process.c:181
> 
> 
> Apparently, the winch is not in the list when the free_winch is
> invoked. Kernel version 2.6.34-rc7
> 
> 
> Best Regards.
> -Lukas.
> 

Also you should have Debug shared IRQ handlers turned on, because
actually this is causing problem (kernel/irq/manage.c:line 926) when
testing shared irq. Handler (unregister_winch) is not capable to
handle it and cause double invocation of free_winch, which leads to
crash.

Maybe some winch validity flag would be useful, but I am not familiar
with the uml code so I will rather leave it to someone who is.

-Lukas.


------------------------------------------------------------------------------

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

