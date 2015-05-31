Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YzB7L-0001Jl-3T
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:50:03 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YzB7J-0006mT-Q2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:50:03 +0000
Message-ID: <556B8202.6030501@nod.at>
Date: Sun, 31 May 2015 23:49:54 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <bbdd39b2-dcac-41c8-bfb4-73645e73c7b7@email.android.com>	
	<556AED66.3030706@nod.at> <1433098827.8871.13.camel@m3y3r.de>
In-Reply-To: <1433098827.8871.13.camel@m3y3r.de>
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
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Am 31.05.2015 um 21:00 schrieb Thomas Meyer:
>> Ping.
>> Would be nice to have this patch for the 4.2 merge window.
> 
> I can provide you the current version of the patch, but I'm not sure if
> it's ready for inclusion yet.

That's fine. I'll look at it.
Just rebase it against Linus' tree or uml-next.
https://git.kernel.org/cgit/linux/kernel/git/rw/uml.git/log/?h=linux-next

> For example:
> - With this patch I see new zombie processes of UML userspace
> processes. I'm not sure what's going on here.
> - Anton reported some hang he sees with this patch
> - A person from cicso is worried about the potential idle CPU usage
> after the patch, because of the many timers started, i.e. a host with
> hundreds of UMLs.
> 
> Also meanwhile I think is not the correct thing to start a new timer
> for each UML userspace process, because the timer will also trigger the
> userspace process, even the corresponding process isn't scheduled by
> the kernel currently. I think the previous behaviour with the itimer
> was okay, because the virtual timer only did execute when the process
> was executing which is the correct thing to do for the currently active
> task in the UML kernel.
> I see two solutions for above problem: cascade the kernel timer into
> the current active task; there is actually no need to start a timer in
> each userspace process.
> Start/stop each timer when a userspace process becomes active resp.
> becomes inactive again.
> I hope above logic makes some sense at all! What do you think about
> this?

Hm, we definitely don't want a new timer for each userspace proc. The timer
has to work as a regular clock source.
But I'll have to read your/Anton's code in detail first.

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

