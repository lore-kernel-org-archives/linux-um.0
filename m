Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUR6S-0001ft-3s for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 09:25:00 -0700
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FUR6Q-0007u5-Ge
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 09:24:59 -0700
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3EGOYc9019270 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 14 Apr 2006 12:24:34 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3EGOOip208160 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 14 Apr 2006 12:24:24 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3EGOO19031383
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 14 Apr 2006 12:24:24 -0400
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <20060414015316.GA7723@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<1144974688.8548.26.camel@cog.beaverton.ibm.com>
	<20060414015316.GA7723@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1145031860.10781.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Fri, 14 Apr 2006 09:24:20 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, 2006-04-13 at 21:53 -0400, Jeff Dike wrote:
> On Thu, Apr 13, 2006 at 05:31:27PM -0700, john stultz wrote:
> > Looks interesting. I've never quite understood the need for different
> > time domains, it only allows you to run one domain with the incorrect
> > time, but I'm sure there is some use case that is desired.
> 
> There are a few possible answers -
> 
> If when this virtualization stuff is done, no one has done anything with
> time, someone is going to moan.

Apparently its like painting a wall then, no? 
"You missed those spots over there!"  :)


> Once in a while, you want to fiddle your system clock to make sure that
> a cron job or something does what it's supposed to.
> 
> There was some extra infrastructure that UML needed in order to start using
> this stuff, so I chose a fairly simple virtualization case to accompany it.
> 
> > I'm not psyched about possible namespace vs nanosecond confusion w/
> > terms like "time_ns", but that's pretty minor.
> 
> Yeah, names can be changed.

Well, as long as its pretty isolated its not such a big deal. Just
figured I'd bring it up as a consideration.

> > Also I hope you're not wanting to deal w/ NTP adjustments between
> > domains that have the incorrect time? That would be very ugly.
> 
> No, the domain stores an offset from the system time, so it automatically
> gets the system's NTP adjustments.

Ok, as long as you don't intend to go down that path, these patches
looks pretty harmless.

thanks
-john



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
