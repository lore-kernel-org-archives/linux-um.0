Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJVb2-0000uV-Gy for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Mar 2006 04:59:24 -0800
Received: from ns6.enix.org ([193.19.211.1] helo=the-doors.enix.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FJVaz-0007ie-7i
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Mar 2006 04:59:24 -0800
Received: from thomas.toulouse (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id 6E06A91D83
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 15 Mar 2006 13:59:07 +0100 (CET)
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
Message-ID: <20060315135915.63d0443e@thomas.toulouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Soft lockup with 2.6.15+bs3-tls
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
Date: Wed, 15 Mar 2006 13:59:15 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

[ Please Cc: me the replies, I'm not on the list. Thanks ! ]

While using 'gcc' under UML 2.6.15 patched with bs3-tls, no patch on
the host, I get the following soft lockup. The soft lockup is fully
reproducible, and always occurs while compiling a specific file of the
software I'm compiling under UML.

BUG: soft lockup detected on CPU#0!

EIP: 0073:[<080c7900>] CPU: 0 Not tainted ESP: 007b:bf61c31c EFLAGS:
00000206 Not tainted
EAX: 0000000f EBX: 00000001 ECX: 0000021d EDX: 411442dc
ESI: 411442d0 EDI: 00000000 EBP: bf61c338 DS: 007b ES: 007b
a164fb6c:  [<a0033502>] show_regs+0x1e2/0x1f0
a164fb9c:  [<a0066358>] softlockup_tick+0x88/0xa0
a164fbbc:  [<a004a036>] do_timer+0x46/0x100
a164fbd0:  [<a0017fa2>] um_timer+0x12/0x60
a164fbe0:  [<a00665ed>] handle_IRQ_event+0x3d/0x90
a164fc08:  [<a00666d2>] __do_IRQ+0x92/0x100
a164fc3c:  [<a0012064>] do_IRQ+0x24/0x30
a164fc48:  [<a0017ee0>] timer_irq+0x140/0x1a0
a164fc74:  [<a00182d3>] timer_handler+0x63/0x80
a164fc8c:  [<a001ff53>] user_signal+0x73/0x80
a164fca4:  [<a001f218>] userspace+0x1b8/0x380
a164fd08:  [<a001f646>] fork_handler+0xc6/0xe0
a164fd20:  [<ffffe420>] _etext+0x5fe2259e/0x0

oom-killer: gfp_mask=0x200d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 6, batch 1 used:0
cpu 0 cold: low 0, high 2, batch 1 used:1
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:        1024kB (0kB HighMem)
Active:5845 inactive:43 dirty:0 writeback:41 unstable:0 free:256
slab:618 mapped:5844 pagetables:78 DMA free:1024kB min:724kB low:904kB
high:1084kB active:23380kB inactive:172kB present:32768kB
pages_scanned:3014 all_unreclaimable? no lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no lowmem_reserve[]: 0 0
0 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no lowmem_reserve[]: 0 0
0 0 HighMem free:0kB min:128kB low:128kB high:128kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0 DMA: 76*4kB 0*8kB 1*16kB 0*32kB 1*64kB
1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1024kB DMA32:
empty Normal: empty HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
8192 pages of RAM
0 pages of HIGHMEM
1261 reserved pages
92 pages shared
0 pages swap cached
Out of Memory: Killed process 935 (cc1).
gcc: Internal error: Killed (program cc1)
Please submit a full bug report.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
For Debian GNU/Linux specific bug reporting instructions,
see <URL:file:///usr/share/doc/gcc-3.3/README.Bugs>.

Sincerly,

Thomas
-- 
Thomas Petazzoni - thomas.petazzoni@enix.org
http://{thomas,sos,kos}.enix.org - http://www.toulibre.org
http://www.{livret,agenda}dulibre.org


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
