Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUEPt-0001hr-CJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Apr 2006 19:52:13 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FUEPr-0002jT-5H
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Apr 2006 19:52:13 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Message-ID: <20060414015316.GA7723@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<1144974688.8548.26.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144974688.8548.26.camel@cog.beaverton.ibm.com>
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
Date: Thu, 13 Apr 2006 21:53:16 -0400
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Apr 13, 2006 at 05:31:27PM -0700, john stultz wrote:
> Looks interesting. I've never quite understood the need for different
> time domains, it only allows you to run one domain with the incorrect
> time, but I'm sure there is some use case that is desired.

There are a few possible answers -

If when this virtualization stuff is done, no one has done anything with
time, someone is going to moan.

Once in a while, you want to fiddle your system clock to make sure that
a cron job or something does what it's supposed to.

There was some extra infrastructure that UML needed in order to start using
this stuff, so I chose a fairly simple virtualization case to accompany it.

> I'm not psyched about possible namespace vs nanosecond confusion w/
> terms like "time_ns", but that's pretty minor.

Yeah, names can be changed.

> Also I hope you're not wanting to deal w/ NTP adjustments between
> domains that have the incorrect time? That would be very ugly.

No, the domain stores an offset from the system time, so it automatically
gets the system's NTP adjustments.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
