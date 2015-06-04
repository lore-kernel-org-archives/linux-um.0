Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Z0SWr-0004xx-23
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Jun 2015 10:37:41 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z0SWp-0000kn-Oe
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Jun 2015 10:37:41 +0000
Message-ID: <55702A6C.8@kot-begemot.co.uk>
Date: Thu, 04 Jun 2015 11:37:32 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <bbdd39b2-dcac-41c8-bfb4-73645e73c7b7@email.android.com>		<556AED66.3030706@nod.at>
	<1433098827.8871.13.camel@m3y3r.de>	
	<556B5CA0.9010200@kot-begemot.co.uk>
	<1433412294.3399.4.camel@m3y3r.de>
In-Reply-To: <1433412294.3399.4.camel@m3y3r.de>
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
Subject: Re: [uml-devel] [PATCH] um: Switch clocksource to hrtimers
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

I will give it a spin before the end of the weekend and run the full 
test suite on it.

A.

[snip]

>> Cascading the kernel timer looks like the correct solution.
> Hi,
>
> below patch get's rid of all userspace timers.
> When a kernel timer interrupt is received the userspace process of the
> corresponding task is signaled via SIGALRM.
> The SIGALRM signal forces the userspace process to go back into
> userspace() function. There the SIGALRM signal is ignored as the
> interrupt was already processed anyway by the uml kernel.
>
> what do you think about this approach?
>
> Can you give this patch a try
>
> with kind regards
> thomas
>
>
[snip]


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

