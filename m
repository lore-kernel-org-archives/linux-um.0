Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZCT7-0008N5-Ec for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 11:15:49 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EZCT4-0003kX-NP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 11:15:49 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
References: <1130917338.14475.133.camel@localhost>
	<200511051230.00837.blaisorblade@yahoo.it>
	<200511051744.33790.rob@landley.net>
In-Reply-To: <200511051744.33790.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511061818.30449.blaisorblade@yahoo.it>
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
Date: Sun, 6 Nov 2005 18:18:30 +0100
To: Rob Landley <rob@landley.net>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Sunday 06 November 2005 00:44, Rob Landley wrote:
> On Saturday 05 November 2005 05:30, Blaisorblade wrote:
> > I've proposed in fact including (for now) another of Con's patch, which
> > gives some preference to free memory over pagecache (to speed up page
> > allocation)... but I don't quite understand why no Con's patches get
> > merged, at least in -mm (not that I follow that a lot)...
> >
> > Also, using pre-zeroing accelerators would mean that we need to keep some
> > zero-ed memory at hand...
>
> In theory, the state of truly free memory is irrelevant.  The fact madvise
> zeroes it out is nice, but not actually required.  (And I'm not sure
> madvise would actually zero if /tmp isn't tmpfs, so relying on the zeroing
> behavior might not be quite advisable just yet anyway.)
The API for that is not yet implemented, but the idea is "we're going to punch 
a hole in the file", so the zero'ing (which is, actually, implicit, 
especially in this case) is the only correct way.

In fact, the zero-ing is done by remapping read-only to empty_zero_page on the 
next read fault; only when there is a write fault we need to allocate a new 
zeroed page.

> updatedb is mostly reads, but due to our over-eager page cache, reads can
> bloat the page cache to push running programs out of memory.  There was
> some work back in the early 2.4 timeframe to add new page cache pages to
> the 'expired' list or some such, except that under load this fought with
> readahead...  (I lost track of things after Rik's vm got yanked in favor of
> Arcandrea Angeli's because I never _did_ get a clear explanation of what
> the heck a classzone was...)
I've no idea of the "expired" list but I guess current Rik's work on 

> The anticipatory scheduler does stupid things sometimes when both writes
> and reads are under pressure.  There have been a dozen different approaches
> to try to make this all work.  Token based swap thrashing control was the
> most recent, I believe.
Doesn't work well yet, so it's currently disabled... (see linux-mm wiki and/or 
comments in the code).
> I've hit every single bad case out there, under 
> 2.4.4 I once got my desktop so badly into swap city that I went to lunch,
> came back, and it was STILL SWAPPING.  Trying to switch to a different
> konqueror window! (Power cycle time.)
:: LOL ::
To get that I simply needed to run "make -j" on a kernel tree (not "-jN", 
"-j", i.e. without limit).
> I've been able to bring any linux desktop system to its knees (it's easy,
> open 40 konqueror tabs
You'll likely prefer Opera then - I have your same habit, but I'm actively 
trying to switch away.
> and a copy of kmail with 60,000 linux-kernel 
> messages in "threaded" mode, while using vi and kmail's composer. 
> Compiling stuff is an optional extra...)  I thought upgrading to 512 megs
> of ram might make it go away, but apparently not...

> > 3) Have you looked at C. Aker's ubd token limiter?

> The UML instance is legitimately swapping, it's running something with a
> ~200 meg working set in 64 megs of ram and 256 megs of swap.  (This is why
> I'm interested in any "give pages back to the host system" approach that
> would let me just _give_ UML 256 megs of ram without starving my desktop
> because UML has filled itself up with redundant page cache.)
ubd token limiter doesn't interact with VM, it's just a "be nice on the host, 
and auto-limit yourself."

It slows down request submitting, and it's used by Christoph for hosting 
multiple UMLs, but will help you too I guess.

> The dd to create the file on the parent filesystem
> created a sparse file, which UML was happy to loopback mount because hostfs
> hid the sparseness of it.

1) I think that loop-back mount is supposed to work on sparse files too (the 
only thing which is refused is "swapon <sparse file>").
2) How does hostfs hides that? That's interesting (as a bug, I mean).

> > which is
> > an atypical workload and not optimized against fragmentation... we could
> > well have a sequential read in UML become a crazy seek storm in the host.

> You could,
Sorry, "we could" means "it could happen that".
> but I'm not feeding it sparse files, exactly to avoid this 
> possibility.

> > About this, a paper at OLS (Virtualized GNU/Linux testing across
> > distros?) talks about "special I/O elevator setup" for UML, and the
> > authors talked to you for some issues, and IIRC maybe even work at
> > Intel...

> I've configured UML to use the NOP elevator, because all my I/O goes
> through the parent system which should have its own elevator.  I can try
> feeding UML an elevator if you think it'll help...
Dunno... my idea is that nop can make sense, but that paper seemed to hint at 
something smarter than this.
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
