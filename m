Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7Rtr-0000ZM-6Q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 22:00:11 -0700
Received: from smtp1.att.ne.jp ([165.76.15.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C7Rtp-0004fQ-Ok for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 22:00:11 -0700
From: Richard Potter <sbuml-deletethispart@zar.att.ne.jp>
Subject: Re: [uml-devel] handle_trap - failed to wait at end of syscall
In-Reply-To: <200409142123.i8ELN34W004063@ccure.user-mode-linux.org>
References: <414717A4.7070605@nortelnetworks.com>
	<200409142123.i8ELN34W004063@ccure.user-mode-linux.org>
Message-Id: <20040915134902.88A5.SBUML-DELETETHISPART@zar.att.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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
Date: Wed, 15 Sep 2004 14:00:06 +0900
To: Jeff Dike <jdike@addtoit.com>
Cc: Joe Marzot <gmarzot@nortelnetworks.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, "Smith, Paul [BL60:NP52:EXCH]" <pausmith@americasm01.nt.com>

SBUML (sbuml.sf.net) had a big SIGHUP problem that produced intermittent
crashes, also about 10% of the time.  After definitively tracing the
problem to SIGHUP, it seemed like nohup in bash would solve it but I did
not have any luck with it. The solution that finally worked was using
setsid:

setsid linux umid=foo .....

--Richard

> gmarzot@nortelnetworks.com said:
> > In our case the UML is launched like this:
> > perl script
> >    my $pid = fork();
> >    if ($pid == 0) {
> >       setpgrp(); # give all UMLs the same group id so I can renice them
> >       exec($cmd); 
> 
> I think I understand what's happening.  You are (unwittingly) sending UML
> (and every process that belongs to it) a HUP when you, in effect, detach it
> from its parent terminal.
> 
> My first thought was that SIGHUP isn't disabled in the userspace process,
> and it should be, but it is, so I don't know why it's even being seen by
> the ptracer.  It should only see signals which are enabled in the child.
> 
> In the meantime, while we figure this out, you might try just adding "nohup"
> to the beginning of your $cmd.
> 
> 				Jeff
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
> Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
> Camcorder. More prizes in the weekly Lunch Hour Challenge.
> Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
