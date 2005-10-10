Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOtfw-0005IG-Ja	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Oct 2005 02:10:28 -0700
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOtg2-0008FR-HF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Oct 2005 02:10:37 -0700
From: Chris Lightfoot <chris@ex-parrot.com>
Subject: Re: [uml-devel] UBD performance
Message-ID: <0sFQ9zs1eorU.3hmKqEgWHCfEJIJucfz6wA@sphinx.mythic-beasts.com>
References: <z/jPSbKkgHHL.jbObjJNOGZsiVW/jm0lNOg@sphinx.mythic-beasts.com>
	<20051009184542.GC4901@ccure.user-mode-linux.org>
	<Nrn3QE48asne.DeHnFPPg9WBURzpIZbOgOA@sphinx.mythic-beasts.com>
	<20051010013515.GB10677@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010013515.GB10677@ccure.user-mode-linux.org>
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
Date: Mon, 10 Oct 2005 10:10:24 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 09, 2005 at 09:35:15PM -0400, Jeff Dike wrote:
> On Sun, Oct 09, 2005 at 11:51:28PM +0100, Chris Lightfoot wrote:
> > (TBH I'm surprised that the AIO code shows so little
> > improvement. The kernel does report that it's using 2.6
> > host AIO, so it is using the new version. Obviously
> > issuing the writes segment-by-segment is non-ideal but I'm
> > surprised it's this bad. Could I be missing some
> > configuration step?)
> 
> Make sure you've got the o_direct patch, and are using a 4K block filesystem.
> 
> If you're not doing O_DIRECT, then io_getevents waits - i.e. it's synchronous.

OK. The host is indeed using a 4K block filesystem; I
couldn't find your O_DIRECT patch, but turning on O_DIRECT
with fcntl just after opening the backing file gives these
results:
    http://ex-parrot.com/~chris/tmp/20051010/host-vs-uml-io-results-3.png
i.e., the AIO implementation is now slower than the stock
implementation for writes of size up to about 8KB, but
faster for larger writes; it's still quite a bit slower
than the host.

-- 
Never has one man's death brought
so much pleasure to so many people (newspaper obituary of Stalin)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
