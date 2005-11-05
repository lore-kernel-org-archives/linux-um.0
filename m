Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYXK1-0004uf-IY for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Nov 2005 15:19:41 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EYXJz-0004hy-Gz
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Nov 2005 15:19:41 -0800
From: Rob Landley <rob@landley.net>
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
Message-Id: <200511051257.36988.rob@landley.net>
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
Date: Sat, 5 Nov 2005 12:57:36 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Friday 04 November 2005 23:45, Jeff Dike wrote:
> > If we get prezeroing, the tunable is useful.  If we haven't got
> > prezeroing, this infrastructure probably won't get in.
>
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

For the specific case of User Mode Linux, the extra cacheing is largely a 
waste of time.  For UBD or hostfs, the host OS has the data cached so we're 
spending twice as much memory as necessary in hopes of avoiding a syscall and 
copy.

A proposal floated by on Linux-Kernel yesterday for a zone for hugepages, 
something the kernel could only put anonymous and pagecache in.  If we had 
the option to keep page cache out of it as well, then we could specify at 
boot time, "I'm giving this UML instance mem=256 but I only want the default 
32M of that to be used by anything but anonymous pages.  When those are free, 
it's fine for them to be free, I _want_ them to be free.  The host can put 
that to good use in service of Konqueror and Kmail.

This would be useful to me.  If the sucker reaps all the page cache and 
dentries and _still_ runs out of memory for a kernel allocation, then yes 
I've misconfigured it.  But it had better reap all the page cache and 
dentries first...

> Looking at it another way, what this would basically doing would be
> moving page zeroing from userspace to kernel space, which is generally
> counter to the direction that things generally go.

Page zeroing is currently done in userspace?

Juggling memory is something that userspace has traditionally deeply sucked 
at.  Having to page in a daemon to make decisions in a low memory situation 
is unlikely to improve matters.

> > It's not load for me, it's disk bandwidth.  Every time it writes to the
> > swap UBD, that data is scheduled for write-out.  So if it's thrashing the
> > swap file, even though it's reading the data back in fairly quickly the
> > data still gets written out to disk, again and again, each time it's
> > touched.  Result: the disk I/O becomes a bottleneck and the disk is
> > _PEGGED_ as long as the swap storm continues.
>
> Do you understand exactly what's happening here?  Because I don't, and
> I wish someone could explain it.  UML shouldn't be able to bog down
> the host like that.  Its one-request-at-a-time pseudo-AIO shouldn't
> make that much IO happen that suddenly.  There are other things that
> do IO for a living (kernel builds, updatedb) and they don't seem to
> bog down the system like this.

Just some educated guesses.

1) Ubuntu is defaulting to the anticipator I/O scheduler, and that melts down 
under sufficiently heavy loads.  I should switch it to CFQ.

2) Some applications (vim and kmail most noticeably) do an fsync(), and in 
situations with lots of disk activity an fsync can block for 30 seconds.  
(Why konqueror suffers from this is another question, but konqueror has 
always been vulnerable to low memory situations...)

Either way it's a host kernel problem.  UML is a more or less normal userspace 
app, and it shouldn't be able to bog the system like...

P.S.  You're mentioning loads the kernel guys have specifically optimized for.  
Kernel builds are what the kernel has been optimized for over the past 10 
years, but it's not a big I/O test.  The I/O it does is nicely localized by 
directory, sucking in entire files each time so readahead is never wasted, 
and it's generally CPU bound even on a fast machine.  As for updatedb, that's 
also not random seeks taking small chunks out of a file, and it's dominated 
by reads.  The anticipatory scheduler is effectively optimized for updatedb.  
Of course the first thing I do on any new system is kill cron...

swapping has always been tougher to optimize for, and it turns out that even 
swapping-style access patterns originating in userspace and happening inside 
a file are still a bit of a pain.

I'll see if CFQ improves matters.  If nothing else, the ability of "nice 20 
mybuild" to actually affect disk I/O would be a _serious_ bonus...

>     Jeff

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
