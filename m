Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FDlDf-00024o-Gl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Feb 2006 08:27:31 -0800
Received: from www.scgiservices.com ([198.107.3.66] helo=www.sterlingcgi.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FDlDe-0001aQ-5n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Feb 2006 08:27:31 -0800
Message-ID: <20060227082727.o13emtxbxnkg8g8g@www.scgiservices.com>
From: Anthony Brock <brocka@sterlingcgi.com>
References: <LEEIJGBJEEABAGOFFGAHEEKCDEAA.brocka@sterlingcgi.com>
	<CBELIFGMBIEPIEOFCJFAGEMACAAA.brocka@sterlingcgi.com>
	<20060215183943.GA7120@ccure.user-mode-linux.org>
	<20060215130933.mn5mlmmh8hkowgsk@www.scgiservices.com>
	<20060217205204.GC2889@ccure.user-mode-linux.org>
In-Reply-To: <20060217205204.GC2889@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] Crash and stability problems with
	2.6.15.3-bs2
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
Date: Mon, 27 Feb 2006 08:27:27 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Sorry for taking so long to get back on this. We've been busy with some 
other issues. Some comments are inline below in addition to the output 
from a new crash.

Quoting Jeff Dike <jdike@addtoit.com>:
> On Wed, Feb 15, 2006 at 01:09:33PM -0800, Anthony Brock wrote:
> Also, this is x86_64, correct?  If so, try
> 	echo 0 > /proc/sys/kernel/vsyscall64

Both host and client are 32-bit. The host is a dual AMD Opteron, but 
we're running the 32-bit (SMP) version of Linux.

> As for the OOM cases, the data that BB asked for would still be
> helpful in diagnosing them.

I'll try to get that to you later this week.

In the mean time, we've experienced a second crash with the 
2.6.15.1-bs1 kernel. It looks to be very similar to the previous crash. 
Only, in this case, I issued the command "uml_mconsole www-prod-1 sysrq 
s" in preparation for a backup (after issuing a "uml_mconsole $1 stop" 
command). I am including the first dump below. The rest of the dump can 
be found at:

http://www.coherenthosting.com/prj/uml/miscellaneous/error.txt

The time stamp at the top is in UTC, and specifies when the crash started.

Tony

-- time-stamp -- Feb/27/06 16:03:00 --
SysRq : Emergency Sync
events/0: page allocation failure. order:0, mode:0x20
0829f510:  [<0808a1f3>] __alloc_pages+0x274/0x286
0829f550:  [<0808c7e5>] kmem_getpages+0x4a/0x9f
0829f564:  [<0808d2b4>] cache_grow+0x96/0x122
0829f598:  [<0808d493>] cache_alloc_refill+0x153/0x186
0829f5bc:  [<0808d62d>] kmem_cache_alloc+0x34/0x44
0829f5d0:  [<0808d134>] alloc_slabmgmt+0x20/0x45
0829f5e4:  [<0808d2cc>] cache_grow+0xae/0x122
0829f614:  [<0808d493>] cache_alloc_refill+0x153/0x186
0829f638:  [<0808d6dc>] __kmalloc+0x5b/0x6d
0829f654:  [<08171704>] __alloc_skb+0x52/0x129
0829f670:  [<0806097e>] uml_net_rx+0x1e/0x13c
0829f690:  [<08060ac0>] uml_net_interrupt+0x1f/0x91
0829f6d4:  [<0808595b>] handle_IRQ_event+0x24/0x54
0829f6f8:  [<080859de>] __do_IRQ+0x53/0x91
0829f70c:  [<08057bc8>] do_IRQ+0x20/0x2c
0829f714:  [<08057d5d>] sigio_handler+0xa5/0xcf
0829f72c:  [<0805e435>] sig_handler_common_skas+0xa5/0xbe
0829f750:  [<0806792e>] sig_handler+0xe/0x11
0829f860:  [<08057cdf>] sigio_handler+0x27/0xcf
0829f87c:  [<0805e435>] sig_handler_common_skas+0xa5/0xbe
0829f8a0:  [<0806792e>] sig_handler+0xe/0x11
0829f9e8:  [<0805a694>] set_signals+0xa4/0xc0
0829fa28:  [<0805a694>] set_signals+0xa4/0xc0
0829fa64:  [<0805a694>] set_signals+0xa4/0xc0
0829fa8c:  [<0805a694>] set_signals+0xa4/0xc0
0829fae0:  [<0805a641>] set_signals+0x51/0xc0
0829fb80:  [<081607e6>] handle_sysrq+0x1c/0x20
0829fb94:  [<0806258b>] mconsole_sysrq+0x5d/0x63
0829fbc0:  [<0806220f>] mconsole_stop+0x40/0x78
0829fbcc:  [<08061e1d>] mc_work_proc+0x38/0x4f
0829fbdc:  [<0807c175>] worker_thread+0x188/0x205
0829fbe4:  [<08061de5>] mc_work_proc+0x0/0x4f
0829fc08:  [<0806bde4>] default_wake_function+0x0/0x12
0829fc2c:  [<0807bfed>] worker_thread+0x0/0x205
0829fc30:  [<0807f21b>] kthread+0x74/0x9a
0829fc4c:  [<0807f1a7>] kthread+0x0/0x9a
0829fc54:  [<0806784e>] run_kernel_thread+0x30/0x3b
0829fc64:  [<0807f1a7>] kthread+0x0/0x9a
0829fc70:  [<08067838>] run_kernel_thread+0x1a/0x3b
0829fce8:  [<0806b8e4>] schedule_tail+0x23/0xb5
0829fcfc:  [<0805de14>] new_thread_handler+0x7f/0xa7
0829fd00:  [<0807f1a7>] kthread+0x0/0x9a

Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 18, batch 3 used:2
cpu 0 cold: low 0, high 6, batch 1 used:5
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         376kB (0kB HighMem)
Active:2985 inactive:8684 dirty:4 writeback:0 unstable:0 free:94 
slab:3428 mapped:933 pagetables:48
DMA free:376kB min:1024kB low:1280kB high:1536kB active:11940kB 
inactive:34736kB present:65536kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = 376kB
DMA32: empty
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 655340kB
Total swap = 655340kB
Free swap:       655340kB
16384 pages of RAM
0 pages of HIGHMEM
952 reserved pages
11194 pages shared
0 pages swap cached




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
