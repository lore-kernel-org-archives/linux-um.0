Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HX5m5-0000RF-2r for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Mar 2007 18:19:29 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HX5m1-0006zm-48
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Mar 2007 18:19:28 -0700
Date: Thu, 29 Mar 2007 14:29:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070329182920.GB8065@c2.user-mode-linux.org>
References: <20070328020247.GA12299@c2.user-mode-linux.org>
	<200703290236.44324.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200703290236.44324.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML - fix I/O hang when multiple devices
	are in use
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Mar 29, 2007 at 02:36:43AM +0200, Blaisorblade wrote:
> > Sometimes you need to. I'd probably just remove the do_ubd check and
> > always recall the request function when handling completions, it's
> > easier and safe.

If I'm understanding this correctly, this is what happens now.  There
is still the flag check and return if the queue is being run, but I
don't see the advantage of removing that.

> Anyway, the main speedups to do on the UBD driver are:
> * implement write barriers (so much less fsync) - this is performance killer 
> n.1

You mean preventing the upper layers from calling fsync?

> * possibly to use the new 2.6 request layout with scatter/gather I/O, and 
> vectorized I/O on the host

Yeah, this is something I've thought about on occassion but never
done.

> * while at vectorizing I/O using async I/O

I have that, but haven't merged it since I see no performance benefit
for some reason.

> * to avoid passing requests on pipes (n.2) - on fast disk I/O becomes 
> cpu-bound.

Right - I cooked up a scheme a while ago that had the requests on a
list, being removed from one end and added to the other, with some
minimal number of bytes going across the pipe to ensure a wakeup if
the other side was possibly asleep.  But I never implemented it.

> * using futexes instead of pipes for synchronization (required for previous 
> one).

Yup - for this, we either need to test the host for futuxes and use
pipes as a fallback or give up on 2.4 as the host.

> I forgot one thing: remember ubd=mmap? Something like that could have been
> done using MAP_PRIVATE, so that write had still to be called explicitly but
> unchanged data was shared with the host.

> Once a page gets dirty but is then cleaned, sharing it back is
> difficult - but even without that good savings could be
> achievable. That's to explore for the very future though.

Interesting idea.  That does avoid the formerly fatal mmap problem.
If you unmap it, the private copy goes away because it lost its last
reference, and if you map it again, you get the shared version.

That's a lot of mapping and unmapping though.  I wonder if just
calling mmap would cause the COWed page to be dropped...

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
