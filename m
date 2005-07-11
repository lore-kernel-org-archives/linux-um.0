Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds5bS-0006ZH-EU	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:14:14 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1Ds5bM-0002mZ-Qs	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:14:14 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Problems about fork-not-clone (was: Re:
	[uml-user] UML exits after "tracing thread pid")
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<20050707115908.GA6043@ccure.user-mode-linux.org>
	<1121068129.4682.15.camel@FC3-bernhard-1.acousta.local>
In-Reply-To: <1121068129.4682.15.camel@FC3-bernhard-1.acousta.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507112321.20457.blaisorblade@yahoo.it>
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
Date: Mon, 11 Jul 2005 23:21:20 +0200
To: user-mode-linux-devel@lists.sourceforge.net, schauer@acousta.at
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net

On Monday 11 July 2005 09:48, Bernhard Schauer wrote:
> On Thu, 2005-07-07 at 07:59 -0400, Jeff Dike wrote:
> > So, I would say that skas0 is more a fix for this problem than
> > reverting the fork-not-clone patch is.

> No it isn't. Its an other method not a fix for anything.
I agree on this point, even because SKAS0 is not yet widely deployed / tested.
> As long as 
> skas0 is not in kernel mainline and enabled in main distributions, it
> has no relevance for corporate level (at least in my case).

> UML gives us the chance to build a compile and debug environment without
> a relevance on which distribution it runs. The image used to boot UML is
> a copy for each developer and each of them could compile applications
> having the same environment as on the target system.

There's a bit of misunderstanding: SKAS0 is a patch for UML only, not an host 
patch. It's numbered "0" because it has "0" dependencies, or because it does 
not depend on host SKAS patch (nor SKAS1, nor SKAS2, nor SKAS3).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
