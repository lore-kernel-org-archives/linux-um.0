Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5Uj8-0002qi-4z for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 12:37:02 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C5Uj7-0006Un-Ft for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 12:37:02 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <7153203.1094632577758.SLOX.WebMail.wwwrun@webmail.helinet.de>
	<200409092024.17925.blaisorblade_spam@yahoo.it>
	<20040909184951.GM5330@alcor.net>
In-Reply-To: <20040909184951.GM5330@alcor.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409092133.35518.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] UML hanging at "Activating swap"
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
Date: Thu, 9 Sep 2004 21:33:35 +0200
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-user@lists.sourceforge.net, Dennis Ploeger <ploeger@helinet.de>, Michael West <quagly@mitzit.net>, user-mode-linux-devel@lists.sourceforge.net

On Thursday 09 September 2004 20:49, Matt Zimmerman wrote:
> On Thu, Sep 09, 2004 at 08:24:17PM +0200, BlaisorBlade wrote:
> > On Thursday 09 September 2004 15:48, Dennis Ploeger wrote:
> > > Hi!
> > >
> > > Just for your info: Done it.
> > >
> > > I've tried to deactivate swapping (and found out, where I can do that),
> > > but that wasn't the point after all. It was hwclock (which was
> > > activated _after_ activating the swap, but didn't show any output).
> > > After deactivating that, it worked.
> >
> > Thanks a lot, that makes a lot of sense. However, since you say you use
> > Debian 3.1, probably Matt Zimmerman (Debian UML maintainer) should take a
> > look at this.
>
> Yes, I ran into this problem when testing the 2.4.24-3um packages for
> Debian. With previous UMLs, hwclock would simply produce an error, and the
> process would continue, but with 2.4.24-3um, it seems to hang.  Any idea
> why this might be?

Not at all - there is a big bug in 2.4.24-3 with modules (any iptables user 
get crashes), and "rtc" is probably a module; that bug is fixed in 2.4.26-2, 
which has another critical bug on console I/O fixed in 2.4.26-3, which is 
safe (apart all the experimental work on humfs and hostfs, which make them 
break in multiple ways). By the way, I've not heard this with any other 
distro (on my own I've only a Slack 9.0 root fs), so a look to hwclock could 
be useful, maybe.

Also, check for Real Time Clock UML option (enabling/disabling - does it makes 
difference?).

Here you can find a splitout version of all the changes from 2.4.24-1, so that 
you can try multiple combination of them. On the page there is the link to 
patch-scripts, which you'll love for patch-kit management (they are the tools 
used for the -mm tree). Give also a read to "series" and "rawSeries", inside 
the patch-scripts folder.

The patch at fault for modules is "optimization-unstable.patch", which is 
reverted in "revert-optim-broken.patch".

http://www.user-mode-linux.org/~blaisorblade/patches/UML-splitout-2.4.26-2.tar.bz2

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
