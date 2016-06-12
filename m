Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bCCZI-0001hf-OQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 21:05:16 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bCCZH-0003Fb-BN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 21:05:16 +0000
References: <CAOMGZ=GpWk1=9HeTxz6NBVh-Y8TZS8ZBHaaqDdxOqvRHD+f_TQ@mail.gmail.com>
	<6AAB4FAC-99C2-4B3C-88CA-C210193E74EF@m3y3r.de>
	<CAOMGZ=H-fi-Wqmc36ts5LULSe=QD9Q-ys7GKryFWRZw_iO-J=A@mail.gmail.com>
	<CAFLxGvw1jahqtNPkyBiMq_P4no+uersN4fGMcFqexikyLwm83w@mail.gmail.com>
	<CAOMGZ=Ha+Wwb4wbsa+yNC9HL1ZT4BYMZdGdVbGDVPb2t9AuY-w@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <575DCE83.9090203@nod.at>
Date: Sun, 12 Jun 2016 23:05:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAOMGZ=Ha+Wwb4wbsa+yNC9HL1ZT4BYMZdGdVbGDVPb2t9AuY-w@mail.gmail.com>
Subject: Re: [uml-devel] current_thread_info() returns invalid pointer in
 early UML boot code
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
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Thomas Meyer <thomas@m3y3r.de>

Am 12.06.2016 um 22:59 schrieb Vegard Nossum:
> On 12 June 2016 at 22:11, Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>>> I wonder why setup_env_path() ends up calling the kernel's snprintf(),
>>> I thought that it would be using the glibc snprintf() at this point?
>>
>> That early you cannot use current() nor any other core kernel stuff
>> since the kernel has not started so far.
>> So, the current thread info struct points to garbage.
> 
> Yes, I know. I think setup_env_path() should call the libc snprintf
> rather than the kernel one, can you explain how to do that properly?

Currently UML sets up nasty maps for known namespaces clashes.
i.e.
KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
        $(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap      \
        -Din6addr_loopback=kernel_in6addr_loopback \
        -Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr

A much better approach would be having a real linker scope.
Some time ago I posted some thoughts on that:
https://lkml.org/lkml/2015/11/19/758

Due to -ENOTIME this never materialized, though. ;-(

Thanks,
//richard

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

