Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BzlV2-00041X-Rs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Aug 2004 17:18:48 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BzlV2-0002Xd-0H for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Aug 2004 17:18:48 -0700
Message-ID: <412BDB02.6090509@exse.net>
From: =?ISO-8859-1?Q?Sebastian_B=F6hm?= <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] kernel panic with 2.6.7-bb6
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
Date: Wed, 25 Aug 2004 02:19:14 +0200
To: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi,

I had a kernel panic while just hanging around in the shell (connected 
via ssh).

the host kernel is 2.6.7 , the client kernel is 2.6.7-bb6. (skas ; 
sysemu enabled ; no /dev/anon ; no COW; no hostfs (reiserfs); 
/dev/net/tun networking, some swap from a swap file in the udb 
root-filesystem, most on default in ".config", but absolute 
minimalistic, all uncesessary things removed (filesystems,sound, tt 
support, ...)  )

Do you have an idea why gdb did not stop at the kernel panic (I did 
"break panic"), but exited. So I am not able to provide a backtrace.


/sebastian



----------------------------
Kernel panic: Kernel mode fault at addr 0x40007, ip 0x0
In interrupt handler - not syncing

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace:  [<a0034c5d>] notifier_call_chain+0x2d/0x50
 [<a0028c4b>] panic+0xab/0x130
 [<a0022cb1>] arch_fixup+0x11/0x30
 [<a0016591>] segv+0x201/0x230
 [<a00193e1>] sig_handler_common_skas+0x81/0xa0

    [<a00168b8>] sig_handler+0x18/0x20
 [<a00147d3>] change_signals+0x73/0xa0
 [<a0016887>] segv_handler+0xd7/0xe0
 [<a0014832>] unblock_signals+0x12/0x20
 [<a00193e1>] sig_handler_common_skas+0x81/0xa0
 [<a00168b8>] sig_handler+0x18/0x20

    [<a00461e1>] free_block+0x31/0xd0
 [<a000f50e>] handle_IRQ_event+0x4e/0x70
 [<a000f6c4>] do_IRQ+0x94/0xd0
 [<a000fe0d>] sigio_handler+0x3d/0x130
 [<a00193e1>] sig_handler_common_skas+0x81/0xa0
 [<a00168b8>] sig_handler+0x18/0x20

    [<a00149ec>] set_signals+0xfc/0x1c0
 [<a00149ec>] set_signals+0xfc/0x1c0
 [<a00148c4>] get_signals+0x84/0xb0
 [<a00149ec>] set_signals+0xfc/0x1c0
 [<a00149ec>] set_signals+0xfc/0x1c0
 [<a00147d3>] change_signals+0x73/0xa0

    [<a00148c4>] get_signals+0x84/0xb0
 [<a00147d3>] change_signals+0x73/0xa0
 [<a0011761>] __virt_to_page+0x11/0x30
 [<a0046a07>] drain_array+0x67/0xa0
 [<a0046b67>] reap_timer_fnc+0x67/0x1c0
 [<a0046b00>] reap_timer_fnc+0x0/0x1c0

    [<a0030dc4>] run_timer_softirq+0xc4/0x190
 [<a002c975>] __do_softirq+0xa5/0xb0
 [<a002c9c5>] do_softirq+0x45/0x50
 [<a000f6fb>] do_IRQ+0xcb/0xd0
 [<a0015cd0>] timer_irq+0x150/0x190
 [<a0015f7b>] timer_handler+0x2b/0x30

    [<a00193e1>] sig_handler_common_skas+0x81/0xa0
 [<a0018d10>] start_kernel_proc+0x0/0x30
 [<a00189d0>] new_thread_handler+0x0/0x100
 [<a00168e9>] alarm_handler+0x29/0x60
 [<a00168b8>] sig_handler+0x18/0x20
 [<a00189d0>] new_thread_handler+0x0/0x100

    [<a0018d10>] start_kernel_proc+0x0/0x30
 [<a0012845>] default_idle+0x45/0x70
 [<a00149ec>] set_signals+0xfc/0x1c0
 [<a00149ec>] set_signals+0xfc/0x1c0
 [<a00149ec>] set_signals+0xfc/0x1c0
 [<a00183df>] switch_threads+0x5f/0x60

    [<a00148c4>] get_signals+0x84/0xb0
 [<a00147d3>] change_signals+0x73/0xa0
 [<a0014832>] unblock_signals+0x12/0x20
 [<a0025c67>] finish_task_switch+0x27/0x70
 [<a012a77f>] schedule+0x28f/0x400
 [<a00189d0>] new_thread_handler+0x0/0x100

    [<a0015b24>] idle_sleep+0x24/0x30
 [<a001285d>] default_idle+0x5d/0x70
 [<a00189d0>] new_thread_handler+0x0/0x100
 [<a000be91>] rest_init+0x21/0x30
 [<a000bf10>] init+0x0/0x100
 [<a0018d05>] init_idle_skas+0x25/0x30

    [<a0001549>] start_kernel+0x149/0x170
 [<a00012b0>] unknown_bootoption+0x0/0x120
 [<a0014812>] block_signals+0x12/0x20
 [<a0018d39>] start_kernel_proc+0x29/0x30
 [<a0018d10>] start_kernel_proc+0x0/0x30
 [<a00122e9>] run_kernel_thread+0x49/0x50

    [<a0018d10>] start_kernel_proc+0x0/0x30
 [<a00189d0>] new_thread_handler+0x0/0x100
 [<a00122ce>] run_kernel_thread+0x2e/0x50
 [<a0018d10>] start_kernel_proc+0x0/0x30
 [<a00189d0>] new_thread_handler+0x0/0x100
 [<a0018a7e>] new_thread_handler+0xae/0x100

    [<a0018d10>] start_kernel_proc+0x0/0x30
 [<a00189d0>] new_thread_handler+0x0/0x100
 [<a0018aed>] new_thread_proc+0x1d/0x30

 ---Type <return> to continue, or q <return> to quit---Detaching after 
fork from child process 1937.


Program exited with code 01.
(gdb)



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
