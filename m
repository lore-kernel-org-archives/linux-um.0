Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EY8NQ-0006RR-Eo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 12:41:32 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EY8NP-0006zU-Pa
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 12:41:32 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
References: <1130917338.14475.133.camel@localhost>
	<200511041144.27762.rob@landley.net>
	<200511042010.33866.blaisorblade@yahoo.it>
In-Reply-To: <200511042010.33866.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041441.11896.rob@landley.net>
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
Date: Fri, 4 Nov 2005 14:41:11 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

On Friday 04 November 2005 13:10, Blaisorblade wrote:
> > If you've got a daemon running in the virtual system to hand back memory
> > to the host, then you don't need a tuneable.
>
> I think Jeff's idea was a daemon running on the host (not as root) to
> manage splitting of memory between UMLs (and possibly the host).

That's more configuration on the host that's not really needed.  Doesn't do my 
case any good.

> > What I was thinking is that if we get prezeroing infrastructure that can
> > use various prezeroing accelerators (as has been discussed but I don't
> > believe merged), then a logical prezeroing accelerator for UML would be
> > calling madvise on the host system.  This has the advantage of
> > automatically giving back to the host system any memory that's not in
> > use, but would require some way to tell kswapd or some such that keeping
> > around lots of prezeroed memory is preferable to keeping around lots of
> > page cache.
>
> Ah, ok, I see, but a tuneable to say this is almost useless for anything
> else I guess, so it won't even get coded.

If we get prezeroing, the tunable is useful.  If we haven't got prezeroing, 
this infrastructure probably won't get in.

> > I think it's
> > because the disk is so overwhelmed, and some things (like vim's .swp
> > file, and something similar in kmail's composer) do a gratuitous fsync...
>
> Yep, that's possible (running Gentoo, I often go to loads like 8-10,
> including a CPU-hog in the background, and things become a bit slow).

It's not load for me, it's disk bandwidth.  Every time it writes to the swap 
UBD, that data is scheduled for write-out.  So if it's thrashing the swap 
file, even though it's reading the data back in fairly quickly the data still 
gets written out to disk, again and again, each time it's touched.  Result: 
the disk I/O becomes a bottleneck and the disk is _PEGGED_ as long as the 
swap storm continues.

Not try to have anything else on the system that wants to access the disk.  
Yes, reads are prioritized but anything that does fsync and waits for a write 
(as vi and kmail's composer do, or anything _else_ that wants to swap out a 
page to free up some memory) winds up waiting somewhere around 15 seconds.  
(Yeah, 20 gigs/second on linear reads.  Not quite so much on an endless 
series of small random seeks.)

> However, I feel that really it's the simple "fork" which slows down like a
> crawl (and given that memory allocation will easily sleep waiting for some
> memory to be freed - i.e. to be freed or synced to disk, that's
> reasonable).

 You don't have to fork to block in this swap storm.  The fact my old ubuntu's 
on a 2.6.10 kernel might have something to do with it, though...

> And, btw, Frag. Avoidance would help for that too...

If it ever goes in...

> > > However look at /proc/sys/vm/swappiness
> >
> > Setting swappiness to 0 triggers the OOM killer on 2.6.14 for a load that
> > completes with swappiness at 60.
>
> Yep, I see - it becomes so reluctant to swapping that it prefers killing.
> Unintended, but at least a reasonable bug...

Triggering the OOM killer when you have _any_ writes pending is silly.  Wait 
and memory will free up.  And yet we do this all the time.  We trigger the 
OOM killer when there's still swap space, too.  I thought the point of a swap 
block device instead of a swap file was that there were no memory allocations 
needed to flush out memory.

The oom killer is theoretically for when waiting won't help.  But the 
implementation doesn't seem to match that...

> > I mentioned this on the list a little
> > while ago and some people asked for copies of my test script...
> >
> > > or use Con Kolivas's patches to find new tunable and policies.
> >
> > The daemon you mentioned is an alternative, but I'm not quite sure how
> > rapid the daemon's reaction is going to be to potential OOM situations
> > when something suddenly wants an extra 200 megs...
>
> The daemon will have to be designed and written, so we'll see... and we
> _could_ add a pre-OOM hook (it would be meaningful for Xen and any other
> virtualization tool)... to trigger a mconsole notification on the host and
> wait for any response from the daemon...
>
> At that point I become curious for "how much should the daemon give to the
> guest", and that would be policy configurable... but the policy file (which
> I already guess will be more complex than the daemon itself) would like
> some way to gather "how memory it needs" informations.
>
> We already started discussing on IRC with Jeff some ideas for estimating
> the past usage, but predicting the future one is more difficult.
>
> It's still possible to calculate the speed of new allocations, but not to
> now what's happening inside... the only possibility I see is to allow the
> notification to include the amount of needed memory (you can already do
> "echo something nice > /proc/notify", we now only need a client).
>
> But this allows DoSing the host with untrusted users. Not fully though,
> since you can never hotplug memory which wasn't hot-unplugged first - i.e.
> you would boot your UML with mem=256m and then immediately hot-unplug the
> most of it.

In theory, UML memory isn't all that much different from allocating normal 
user memory.  So a DOS shouldn't enter into it.

I like the idea that a UML instance can figure out when it has extra memory 
it's not using, and hand it back to the host.  And for a UML to maintain any 
significant quantity of page cache that isn't tmpfs or ramfs is probably a 
bad idea (with the possible exception of NFS mounts).  With hostfs or UBD, 
the host should have it cached to it's just two copies of memory, and 
fetching it again is easy.  (Dentries I can see cacheing lots of.)

Hence a UML instance could indeed (in theory) have lots of actually free 
memory (aggressively reclaim page cache) that it could madvise back to the 
host.  And if it can do that, why does it need the deamon?

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
