Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EY6yn-0002YD-VX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 11:12:01 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EY6yk-00043w-S5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 11:12:01 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
References: <1130917338.14475.133.camel@localhost>
	<200511041818.04397.blaisorblade@yahoo.it>
	<200511041144.27762.rob@landley.net>
In-Reply-To: <200511041144.27762.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511042010.33866.blaisorblade@yahoo.it>
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
Date: Fri, 4 Nov 2005 20:10:32 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

(Ok, now the thing is UML-only).

On Friday 04 November 2005 18:44, Rob Landley wrote:
> On Friday 04 November 2005 11:18, Blaisorblade wrote:
> > > Oh well, bench it when it happens.  (And in any case, it needs a
> > > tunable to beat the page cache into submission or there's no free
> > > memory to give back.
> >
> > I couldn't parse your sentence. The allocation will free memory like when
> > memory is needed.
>
> If you've got a daemon running in the virtual system to hand back memory to
> the host, then you don't need a tuneable.
I think Jeff's idea was a daemon running on the host (not as root) to manage 
splitting of memory between UMLs (and possibly the host).

> What I was thinking is that if we get prezeroing infrastructure that can
> use various prezeroing accelerators (as has been discussed but I don't
> believe merged), then a logical prezeroing accelerator for UML would be
> calling madvise on the host system.  This has the advantage of
> automatically giving back to the host system any memory that's not in use,
> but would require some way to tell kswapd or some such that keeping around
> lots of prezeroed memory is preferable to keeping around lots of page
> cache.
Ah, ok, I see, but a tuneable to say this is almost useless for anything else 
I guess, so it won't even get coded.

> In my case, I have a workload that can mostly work with 32-48 megs of ram,
> but it spikes up to 256 at one point.
Yes, I remember the complete build (with GCC needing lots of memory).

> Right now, I'm telling UML mem=64 
> megs and the feeding it a 256 swap file on ubd, but this is hideously
> inefficient when it actually tries to use this swap file.  (And since the
> host system is running a 2.6.10 kernel, there's a five minute period during
> each build where things on my desktop actually freeze for 15-30 seconds at
> a time.  And this is on a laptop with 512 megs of ram.

> I think it's 
> because the disk is so overwhelmed, and some things (like vim's .swp file,
> and something similar in kmail's composer) do a gratuitous fsync...
Yep, that's possible (running Gentoo, I often go to loads like 8-10, including 
a CPU-hog in the background, and things become a bit slow).

However, I feel that really it's the simple "fork" which slows down like a 
crawl (and given that memory allocation will easily sleep waiting for some 
memory to be freed - i.e. to be freed or synced to disk, that's reasonable).

And, btw, Frag. Avoidance would help for that too...
> > However look at /proc/sys/vm/swappiness

> Setting swappiness to 0 triggers the OOM killer on 2.6.14 for a load that
> completes with swappiness at 60.
Yep, I see - it becomes so reluctant to swapping that it prefers killing. 
Unintended, but at least a reasonable bug...

> I mentioned this on the list a little 
> while ago and some people asked for copies of my test script...

> > or use Con Kolivas's patches to find new tunable and policies.

> The daemon you mentioned is an alternative, but I'm not quite sure how
> rapid the daemon's reaction is going to be to potential OOM situations when
> something suddenly wants an extra 200 megs...

The daemon will have to be designed and written, so we'll see... and we 
_could_ add a pre-OOM hook (it would be meaningful for Xen and any other 
virtualization tool)... to trigger a mconsole notification on the host and 
wait for any response from the daemon...

At that point I become curious for "how much should the daemon give to the 
guest", and that would be policy configurable... but the policy file (which I 
already guess will be more complex than the daemon itself) would like some 
way to gather "how memory it needs" informations.

We already started discussing on IRC with Jeff some ideas for estimating the 
past usage, but predicting the future one is more difficult.

It's still possible to calculate the speed of new allocations, but not to now 
what's happening inside... the only possibility I see is to allow the 
notification to include the amount of needed memory (you can already do "echo 
something nice > /proc/notify", we now only need a client).

But this allows DoSing the host with untrusted users. Not fully though, since 
you can never hotplug memory which wasn't hot-unplugged first - i.e. you 
would boot your UML with mem=256m and then immediately hot-unplug the most of 
it.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
