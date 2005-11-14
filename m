Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbkVh-00032W-3g for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 12:01:01 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user63199)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EbkVd-0002BJ-Gs
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 12:01:01 -0800
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<20051108154618.GB4131@ccure.user-mode-linux.org>
	<87lkzrwcs3.fsf@amaterasu.srvr.nix>
	<200511142037.56022.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511142037.56022.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's
	message of "Mon, 14 Nov 2005 20:37:55 +0100")
Message-ID: <87veyvuhi0.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Mon, 14 Nov 2005 20:00:39 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>, Can Sar <csar@stanford.edu>

On Mon, 14 Nov 2005, blaisorblade@yahoo.it moaned:
> On Monday 14 November 2005 14:59, Nix wrote:
>> I've long wanted to do the same sort of thing,
> 
> I guess you would like to run userspace processes or at least to call libUML 
> to configure something (but I don't think you can ask a kernel to do so much, 
> without allowing it to run userspace processes)...

Yeah: the idea is that you run all that's needed to configure things, but
then halt it and let routing et al continue. :)

>> to do with a UML the same 
>> sort of thing you can do with a real Linux box: that is, set up
>> networking and a bridging firewall, 
> 
>> then halt it: 
> 
> I.e. "shutdown now" without -h? Halt without poweroff?

i.e. `shutdown -h now' without poweroff-on-shutdown built into the
kernel. Shutdown and halt without poweroff (or tearing the network down,
obviously).

>> the kernel keeps 
>> processing network packets and firewalling and bridging them perfectly
>> well, but attackers now have *real* trouble changing the configuration.
> 
> _BLINK_ _BLINK_

That's what I thought when I first heard of it :)

> Is this a _documented_ feature 8-() ?

Not that I know of, but it's been true for a long, long time: before my
firewall ran UML it used to rely on it, and it's the only feature that
old firewall had that I'd still like to have back.

It's been true for longer than I've used Linux: Rogier Wolff describes
it in
<http://www.redhat.com/archives/linux-security/1997-April/msg00019.html>.
The top of that thread has someone calling it a problem, and Alan Cox
promptly follows up and calls it a feature. If Alan says that a feature
of networking of that vintage is intentional I guess it counts as sort
of documented. )

-- 
`Holy Google, pray for us sinners now and in the hour of our job interview.'


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
