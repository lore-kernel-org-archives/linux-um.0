Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ITL04-0005yV-6V for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 10:18:40 -0700
Received: from fk-out-0910.google.com ([209.85.128.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ITL03-0004DG-Ev
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 10:18:40 -0700
Received: by fk-out-0910.google.com with SMTP id 19so249633fkr
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 06 Sep 2007 10:18:37 -0700 (PDT)
Message-ID: <719dced30709061018q8d4022fi5f22d34c7f285090@mail.gmail.com>
Date: Thu, 6 Sep 2007 13:18:37 -0400
From: "Godmar Back" <godmar@gmail.com>
In-Reply-To: <46E017FC.9000906@theshore.net>
MIME-Version: 1.0
Content-Disposition: inline
References: <46E017FC.9000906@theshore.net>
Subject: Re: [uml-devel] swapper: page allocation failure. order:0, mode:0x20
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
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

This failure means that an interrupt handler attempted to allocate
memory with GFP_ATOMIC, but you're fresh out of memory. Specifically,
your free memory is below 1/2 of the low watermark for ZONE normal. At
this point, Linux's page allocator reports it's out of memory. Direct
page reclamation (which would evict pages from their frames, freeing
up some) also cannot take place since you're in an interrupt handler
and specified GFP_ATOMIC.

Under normal operating condition, kswapd is designed to prevent this
scenario from occurring by freeing paging before the low watermark is
reached. I can only speculate what may be causing it, probably a
combination of one or more of the following:
- high frequency of network interrupts, resulting in many packets
delivered and buffered
- large memory usage by applications
- kswapd not being scheduled/run
- too little physical memory allocated in total.

 - Godmar

On 9/6/07, Christopher S. Aker <caker@theshore.net> wrote:
> 2.6.21.1-um
>
> Mem-info:
> Normal per-cpu:
> CPU 0: Hot: hi: 90, btch: 15 usd: 14 Cold: hi: 30, btch: 7 usd: 24
> Active:62085 inactive:6442 dirty:4693 writeback:2791 unstable:0
> free:196 slab:3980 mapped:12235 pagetables:241 bounce:0
> Normal free:784kB min:2208kB low:2760kB high:3312kB active:248340kB
> inactive:25768kB present:304800kB pages_scanned:1220 all_unreclaimable? no
> lowmem_reserve[]: 0
> Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB
> 0*1024kB 0*2048kB 0*4096kB = 784kB
> Swap cache: add 2548, delete 2451, find 38/63, race 0+0
> Free swap = 1037112kB
> Total swap = 1046504kB
> Free swap: 1037112kB
> 76800 pages of RAM
> 0 pages of HIGHMEM
> 2795 reserved pages
> 27381 pages shared
> 97 pages swap cached
> swapper: page allocation failure. order:0, mode:0x20
> 0858ba28: [<08065c76>] dump_stack+0x22/0x26
> 0858ba40: [<080a773f>] __alloc_pages+0x219/0x30d
> 0858ba90: [<080bb4f3>] kmem_getpages+0x22/0x80
> 0858baa0: [<080bc2be>] cache_grow+0x166/0x180
> 0858bad8: [<080bc41c>] cache_alloc_refill+0x144/0x1c0
> 0858bb08: [<080bc7e3>] __kmalloc+0x6c/0x70
> 0858bb20: [<0835f5cd>] __alloc_skb+0x55/0x104
> 0858bb3c: [<0806b0f8>] uml_net_rx+0x38/0x161
> 0858bb64: [<0806b26e>] uml_net_interrupt+0x32/0x76
> 0858bb80: [<080a1297>] handle_IRQ_event+0x25/0x60
> 0858bb9c: [<080a1324>] __do_IRQ+0x52/0xa2
> 0858bbbc: [<080631d8>] do_IRQ+0x1f/0x32
> 0858bbc8: [<08062d4c>] sigio_handler+0x56/0x6a
> 0858bbe0: [<08079114>] sig_handler_common_skas+0x94/0xe5
> 0858bc04: [<08075742>] sig_handler+0x32/0x53
> 0858bc1c: [<08077816>] hard_handler+0x1a/0x20
> 0858bc2c: [<08450828>] __restore+0x0/0x8
> 0858bf24: [<08064645>] default_idle+0x26/0x2f
> 0858bf38: [<08067afd>] init_idle_skas+0x28/0x2f
> 0858bf48: [<08064656>] cpu_idle+0x8/0xa
> 0858bf50: [<0806211c>] rest_init+0x2c/0x30
> 0858bf64: [<0804876b>] start_kernel+0x1b1/0x212
> 0858bf84: [<08067b30>] start_kernel_proc+0x2c/0x32
> 0858bf90: [<08074f4d>] run_kernel_thread+0x50/0x57
> 0858bfcc: [<080678a7>] new_thread_handler+0x80/0xcd
> 0858bffc: [<00000000>] nosmp+0xf7fb7f4c/0x14
>
> Thoughts?
>
> Thanks,
> -Chris
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
