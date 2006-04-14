Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUQO1-0005El-51 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 08:39:05 -0700
Received: from smtp3.oregonstate.edu ([128.193.0.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FUQO0-0003Ai-Km
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 08:39:05 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Message-ID: <7B4268E5ACB878429B58D4BE5B780E83507BC3@NWS-EXCH2.nws.oregonstate.edu>
From: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
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
Date: Fri, 14 Apr 2006 08:39:01 -0700
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

I'm assuming that this pulls "UTC" from the host and allows the guest to
have an offset "UTC" ... is this essentially correct?

Tony


> -----Original Message-----
> From: user-mode-linux-devel-admin@lists.sourceforge.net 
> [mailto:user-mode-linux-devel-admin@lists.sourceforge.net] On 
> Behalf Of Jeff Dike
> Sent: Thursday, April 13, 2006 6:53 PM
> To: john stultz
> Cc: linux-kernel@vger.kernel.org; 
> user-mode-linux-devel@lists.sourceforge.net
> Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
> 
> On Thu, Apr 13, 2006 at 05:31:27PM -0700, john stultz wrote:
> > Looks interesting. I've never quite understood the need for 
> different
> > time domains, it only allows you to run one domain with the 
> incorrect
> > time, but I'm sure there is some use case that is desired.
> 
> There are a few possible answers -
> 
> If when this virtualization stuff is done, no one has done 
> anything with
> time, someone is going to moan.
> 
> Once in a while, you want to fiddle your system clock to make 
> sure that
> a cron job or something does what it's supposed to.
> 
> There was some extra infrastructure that UML needed in order 
> to start using
> this stuff, so I chose a fairly simple virtualization case to 
> accompany it.
> 
> > I'm not psyched about possible namespace vs nanosecond confusion w/
> > terms like "time_ns", but that's pretty minor.
> 
> Yeah, names can be changed.
> 
> > Also I hope you're not wanting to deal w/ NTP adjustments between
> > domains that have the incorrect time? That would be very ugly.
> 
> No, the domain stores an offset from the system time, so it 
> automatically
> gets the system's NTP adjustments.
> 
> 				Jeff
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking 
> scripting language
> that extends applications into web and mobile media. Attend 
> the live webcast
> and join the prime developer group breaking into this new 
> coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&
> dat=121642
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
