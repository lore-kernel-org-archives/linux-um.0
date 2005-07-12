Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: Problems about fork-not-clone (was: Re:
	[uml-user] UML exits after "tracing thread pid")
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<200507120304.58283.rob@landley.net>
	<1121160835.4718.3.camel@FC3-bernhard-1.acousta.local>
In-Reply-To: <1121160835.4718.3.camel@FC3-bernhard-1.acousta.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507121354.11313.rob@landley.net>
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
Date: Tue, 12 Jul 2005 13:54:10 -0500
To: user-mode-linux-devel@lists.sourceforge.net, schauer@acousta.at
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net

On Tuesday 12 July 2005 04:33, Bernhard Schauer wrote:
> > Checking PROT_EXEC mmap in /tmp...OK
> > tracing thread pid = 11687
> >
> > And then exits with no further explanation or printout.
>
> That sounds like the behaviour described in the first message. If you
> apply the
> "uml-revert-fork-instead-of-clone.patch" posted by Blaisorblade in the
> same thread on 2nd July, everything should work as expected with TT mode
> only.

Cool.  Thanks.

Query; Now that UML has been merged and mainline is mostly caught up, is there 
some kind of "current-stable" URL out there where I can get a patch fixing 
known issues against the current stable linux kernel?

I'd have tested it a couple weeks back, but I was fighting with my new laptop.  
(An unknown number of kbuntu reinstalls, three power supplies, and a lid 
replacement that gave me a new screen later, it seems to all be working.  And 
thus, I'm trying to catch up...)

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
