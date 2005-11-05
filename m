Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYMAV-00074A-06 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Nov 2005 03:25:07 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EYMAQ-00038f-5t
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Nov 2005 03:25:06 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
References: <1130917338.14475.133.camel@localhost>
	<200511041441.11896.rob@landley.net>
	<20051105054551.GC15683@ccure.user-mode-linux.org>
In-Reply-To: <20051105054551.GC15683@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511051230.00837.blaisorblade@yahoo.it>
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
Date: Sat, 5 Nov 2005 12:30:00 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net

On Saturday 05 November 2005 06:45, Jeff Dike wrote:
> On Fri, Nov 04, 2005 at 02:41:11PM -0600, Rob Landley wrote:
> > On Friday 04 November 2005 13:10, Blaisorblade wrote:
> > > > What I was thinking is that if we get prezeroing infrastructure that
> > > > can use various prezeroing accelerators (as has been discussed but I
> > > > don't believe merged), then a logical prezeroing accelerator for UML
> > > > would be calling madvise on the host system.  This has the advantage
> > > > of automatically giving back to the host system any memory that's not
> > > > in use, but would require some way to tell kswapd or some such that
> > > > keeping around lots of prezeroed memory is preferable to keeping
> > > > around lots of page cache.

> > > Ah, ok, I see, but a tuneable to say this is almost useless for
> > > anything else I guess, so it won't even get coded.

> > If we get prezeroing, the tunable is useful.  If we haven't got
> > prezeroing, this infrastructure probably won't get in.

> I'm not really convinced that prezeroing would be that useful, particularly
> through madvise.  The reason is that the normal case for a system is that
> it has no free memory because it's caching anything that might be useful.
> The one case I can think of where you all of a sudden have a lot of free
> memory that might not be used for a while is when a large process exits,
> and you get a lot of freed data, page tables, etc.  Then, we could possibly
> madvise that and stick it on a zeroed pages list.  Forgetting about the
> extra infrastructure needed to implement it, even that would be under
> constant threat.  Witness the ocassional proposals to do pre-swapping
> - swapping in stuff before it's needed when you have some free memory
> for it.

I've proposed in fact including (for now) another of Con's patch, which gives 
some preference to free memory over pagecache (to speed up page 
allocation)... but I don't quite understand why no Con's patches get merged, 
at least in -mm (not that I follow that a lot)...

Also, using pre-zeroing accelerators would mean that we need to keep some 
zero-ed memory at hand...

> Looking at it another way, what this would basically doing would be
> moving page zeroing from userspace to kernel space, which is generally
> counter to the direction that things generally go.
Nope - it's not reimplementing memset() as a syscall - which would move things 
from userspace to kernelspace.

Instead, pre-zeroing is moving the existing kernelspace memset() to hardware.

And relying on it doesn't seem bad...

> > It's not load for me, it's disk bandwidth.  Every time it writes to the
> > swap UBD, that data is scheduled for write-out.  So if it's thrashing the
> > swap file, even though it's reading the data back in fairly quickly the
> > data still gets written out to disk, again and again, each time it's
> > touched.  Result: the disk I/O becomes a bottleneck and the disk is
> > _PEGGED_ as long as the swap storm continues.

Sorry, you mention UML fsyncing to the swap file... this is misconfiguration! 
Disable CONFIG_*UBD*_SYNC and enable it per-device with ubd0s= rather than 
ubd0= (see --help output). The net effect is the same, except you don't get 
synchronous swapping! Can you try and report _any_ difference?

> Do you understand exactly what's happening here?  Because I don't, and
> I wish someone could explain it.  UML shouldn't be able to bog down
> the host like that.  Its one-request-at-a-time pseudo-AIO shouldn't
> make that much IO happen that suddenly.  There are other things that
> do IO for a living (kernel builds, updatedb) and they don't seem to
> bog down the system like this.

Some ideas on this:

1) In my experience, even with the CFQ scheduler, updatedb _does_ do many bad 
to the system... (but I run a Folding@Home CPU hog, so I may not be 
considered totally trustworthy). Without CFQ it's a total pain (even without 
CPU hogs)...

2) Also, fsync() is a bad idea here.... the host elevator can either 
prioritize only UML's writes wrt. all other writes (which could be seen as 
unfair and so wouldn't be implemented) or prioritize all writes, or do 
nothing to speed up fsync() - and I guess some elevator prioritizes writes on 
fsync(). Which bogs down the host

3) Have you looked at C. Aker's ubd token limiter?

4) Also, remember that you mustn't count I/O, but rather seeks (one seek can 
costs about 10 ms+ on a laptop, i.e. 100 Kb of sequential I/O)....

* remember that guest's ext3 (and recently reiserfs too) is proud of avoiding 
fragmentation by spreading files on the whole disk... (thus making ubd0 
_much_ sparse).

* and finally, remember that we usually run UML on sparse files, which is an 
atypical workload and not optimized against fragmentation... we could well 
have a sequential read in UML become a crazy seek storm in the host.

About this, a paper at OLS (Virtualized GNU/Linux testing across distros?) 
talks about "special I/O elevator setup" for UML, and the authors talked to 
you for some issues, and IIRC maybe even work at Intel... 

***) Jeff, what about talking to them and asking them to submit us their code, 
or at the very least their recipe?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
