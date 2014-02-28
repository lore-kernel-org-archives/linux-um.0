Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1WJIsv-0005AB-Cs
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Feb 2014 08:33:33 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WJIst-0005S4-G9
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Feb 2014 08:33:33 +0000
Message-ID: <531049CD.7050502@nod.at>
Date: Fri, 28 Feb 2014 09:33:17 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <53104888.8040404@cisco.com>
In-Reply-To: <53104888.8040404@cisco.com>
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
Subject: Re: [uml-devel] Contribution - Bug fixes and contributions to UML
To: "Anton Ivanov (antivano)" <antivano@cisco.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "jdike@addtoit.com" <jdike@addtoit.com>

Am 28.02.2014 09:27, schrieb Anton Ivanov (antivano):
> Hi Richard, Hi Jeff, hi list,
> 
> On behalf of Cisco systems, I am authorized to make a offer a set bug
> fixes as well as contribute several additional features and performance
> improvements to UML. All of these have been used internally for a couple
> of years and will ship as parts of product(s) in the near future. Some
> of these improve performance by up to 8 times on use cases which are of
> interest to us and are likely to be of interest to the community.
> 
> As the full patchset is now in the 100k+ zone, so I am going to do only
> the announcement now and submit the patches one by one after that over
> the next 1-2 weeks.
> 
> We will submit separately bug fixes for:
> 
> 1. Critical memory corruption on startup observed on heavily loaded
> machines (especially when multiple UMLs run simultaneously).
> 2. Fix(es) for incorrect handling of error conditions when UML is run
> under expect and conX=fd: is used to communicate with another process.
> The same error may be observed on internal UML IPCs too leading to
> immediate crash.
> 
> I will also file bugs for both vs Debian UML package so that patches for
> both can go in ASAP.
> 
> In addition to the bug fixes, the new features include:
> 
> 1. Several transports. All can do up to multi-gigabit throughput on some
> scenarios. We are contributing their counterparts to qemu/kvm as well.
> 
> 1.1. Direct connection of UML to overlay networks/L2 VPNs using L2TPv3.
> 
> This has a number of advantages compared to the existing UML "multicast"
> and qemu "socket" transports.
> 
>     * Standard compliant - RFC 3931 updated recently by RFC 5641
>     * Supported on most network equipment
>     * Allowing to move virtual switching off-host to an NPU or high
> performance physical switch
>     * Allowing to mix virtual and physical switching (well supported on
> modern Linuxes and other OSes)
>     * Well researched security profile as well as established
> interactions with IPSEC allowing to extend virtual networks outside the
> datacenter to remote physical devices and/or VMs.
> 
> 1.2. Raw transport which allows both bi-directional communication with
> any network device which looks like Ethernet as well as in-span
> listening at speeds in the multi-gigabit range.
> 
> 1.3. We intend to contribute other key overlay transports like GRE, etc
> as well. The ones we are contributing at this point are the ones which
> we have used most extensively and have had the most testing (~ 1.5-2 years).
> 
> 2. New high res timer subsystem
> 
> Adding these new network transports to UML revealed a key issue - it
> cannot meter or shape any traffic correctly as its internal timer system
> is way off. Personally, I consider it a bug, however there is no "easy"
> fix here. The only way to fix it is a new timer driver. Unfortunately,
> it does not fix uml userspace - timers there remain off. It does fix all
> kernel timer functionality - traffic shaping (both qdisc and iptables
> traffic limits).
> 
> As a side effect, this provides performance improvements for tcp and
> other protocols which rely on kernel high res timers for their state
> machines.
> 
> We have further scalability contributions lined up which improve network
> and IO performance between 1.5 and 8 times (depending on use case),
> allow hundreds of virtual interfaces per UML without performance
> penalties, allow to run several hundreds (if not thousands) of UMLs per
> machine, etc. All in all, it can no go where no virtualization and no
> virtual networking has gone before.
> 
> However, I would prefer to take it one step at a time and get through
> these first (even these are quite a lot for one "sitting").

Sounds awesome!

Please send the patches as soon as possible.
I'm eager to test and merge them.

Thanks,
//richard

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

