Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200409100504.i8A544g1006149@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [uml-user] UML hanging at "Activating swap" 
In-Reply-To: Your message of "Thu, 09 Sep 2004 12:46:23 PDT."
	<20040909194623.GQ5330@alcor.net> 
References: <7153203.1094632577758.SLOX.WebMail.wwwrun@webmail.helinet.de>
	<200409092024.17925.blaisorblade_spam@yahoo.it>
	<20040909184951.GM5330@alcor.net>
	<200409092133.35518.blaisorblade_spam@yahoo.it>
	<20040909194623.GQ5330@alcor.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 10 Sep 2004 01:04:04 -0400
To: Matt Zimmerman <mdz@debian.org>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-user@lists.sourceforge.net, Dennis Ploeger <ploeger@helinet.de>, Michael West <quagly@mitzit.net>, user-mode-linux-devel@lists.sourceforge.net

mdz@debian.org said:
> FWIW, you can find a Debian UML image (which should easily reproduce
> this problem) here:
>
> http://people.debian.org/~mdz/uml/Debian-3.0r2.ext2.bz2 

I just tried it with my current UML, and it works fine:

	Setting the System Clock using the Hardware Clock as reference...
	hwclock is unable to get I/O port access:  the iopl(3) call failed.
	System Clock set. System local time is now Fri Sep 10 03:58:17 UTC 2004.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
