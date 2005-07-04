Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DpU6G-0005T0-9Z	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jul 2005 09:47:16 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DpU6E-0004UO-HW	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jul 2005 09:47:16 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<1119614544.4643.9.camel@FC3-bernhard-1.acousta.local>
	<20050624134118.GA4117@ccure.user-mode-linux.org>
In-Reply-To: <20050624134118.GA4117@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507041853.13469.blaisorblade@yahoo.it>
Subject: [uml-devel] Problems about fork-not-clone (was: Re: [uml-user] UML
	exits after "tracing thread pid")
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
Date: Mon, 4 Jul 2005 18:53:12 +0200
To: user-mode-linux-user@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Friday 24 June 2005 15:41, Jeff Dike wrote:
> On Fri, Jun 24, 2005 at 02:02:24PM +0200, Bernhard Schauer wrote:
> > Checking for host processor xmm support...No
> > Checking that ptrace can change system call numbers...<0>Kernel panic -
> > not syncing: Segfault with no mm
>
> Revert the fork-not-clone patch:
> 	http://www.ussg.iu.edu/hypermail/linux/kernel/0506.1/0665.html
>
> The patch isn't wrong exactly - as far as I can see, the compiler is
> compiling it slightly differently so that it hits the tt mode vs new libc
> errno incompatibility.
Ok, can you describe it a bit more detailedly?

Also, are you going to drop this patch (or allow me to do this) for now? Since 
it isn't getting fixed, it seems me a good idea.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
