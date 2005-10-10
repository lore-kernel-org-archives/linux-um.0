Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOzp7-0001TW-Mu	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Oct 2005 08:44:21 -0700
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOzpE-0005q3-KE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Oct 2005 08:44:30 -0700
From: Chris Lightfoot <chris@ex-parrot.com>
Subject: Re: [uml-devel] UBD performance
Message-ID: <7ViaLuoQzLjx.OrnC/pyAjhxT0BKSsdutDA@sphinx.mythic-beasts.com>
References: <z/jPSbKkgHHL.jbObjJNOGZsiVW/jm0lNOg@sphinx.mythic-beasts.com>
	<20051009184542.GC4901@ccure.user-mode-linux.org>
	<Nrn3QE48asne.DeHnFPPg9WBURzpIZbOgOA@sphinx.mythic-beasts.com>
	<20051010013515.GB10677@ccure.user-mode-linux.org>
	<0sFQ9zs1eorU.3hmKqEgWHCfEJIJucfz6wA@sphinx.mythic-beasts.com>
	<20051010143803.GB3448@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010143803.GB3448@ccure.user-mode-linux.org>
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
Date: Mon, 10 Oct 2005 16:44:12 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Oct 10, 2005 at 10:38:03AM -0400, Jeff Dike wrote:
> On Mon, Oct 10, 2005 at 10:10:24AM +0100, Chris Lightfoot wrote:
> > OK. The host is indeed using a 4K block filesystem; I
> > couldn't find your O_DIRECT patch, but turning on O_DIRECT
> > with fcntl just after opening the backing file gives these
> > results:
> >     http://ex-parrot.com/~chris/tmp/20051010/host-vs-uml-io-results-3.png
> > i.e., the AIO implementation is now slower than the stock
> > implementation for writes of size up to about 8KB, but
> > faster for larger writes; it's still quite a bit slower
> > than the host.
> 
> There aren't very good labels on that graph, but it looks consistent with my
> experience, which is 25-30% faster kernel builds with AIO/O_DIRECT.

Not sure what additional labels you want, but here are the
raw results (format as described previously):

http://caesious.beasts.org/~chris/tmp/20051010/uml-2.6.12.5
http://caesious.beasts.org/~chris/tmp/20051010/uml-2.6.12.5-128M
http://caesious.beasts.org/~chris/tmp/20051010/uml-2.6.12.5-newubd
http://caesious.beasts.org/~chris/tmp/20051010/uml-2.6.13.3-aio
http://caesious.beasts.org/~chris/tmp/20051010/uml-2.6.13.3-aio-direct
http://caesious.beasts.org/~chris/tmp/20051010/host-2.6.13.3-skas3-v9-pre7-skas3-v7
http://caesious.beasts.org/~chris/tmp/20051010/host-cfq-2.6.13.3-skas3-v9-pre7-skas3-v7

-- names should be self-explanatory.

> The next question is where the slowdown is happening.

Well, it's got to be either O_DIRECT, aio, or breaking the
requests up, I guess....

-- 
``My years of hip-hop sessions came in handy as I could converse well with
  Fast Fingers. I knew the lingo and when to use it, and as far as he was
  concerned, I was one of the brothers. Strangely, neither of us was one of
  the brothers, but I figure that's just a technicality.'' (`MixerMan')


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
