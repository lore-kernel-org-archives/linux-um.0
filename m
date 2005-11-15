Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbzAJ-0007X4-SK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 03:39:55 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EbzAD-0004LL-8I
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 03:39:55 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Making UML Single Threader
In-Reply-To: <200511142037.56022.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0511151237080.12596@filer.marasystems.com>
References: <200511061723.32848.rob@landley.net>
	<20051108154618.GB4131@ccure.user-mode-linux.org>
	<87lkzrwcs3.fsf@amaterasu.srvr.nix>
	<200511142037.56022.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Tue, 15 Nov 2005 12:39:35 +0100 (CET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Mon, 14 Nov 2005, Blaisorblade wrote:

> I.e. "shutdown now" without -h? Halt without poweroff?

halt without poweroff.

stops the scheduler, but interrupts etc continues running.

but it's not something I'd recommend relying upon. Better to leave the 
scheduler running but only have an init process sleeping indefinitely.

> Is this a _documented_ feature 8-() ?

Not really, no.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
