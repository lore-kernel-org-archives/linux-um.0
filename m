Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsNKA-0000Uj-8h	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 09:09:34 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.44)
	id 1DsNK6-0007Zj-Fx	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 09:09:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-user] Re: [uml-devel] Re: Problems about fork-not-clone
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<200507112321.20457.blaisorblade@yahoo.it> <42D3778A.20703@acousta.at>
In-Reply-To: <42D3778A.20703@acousta.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507121816.49410.blaisorblade@yahoo.it>
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
Date: Tue, 12 Jul 2005 18:16:49 +0200
To: user-mode-linux-user@lists.sourceforge.net
Cc: Bernhard Schauer <schauer@acousta.at>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Tuesday 12 July 2005 09:55, Bernhard Schauer wrote:
> Blaisorblade wrote:
> > There's a bit of misunderstanding: SKAS0 is a patch for UML only, not an
> > host patch. It's numbered "0" because it has "0" dependencies, or because
> > it does not depend on host SKAS patch (nor SKAS1, nor SKAS2, nor SKAS3).

> Sorry for that, I should have read about it - especially before writing.

> _IMO:_

> In any case it should be in the kernel mainline, or in other words:

> A mainline kernel should run without any patches required whether SKAS0
> nor reverted fork-not-clone.

> If this specific failure is caught by reverted fork-not-clone patch this
> is THE correction and should also be in mainline kernel.
> If SKAS0 is better than TT mode, TT mode could be replaced with 2.6.14.

Don't worry, I make the same kind of reasoning, so fork-not-clone will be 
reverted for now, until it's made to work on newer systems... and TT mode and 
SKAS0 mode are not incompatible, so SKAS0 will not be dropped so early (for 
now I consider 2.6.14 early, yes).

There were some problems about TT mode which appeared unsolvable on newer 
distros, and that was a reason to drop TT mode, but I just solved them, so 
there's no hurry in dropping it.
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
