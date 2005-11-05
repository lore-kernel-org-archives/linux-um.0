Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYG3E-0002hJ-Tr for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 20:53:12 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EYG3F-0006L1-1Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 20:53:13 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
Message-ID: <20051105054551.GC15683@ccure.user-mode-linux.org>
References: <1130917338.14475.133.camel@localhost>
	<200511041144.27762.rob@landley.net>
	<200511042010.33866.blaisorblade@yahoo.it>
	<200511041441.11896.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511041441.11896.rob@landley.net>
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
Date: Sat, 5 Nov 2005 00:45:51 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Fri, Nov 04, 2005 at 02:41:11PM -0600, Rob Landley wrote:
> On Friday 04 November 2005 13:10, Blaisorblade wrote:
> > > What I was thinking is that if we get prezeroing infrastructure that can
> > > use various prezeroing accelerators (as has been discussed but I don't
> > > believe merged), then a logical prezeroing accelerator for UML would be
> > > calling madvise on the host system.  This has the advantage of
> > > automatically giving back to the host system any memory that's not in
> > > use, but would require some way to tell kswapd or some such that keeping
> > > around lots of prezeroed memory is preferable to keeping around lots of
> > > page cache.
> >
> > Ah, ok, I see, but a tuneable to say this is almost useless for anything
> > else I guess, so it won't even get coded.
> 
> If we get prezeroing, the tunable is useful.  If we haven't got prezeroing, 
> this infrastructure probably won't get in.

I'm not really convinced that prezeroing would be that useful, particularly
through madvise.  The reason is that the normal case for a system is that
it has no free memory because it's caching anything that might be useful.
The one case I can think of where you all of a sudden have a lot of free
memory that might not be used for a while is when a large process exits, and
you get a lot of freed data, page tables, etc.  Then, we could possibly
madvise that and stick it on a zeroed pages list.  Forgetting about the extra
infrastructure needed to implement it, even that would be under
constant threat.  Witness the ocassional proposals to do pre-swapping
- swapping in stuff before it's needed when you have some free memory
for it.

Looking at it another way, what this would basically doing would be
moving page zeroing from userspace to kernel space, which is generally
counter to the direction that things generally go.

> It's not load for me, it's disk bandwidth.  Every time it writes to the swap 
> UBD, that data is scheduled for write-out.  So if it's thrashing the swap 
> file, even though it's reading the data back in fairly quickly the data still 
> gets written out to disk, again and again, each time it's touched.  Result: 
> the disk I/O becomes a bottleneck and the disk is _PEGGED_ as long as the 
> swap storm continues.

Do you understand exactly what's happening here?  Because I don't, and
I wish someone could explain it.  UML shouldn't be able to bog down
the host like that.  Its one-request-at-a-time pseudo-AIO shouldn't
make that much IO happen that suddenly.  There are other things that
do IO for a living (kernel builds, updatedb) and they don't seem to
bog down the system like this.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
