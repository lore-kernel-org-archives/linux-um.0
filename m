Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcAfp-0005TS-0l for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 15:57:13 -0800
Received: from mamba.nagafix.co.uk ([194.145.196.68] helo=mail2.nagafix.co.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcAfo-0000Py-Mq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 15:57:13 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200511142127.29052.blaisorblade@yahoo.it>
References: <1131140395.27405.6.camel@localhost.localdomain>
	<200511111848.01764.blaisorblade@yahoo.it>
	<1131742176.23542.17.camel@localhost.localdomain>
	<200511142127.29052.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1132099022.12792.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.6.14-bs1
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
Date: Tue, 15 Nov 2005 23:57:02 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> However, I _did_ test with that GCC and things work ok. So it's definitely the 
> hardening patches.
Probably.

> However, I _can_ test them:
> gentoo # gcc-config -l
>  [1] x86_64-pc-linux-gnu-3.4.4 *
>  [2] x86_64-pc-linux-gnu-3.4.4-hardened
>  [3] x86_64-pc-linux-gnu-3.4.4-hardenednopie
>  [4] x86_64-pc-linux-gnu-3.4.4-hardenednopiessp
>  [5] x86_64-pc-linux-gnu-3.4.4-hardenednossp
I've got similar settings - on a x86 box this time:
# gcc-config -l
 [1] i686-pc-linux-gnu-3.3.6 *
 [2] i686-pc-linux-gnu-3.3.6-hardenednopie
 [3] i686-pc-linux-gnu-3.3.6-hardenednopiessp
 [4] i686-pc-linux-gnu-3.3.6-hardenednossp
 [5] i686-pc-linux-gnu-3.3.6-vanilla

 CC      arch/um/kernel/skas/clone.o
arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
arch/um/include/sysdep/stub.h:32: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:53: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:42: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:75: error: can't find a register in class
`BREG' while reloading `asm'
make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
make[1]: *** [arch/um/kernel/skas] Error 2
make: *** [arch/um/kernel] Error 2

So I built a 2.6.14 instead. Then tried running in skas0:

It ended up spinning at 100% cpu usage (and eventually detecting it):
[42949375.230000] VFS: Mounted root (reiserfs filesystem) readonly.
[42949384.260000] BUG: soft lockup detected on CPU#0!
[42949384.260000]
[42949384.260000] EIP: 0073:[<a02554c1>] CPU: 0 Not tainted ESP: 007b:b7f75f6c EFLAGS: 00000292
[42949384.260000]     Not tainted
[42949384.260000] EAX: 00000000 EBX: 00002136 ECX: 00000013 EDX: a035d364
[42949384.260000] ESI: a0437940 EDI: 00002132 EBP: b7f75f98 DS: 007b ES: 007b
[42949384.260000] a10a6f70:  [<a00501d4>] show_regs+0x214/0x220
[42949384.260000] a10a6fa0:  [<a00785c7>] softlockup_tick+0x57/0x60
[42949384.260000] a10a6fc0:  [<a0062037>] do_timer+0x47/0xd0
[42949384.260000] a10a6fd0:  [<a001bee4>] um_timer+0x14/0x50
[42949384.260000] a10a6fe0:  [<a0078763>] handle_IRQ_event+0x33/0x80
[42949384.260000] a10a7010:  [<a0078805>] __do_IRQ+0x55/0xb0
[42949384.260000] a10a7040:  [<a00152f0>] do_IRQ+0x30/0x40
[42949384.260000] a10a7050:  [<a001be33>] timer_irq+0x113/0x170
[42949384.260000] a10a7080:  [<a001c1f0>] timer_handler+0x70/0x90
[42949384.260000] a10a70a0:  [<a0025254>] sig_handler_common_skas+0xc4/0x150
[42949384.260000] a10a70f0:  [<a00496a4>] alarm_handler+0xa4/0xc0
[42949384.260000] a10a7120:  [<ffffe420>] _etext+0x5fd5795d/0x0
[42949384.260000] a10a7428:  [<a001ca6c>] flush_tlb_kernel_range_common+0xbc/0x160
[42949384.260000] a10a7458:  [<a001cc8e>] flush_tlb_kernel_vm+0x2e/0x30
[42949384.260000] a10a7468:  [<a001d261>] segv+0x281/0x2d0
[42949384.260000] a10a7558:  [<a001d63c>] segv_handler+0xfc/0x150
[42949384.260000] a10a75c8:  [<a0025254>] sig_handler_common_skas+0xc4/0x150
[42949384.260000] a10a7618:  [<a00495f6>] sig_handler+0x76/0x80
[42949384.260000] a10a7648:  [<ffffe420>] _etext+0x5fd5795d/0x0
[42949384.260000] a10a79a0:  [<a00c86b6>] load_elf_binary+0x6c6/0x1040
[42949384.260000] a10a7af0:  [<a00a5fe3>] search_binary_handler+0x63/0xf0
[42949384.260000] a10a7b20:  [<a00a6202>] do_execve+0x192/0x260
[42949384.260000] a10a7b50:  [<a0014908>] execve1+0x38/0x80
[42949384.260000] a10a7b80:  [<a0014972>] um_execve+0x22/0x60
[42949384.260000] a10a7ba0:  [<a00141bc>] run_init_process+0x4c/0x80
[42949384.260000] a10a7bd0:  [<a00142b8>] init+0xc8/0x170
[42949384.260000] a10a7bf0:  [<a00494ff>] run_kernel_thread+0x9f/0xb0
[42949384.260000] a10a7ce0:  [<a00248c3>] new_thread_handler+0xc3/0x120
[42949384.260000] a10a7d20:  [<ffffe420>] _etext+0x5fd5795d/0x0
[42949384.260000]
After that I tried reducing the guest ram, the clue was seeing this message:
Kernel virtual memory size shrunk to 258998272 bytes
It continuously got stuck on:
[42949375.540000] Kernel panic - not syncing: copy_context_skas0 : failed to wait for SIGUSR1/SIGTRAP, pid = 8484, n = 8484, errno = 0, status = 0xb7f

skas3 works absolutely  fine.
The only problem I've got with skas3 is that it requires /proc/mm in
the chroot and the only way that I found to do this is to mount it in
there. (SELinux will need some work to allow me to restrict write
access to just /proc/mm and not the whole /proc...)

Antoine



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
