Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DshI6-0003q7-Oi	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 06:28:46 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.44)
	id 1DshI6-00034V-8D	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 06:28:46 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Problems about fork-not-clone (was: Re:
	[uml-user] UML exits after "tracing thread pid")
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<1121160835.4718.3.camel@FC3-bernhard-1.acousta.local>
	<200507121354.11313.rob@landley.net>
In-Reply-To: <200507121354.11313.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507131536.10511.blaisorblade@yahoo.it>
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
Date: Wed, 13 Jul 2005 15:36:10 +0200
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, schauer@acousta.at, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net

On Tuesday 12 July 2005 20:54, Rob Landley wrote:
> On Tuesday 12 July 2005 04:33, Bernhard Schauer wrote:
> > > Checking PROT_EXEC mmap in /tmp...OK
> > > tracing thread pid = 11687
> > >
> > > And then exits with no further explanation or printout.
Btw, adding stderr=1 gives back a bit more output, in these situations.
> > That sounds like the behaviour described in the first message. If you
> > apply the
> > "uml-revert-fork-instead-of-clone.patch" posted by Blaisorblade in the
> > same thread on 2nd July, everything should work as expected with TT mode
> > only.

> Cool.  Thanks.

> Query; Now that UML has been merged and mainline is mostly caught up, is
> there some kind of "current-stable" URL out there where I can get a patch
> fixing known issues against the current stable linux kernel?
-bs is intended to fill this need, and the community response seems quite 
satisfied.

Trees named -bb are more "experimental" (bb stands for Blaisorblade, bs is 
Blaisorblade stable).

In fact, the fix to this issue was in -bs1 and subsequent releases (and I'm 
trying now to merge it in the base -stable tree, i.e. I hope it'll be in 
2.6.12.3; however requirements for inclusion there are much stricter, and the 
procedure is longer).

> I'd have tested it a couple weeks back, but I was fighting with my new
> laptop. (An unknown number of kbuntu reinstalls, three power supplies, and
> a lid replacement that gave me a new screen later, it seems to all be
> working.  And thus, I'm trying to catch up...)

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
