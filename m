Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYXiL-0005db-4U for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Nov 2005 15:44:49 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EYXiJ-0008Dc-Gk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Nov 2005 15:44:49 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
References: <1130917338.14475.133.camel@localhost>
	<20051105054551.GC15683@ccure.user-mode-linux.org>
	<200511051230.00837.blaisorblade@yahoo.it>
In-Reply-To: <200511051230.00837.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511051744.33790.rob@landley.net>
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
Date: Sat, 5 Nov 2005 17:44:33 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Saturday 05 November 2005 05:30, Blaisorblade wrote:
> I've proposed in fact including (for now) another of Con's patch, which
> gives some preference to free memory over pagecache (to speed up page
> allocation)... but I don't quite understand why no Con's patches get
> merged, at least in -mm (not that I follow that a lot)...
>
> Also, using pre-zeroing accelerators would mean that we need to keep some
> zero-ed memory at hand...

In theory, the state of truly free memory is irrelevant.  The fact madvise 
zeroes it out is nice, but not actually required.  (And I'm not sure madvise 
would actually zero if /tmp isn't tmpfs, so relying on the zeroing behavior 
might not be quite advisable just yet anyway.)

> > > It's not load for me, it's disk bandwidth.  Every time it writes to the
> > > swap UBD, that data is scheduled for write-out.  So if it's thrashing
> > > the swap file, even though it's reading the data back in fairly quickly
> > > the data still gets written out to disk, again and again, each time
> > > it's touched.  Result: the disk I/O becomes a bottleneck and the disk
> > > is _PEGGED_ as long as the swap storm continues.
>
> Sorry, you mention UML fsyncing to the swap file... this is
> misconfiguration! Disable CONFIG_*UBD*_SYNC and enable it per-device with
> ubd0s= rather than ubd0= (see --help output). The net effect is the same,
> except you don't get synchronous swapping! Can you try and report _any_
> difference?

I have it disabled in UML.  It's vi and kmail that seem to be doing fsync.  
(In vi's case, it has a .swp file that allows you to recover from crashes.  
In kmail's case, it has a similar saved state that allows you to resume 
composing your email after a crash.  The problem is, both _block_ waiting for 
the fsync to finish, which sucks mightily when you're trying to type when it 
blocks.)

All UML is doing is thrashing the heck out of the disk.

> Some ideas on this:
>
> 1) In my experience, even with the CFQ scheduler, updatedb _does_ do many
> bad to the system... (but I run a Folding@Home CPU hog, so I may not be
> considered totally trustworthy). Without CFQ it's a total pain (even
> without CPU hogs)...

updatedb is mostly reads, but due to our over-eager page cache, reads can 
bloat the page cache to push running programs out of memory.  There was some 
work back in the early 2.4 timeframe to add new page cache pages to the 
'expired' list or some such, except that under load this fought with 
readahead...  (I lost track of things after Rik's vm got yanked in favor of 
Arcandrea Angeli's because I never _did_ get a clear explanation of what the 
heck a classzone was...)

> 2) Also, fsync() is a bad idea here.... the host elevator can either
> prioritize only UML's writes wrt. all other writes (which could be seen as
> unfair and so wouldn't be implemented) or prioritize all writes, or do
> nothing to speed up fsync() - and I guess some elevator prioritizes writes
> on fsync(). Which bogs down the host

The anticipatory scheduler does stupid things sometimes when both writes and 
reads are under pressure.  There have been a dozen different approaches to 
try to make this all work.  Token based swap thrashing control was the most 
recent, I believe.  I've hit every single bad case out there, under 2.4.4 I 
once got my desktop so badly into swap city that I went to lunch, came back, 
and it was STILL SWAPPING.  Trying to switch to a different konqueror window!  
(Power cycle time.)

I've been able to bring any linux desktop system to its knees (it's easy, open 
40 konqueror tabs and a copy of kmail with 60,000 linux-kernel messages in 
"threaded" mode, while using vi and kmail's composer.  Compiling stuff is an 
optional extra...)  I thought upgrading to 512 megs of ram might make it go 
away, but apparently not...

> 3) Have you looked at C. Aker's ubd token limiter?

The UML instance is legitimately swapping, it's running something with a ~200 
meg working set in 64 megs of ram and 256 megs of swap.  (This is why I'm 
interested in any "give pages back to the host system" approach that would 
let me just _give_ UML 256 megs of ram without starving my desktop because 
UML has filled itself up with redundant page cache.) 

I did try telling UML "echo 0 > /proc/sys/vm/swappiness", but that just 
triggered UML's OOM killer, as I mentioned.  Why I consider to be a separate 
bug...

> 4) Also, remember that you mustn't count I/O, but rather seeks (one seek
> can costs about 10 ms+ on a laptop, i.e. 100 Kb of sequential I/O)....
>
> * remember that guest's ext3 (and recently reiserfs too) is proud of
> avoiding fragmentation by spreading files on the whole disk... (thus making
> ubd0 _much_ sparse).

The guest actually has an ext2 partition loopback mounted out of hostfs, but 
the situation that's under load isn't stressing that.  The stress is entirely 
on the swap file, and swapping is inherently pretty seeky.

> * and finally, remember that we usually run UML on sparse files,

I was doing that too.  The dd to create the file on the parent filesystem 
created a sparse file, which UML was happy to loopback mount because hostfs 
hid the sparseness of it.  I stopped doing that because it was yet another 
way to peg the disk with seek activity.  (Tryinging it again has been a todo 
item for a while...)

> which is 
> an atypical workload and not optimized against fragmentation... we could
> well have a sequential read in UML become a crazy seek storm in the host.

You could, but I'm not feeding it sparse files, exactly to avoid this 
possibility.

> About this, a paper at OLS (Virtualized GNU/Linux testing across distros?)
> talks about "special I/O elevator setup" for UML, and the authors talked to
> you for some issues, and IIRC maybe even work at Intel...

I've configured UML to use the NOP elevator, because all my I/O goes through 
the parent system which should have its own elevator.  I can try feeding UML 
an elevator if you think it'll help...

> ***) Jeff, what about talking to them and asking them to submit us their
> code, or at the very least their recipe?

You're welcome to my test case.  It's my Firmware Linux build online at 
http://www.landley.net/code/firmware (I should have an updated version using 
2.6.14 out in a few days, working on some unrelated stuff at the moment...)

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
