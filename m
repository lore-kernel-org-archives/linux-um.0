Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5VFP-00017I-Rv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 13:10:23 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C5VFJ-00013M-KP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 13:10:20 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] UML hanging at "Activating swap"
References: <7153203.1094632577758.SLOX.WebMail.wwwrun@webmail.helinet.de>
	<200409092133.35518.blaisorblade_spam@yahoo.it>
	<20040909194623.GQ5330@alcor.net>
In-Reply-To: <20040909194623.GQ5330@alcor.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409092206.50305.blaisorblade_spam@yahoo.it>
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
Date: Thu, 9 Sep 2004 22:06:50 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Matt Zimmerman <mdz@debian.org>, user-mode-linux-user@lists.sourceforge.net, Dennis Ploeger <ploeger@helinet.de>, Michael West <quagly@mitzit.net>

On Thursday 09 September 2004 21:46, Matt Zimmerman wrote:
> On Thu, Sep 09, 2004 at 09:33:35PM +0200, BlaisorBlade wrote:
> > On Thursday 09 September 2004 20:49, Matt Zimmerman wrote:
> > > Yes, I ran into this problem when testing the 2.4.24-3um packages for
> > > Debian. With previous UMLs, hwclock would simply produce an error, and
> > > the process would continue, but with 2.4.24-3um, it seems to hang.  Any
> > > idea why this might be?
> >
> > Not at all - there is a big bug in 2.4.24-3 with modules (any iptables
> > user get crashes), and "rtc" is probably a module; that bug is fixed in
> > 2.4.26-2, which has another critical bug on console I/O fixed in
> > 2.4.26-3, which is safe (apart all the experimental work on humfs and
> > hostfs, which make them break in multiple ways). By the way, I've not
> > heard this with any other distro (on my own I've only a Slack 9.0 root
> > fs), so a look to hwclock could be useful, maybe.
>
> hwclock has caused problems for UML in the past; one of the strange things
> that it does is to try to open an fd for the console, because some
> architectures use that as a means to interface to the hardware clock.
>
> I ran hwclock under strace to find out where the hang was occurring, and
> discovered that it succeeds when running under strace. :-(  Here's the
> output anyway:

> In the course of this test, I also noticed that it is not just hwclock
> which hangs, but the entire UML.  Not even mconsole works after hwclock is
> run.

> UML in Debian has been in bad shape for some time, after the hostfs
> breakage, and then all the reports of hangs in tt mode
> (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=260111), and I would very
> much like to get a stable version in soon.
Well, I might do a proper patch choosing and release a 2.4.26 (or 2.4.27 - 
hope the patch shouldn't change) without any hostfs change and without known 
bugs (at least I hope).

> FWIW, you can find a Debian UML image (which should easily reproduce this
> problem) here:
>
> http://people.debian.org/~mdz/uml/Debian-3.0r2.ext2.bz2
No broadband, sorry. The only fs I downloaded is the root_fs_tomsbrt, i.e. 
1,4Mega wide IIRC.
> > Also, check for Real Time Clock UML option (enabling/disabling - does it
> > makes difference?).
>
> Currently, it is using CONFIG_UML_REAL_TIME_CLOCK=y.  This has not changed
> for some time:
>
> 1.40         (mdz      16-Dec-03): CONFIG_UML_REAL_TIME_CLOCK=y
If you get any difference by disabling it, let me know.

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
