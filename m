Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Adam Heath <doogie@debian.org>
Subject: Re: [uml-devel] Re: [uml-user] UML hanging at "Activating swap"
In-Reply-To: <20040909194623.GQ5330@alcor.net>
Message-ID: <Pine.LNX.4.58.0409092144170.1481@gradall.private.brainfood.com>
References: <7153203.1094632577758.SLOX.WebMail.wwwrun@webmail.helinet.de>
	<200409092024.17925.blaisorblade_spam@yahoo.it>
	<20040909184951.GM5330@alcor.net>
	<200409092133.35518.blaisorblade_spam@yahoo.it>
	<20040909194623.GQ5330@alcor.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 9 Sep 2004 21:45:46 -0500 (CDT)
To: Matt Zimmerman <mdz@debian.org>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-user@lists.sourceforge.net, Dennis Ploeger <ploeger@helinet.de>, Michael West <quagly@mitzit.net>, user-mode-linux-devel@lists.sourceforge.net

On Thu, 9 Sep 2004, Matt Zimmerman wrote:

> hwclock has caused problems for UML in the past; one of the strange things
> that it does is to try to open an fd for the console, because some
> architectures use that as a means to interface to the hardware clock.

hwclock shouldn't be doing that.  It does it on all archs, even if the current
doesn't require it, just because some arch *may* require it.

But, obviously, whatever hwclock doesn't, shouldn't break uml.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
