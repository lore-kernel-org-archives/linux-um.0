Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1WJ6Xu-00020d-It
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 19:23:02 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WJ6Xs-0003Zz-W2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 19:23:02 +0000
Message-ID: <530F908D.6090601@nod.at>
Date: Thu, 27 Feb 2014 20:22:53 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <530F8C69.9080801@panasas.com>
In-Reply-To: <530F8C69.9080801@panasas.com>
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
Subject: Re: [uml-devel] sysreq t back traces stopped working please help
To: Boaz Harrosh <bharrosh@panasas.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>



Am 27.02.2014 20:05, schrieb Boaz Harrosh:
> Hi Richard, uml hackers
> 
> Since some time my "echo t > /proc/sysrq-trigger" stopped producing the proper global back-traces for all Kernel threads.
> All I get is:

I have an idea, do you see this regression starting with v3.12?

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

