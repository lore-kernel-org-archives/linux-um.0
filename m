Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcC1G-0000qA-21 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 17:23:26 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcC1E-0002Nb-JG
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 17:23:26 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<200511142037.56022.blaisorblade@yahoo.it>
	<Pine.LNX.4.61.0511151237080.12596@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0511151237080.12596@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511151923.05223.rob@landley.net>
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
Date: Tue, 15 Nov 2005 19:23:04 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

On Tuesday 15 November 2005 05:39, Henrik Nordstrom wrote:
> On Mon, 14 Nov 2005, Blaisorblade wrote:
> > I.e. "shutdown now" without -h? Halt without poweroff?
>
> halt without poweroff.
>
> stops the scheduler, but interrupts etc continues running.
>
> but it's not something I'd recommend relying upon. Better to leave the
> scheduler running but only have an init process sleeping indefinitely.
>
> > Is this a _documented_ feature 8-() ?
>
> Not really, no.

It's a "well known" feature.  Every once in a while, somebody twiddling APM, 
ACPI or the power management code makes halt unconditionally power down the 
system (or just the devices) so it stops routing packets, then somebody 
complains, and they fix it.  My google-fu isn't quite up to finding these 
just now, but here's a couple references to this behavior in 1997 and 1998:

http://www.ussg.iu.edu/hypermail/linux/kernel/9706.0/0121.html
http://groups.google.com/group/fa.linux.kernel/browse_thread/thread/9e0bb63143ecc8e0/28da0c720d092430%2328da0c720d092430

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
