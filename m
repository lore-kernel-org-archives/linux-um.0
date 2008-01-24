Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JIBND-0004SH-BI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jan 2008 15:20:43 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JIBN9-0006JS-A7
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jan 2008 15:20:42 -0800
Message-ID: <47991D3C.50303@nagafix.co.uk>
Date: Thu, 24 Jan 2008 23:20:28 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <4797C6A5.1030408@nagafix.co.uk>
	<20080123232313.GA11799@c2.user-mode-linux.org>
In-Reply-To: <20080123232313.GA11799@c2.user-mode-linux.org>
Subject: Re: [uml-devel] console and do_syscall_stub
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Jeff Dike wrote:
> On Wed, Jan 23, 2008 at 10:58:45PM +0000, Antoine Martin wrote:
>> [42949466.740000] do_syscall_stub : ret = -12, offset = 548682067984,
>> data = 00000000606b1010
> 
> This usually means that a UML process hit the host's vm_area_struct limit.
> 
> Look at the host's /proc/sys/vm/max_map_count - the default is 64K,
> which, given UML's propensity to map memory one page at a time, covers
> 256M of resident memory for a UML process.
> 
> I'd say double or quadruple it, depending on how much memory you think
> a process can use.  To be absolutely safe, make it big enough to cover
> all of a UML's physical memory, since a process RSS can't exceed that.
> 
Thanks, hasn't happened since.

Any idea about this console thing?
(....)
[42949547.530000] Failed to open console 12, err = -2
[42949547.530000] Failed to open console 12, err = -2
[42949547.530000] Failed to open console 12, err = -2
[42949547.990000] Failed to open console 12, err = -2
[42949548.160000] Failed to open console 12, err = -2
[42949548.190000] Failed to open console 12, err = -2
[42949548.740000] Failed to open console 12, err = -2
[42949549.390000] Failed to open console 12, err = -2
[42949550.270000] Failed to open console 12, err = -2
[42949551.710000] Failed to open console 12, err = -2
[42949555.500000] Failed to open console 12, err = -2
[42949559.010000] Failed to open console 12, err = -2
[42949566.330000] Failed to open console 12, err = -2
[42949572.620000] Failed to open console 12, err = -2
[42949593.450000] syslog-ng invoked oom-killer: gfp_mask=0xa01d2,
order=0, oomkilladj=0
[42949593.450000] Call Trace:
[42949593.450000] 7f2afb18:  [<60047774>] printk_ratelimit+0x15/0x17
[42949593.450000] 7f2afb28:  [<6006eb0f>] out_of_memory+0x7c/0xf9
[42949593.450000] 7f2afb68:  [<6006fc5f>] __alloc_pages+0x229/0x2b4
[42949593.450000] 7f2afbe8:  [<60071bb3>]
__do_page_cache_readahead+0xb5/0x167
[42949593.450000] 7f2afc20:  [<60059c5f>] wake_bit_function+0x0/0x2a
[42949593.450000] 7f2afc58:  [<60071d40>] do_page_cache_readahead+0x52/0x5f
[42949593.450000] 7f2afc88:  [<6006cb5a>] filemap_fault+0x151/0x272
[42949593.450000] 7f2afce8:  [<60078c4d>] __do_fault+0x86/0x375
[42949593.450000] 7f2afd68:  [<60078f70>] do_linear_fault+0x34/0x36
[42949593.450000] 7f2afd88:  [<60079228>] handle_mm_fault+0x13e/0x23d
[42949593.450000] 7f2afde8:  [<6001794f>] handle_page_fault+0x11f/0x242
[42949593.450000] 7f2afe48:  [<60017c00>] segv+0xb4/0x2b8
[42949593.450000] 7f2aff28:  [<60017b46>] segv_handler+0x68/0x6e
[42949593.450000] 7f2aff48:  [<6003a7a5>] get_skas_faultinfo+0x9c/0xa1
[42949593.450000] 7f2aff68:  [<6003ad4f>] userspace+0x13a/0x19d
[42949593.450000] 7f2affc8:  [<600186d6>] fork_handler+0x86/0x8d
[42949593.450000]
[42949593.450000] Mem-info:
[42949593.450000] Normal per-cpu:
[42949593.450000] CPU    0: Hot: hi:  186, btch:  31 usd:  22   Cold:
hi:   62, btch:  15 usd:  30
[42949593.450000] Active:122119 inactive:48 dirty:0 writeback:0 unstable:0
[42949593.450000]  free:719 slab:1833 mapped:3 pagetables:317 bounce:0
[42949593.450000] Normal free:2876kB min:2876kB low:3592kB high:4312kB
active:488476kB inactive:192kB present:517120kB pages_scanned:734521
all_unreclaimable? yes
[42949593.450000] lowmem_reserve[]: 0 0
[42949593.450000] Normal: 25*4kB 3*8kB 0*16kB 0*32kB 1*64kB 1*128kB
0*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 2876kB
[42949593.450000] Swap cache: add 0, delete 0, find 0/0, race 0+0
[42949593.450000] Free swap  = 0kB
[42949593.450000] Total swap = 0kB
[42949593.450000] Free swap:            0kB
[42949593.450000] 131072 pages of RAM
[42949593.450000] 0 pages of HIGHMEM
[42949593.450000] 5658 reserved pages
[42949593.450000] 23 pages shared
[42949593.450000] 0 pages swap cached
[42949593.450000] Out of memory: kill process 2939 (syslog-ng) score
7875 or a child
[42949593.450000] Killed process 2939 (syslog-ng)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHmR07GK2zHPGK1rsRChM2AJsFWORF7/7RsEbEZrgtwvWrpHOAWgCfZm+8
gpvM9JRNUPgTeUYUc2ba4Q0=
=dEeA
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
