Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bEK2A-0000NP-2U
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Jun 2016 17:27:50 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bEK28-0005zR-Oc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Jun 2016 17:27:50 +0000
References: <alpine.LNX.2.20.1606181253400.8594@atlantide2>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5765848C.1030206@nod.at>
Date: Sat, 18 Jun 2016 19:27:40 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.1606181253400.8594@atlantide2>
Subject: Re: [uml-devel] [user-mode-linux] memory leak in network path
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
To: Enrico Mioso <mrkiko.rs@gmail.com>, user-mode-linux-user@lists.sourceforge.net
Cc: jdike@addtoit.com, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi!

Am 18.06.2016 um 13:02 schrieb Enrico Mioso:
> Hi guys.
> 
> I am experiencing an user-mode-linux memory leak, that induces the user-mode kernel to eventually panic.
> 
> My sequence of actions to trigger it is relatively simple:
> - start it on an ubuntu 16.04 core image, after installing "ubuntu-standard" package
> - install aptitude and openssh-server if needed
> 
> When I type
> sudo aptitude build-dep gnuradio
> (but any package with lots of dependencies may do), I can see used memory by UML growing and growing.
> When the allocation limit I specify in the command line is reached, then it crashes.
> 
> This problem is triggerable pretty reliably on my box:
> Running a custom-compiled 4.4.12 kernel.
> 
> 
> UML kernel version: 4.6.1-usermodelinux
> 
> Thank you very much guys for your work and attention,

Please share the log of the crash.
How did you figure that UML is consuming more and more memory?

Thanks,
//richard

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports. http://sdm.link/zohomanageengine
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

