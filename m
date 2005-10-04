Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMkFX-0006Xc-J2	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 03:42:19 -0700
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMkFV-00023d-VC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 03:42:19 -0700
From: Chris Lightfoot <chris@ex-parrot.com>
Subject: Re: [uml-devel] ubd and write barriers
Message-ID: <cnDjK7F+TozA.ccv0mQ01QIn2nWs/VlrGNA@sphinx.mythic-beasts.com>
References: <HDubM/jULNDp.FiIUPkbI/sUT/mvVu1/2/A@sphinx.mythic-beasts.com>
	<200510041231.56985.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510041231.56985.blaisorblade@yahoo.it>
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
Date: Tue, 4 Oct 2005 11:42:14 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Tue, Oct 04, 2005 at 12:31:56PM +0200, Blaisorblade wrote:
> On Tuesday 04 October 2005 11:31, Chris Lightfoot wrote:
> > The current ubd implementation doesn't support write
> > barriers (blk_queue_ordered etc.), and the reccomendation
> > is to use synchronous IO to ensure data integrity. In
> > principle, adding barrier request support ought to get
> > around this problem, allowing writes without O_SYNC with
> > occasional calls to fdatasync on the underlying data (the
> > motivation for write barrier support was safety of
> > journalling filesystems on disks with write caches, an
> > analogous problem).
> Yes, I more or less remembered that was the idea (from readings on lwn.net), 
> thanks for confirming it.

ok -- q.v. the discussion in here:
    http://lwn.net/images/pdf/LDD3/ch16.pdf

> > ext3 and reiserfs support the write barrier stuff if
> > mounted with appropriate options (barrier=1 and
> > barrier=flush respectively).
> So they don't auto-enable this when support exists? I.e. everybody is running 
> slower just because we don't add those params?

This bit I'm not sure about. I found one reference which
said that barrier=1 is enabled by default in ext3, but it
certainly isn't in the current kernel, and I suspect it's
because some real disks lie about cache flushes(?).
There's a compatibility chart here which tells you which
combinations are safe on real hardware:
    http://www.dt.e-technik.uni-dortmund.de/~ma/linux/kernel/safe-write-caches.html
There was also some discussion somewhere about having a
blacklist or whitelist of supported drives. Still, I don't
understand why barrier=0 is any safer: if the write
barriers aren't supported by the driver or hardware,
there's still no other way of ensuring changes are
committed to disk -- it's up to the user to test and
configure appropriately.

Anyway, none of that applies to the UML/ubd case, but if
barriers are implemented in ubd it's pretty easy to add
the barrier=1 mount option when starting each UML
instance.

> > between ubdXs and ubdX, but with adequate guarantees of
> > data integrity for use with modern filesystems. That said,
> > I haven't measured this yet.
> 
> > A patch for this is pretty simple (see below). Has there
> > been discussion of this before? I couldn't find any in the
> > list archives....
> This was discussed between me and Jeff recently, even if maybe that was 
> off-list.

-- 
``Nobody ever forgets where he buried the hatchet.'' (Hubbard)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
