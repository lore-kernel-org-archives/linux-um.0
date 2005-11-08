Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZHPZ-0005IN-PR for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 16:32:29 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZHPZ-0006xO-A8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 16:32:29 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
References: <1130917338.14475.133.camel@localhost>
	<200511051744.33790.rob@landley.net>
	<200511061818.30449.blaisorblade@yahoo.it>
In-Reply-To: <200511061818.30449.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511071832.04974.rob@landley.net>
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
Date: Mon, 7 Nov 2005 18:32:04 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Sunday 06 November 2005 11:18, Blaisorblade wrote:
> > In theory, the state of truly free memory is irrelevant.  The fact
> > madvise zeroes it out is nice, but not actually required.  (And I'm not
> > sure madvise would actually zero if /tmp isn't tmpfs, so relying on the
> > zeroing behavior might not be quite advisable just yet anyway.)
>
> The API for that is not yet implemented, but the idea is "we're going to
> punch a hole in the file", so the zero'ing (which is, actually, implicit,
> especially in this case) is the only correct way.

I saw the punch API patch float by on the kernel list.  (I was under the 
impression that madvise on something ramfs based was a special case, it 
_would_ zero out the section of data in the file.  But the punch API is more 
generic, and frees up disk space too.)

> In fact, the zero-ing is done by remapping read-only to empty_zero_page on
> the next read fault; only when there is a write fault we need to allocate a
> new zeroed page.

That's what I'd expect, and exactly what we want: more memory available for 
use by the host system until UML needs it back, but when UML _does_ need it 
back no immediate threat of the (UML-side) OOM killer triggering before we 
can reactivate it.

> > updatedb is mostly reads, but due to our over-eager page cache, reads can
> > bloat the page cache to push running programs out of memory.  There was
> > some work back in the early 2.4 timeframe to add new page cache pages to
> > the 'expired' list or some such, except that under load this fought with
> > readahead...  (I lost track of things after Rik's vm got yanked in favor
> > of Arcandrea Angeli's because I never _did_ get a clear explanation of
> > what the heck a classzone was...)
>
> I've no idea of the "expired" list but I guess current Rik's work on

This was three or four years ago.  It's all changed...

> > I've hit every single bad case out there, under
> > 2.4.4 I once got my desktop so badly into swap city that I went to lunch,
> > came back, and it was STILL SWAPPING.  Trying to switch to a different
> > konqueror window! (Power cycle time.)
> >
> :: LOL ::
>
> To get that I simply needed to run "make -j" on a kernel tree (not "-jN",
> "-j", i.e. without limit).

Yeah, that'd do it too.

> > The UML instance is legitimately swapping, it's running something with a
> > ~200 meg working set in 64 megs of ram and 256 megs of swap.  (This is
> > why I'm interested in any "give pages back to the host system" approach
> > that would let me just _give_ UML 256 megs of ram without starving my
> > desktop because UML has filled itself up with redundant page cache.)
>
> ubd token limiter doesn't interact with VM, it's just a "be nice on the
> host, and auto-limit yourself."
>
> It slows down request submitting, and it's used by Christoph for hosting
> multiple UMLs, but will help you too I guess.

In theory the host should get this right, though.  What I really want is 
ionice, and I'm under the impression that one of the schedulers made this 
possible a few months back.  Dunno if it got merged, or what userspace 
changes I'd need...

> > The dd to create the file on the parent filesystem
> > created a sparse file, which UML was happy to loopback mount because
> > hostfs hid the sparseness of it.
>
> 1) I think that loop-back mount is supposed to work on sparse files too
> (the only thing which is refused is "swapon <sparse file>").
> 2) How does hostfs hides that? That's interesting (as a bug, I mean).

I mean I made a sparse file on ext2 and then ran a UML instance that hostfs 
mounted that ext2.  If hostfs cares that the underlying filesystem is sparse 
or compressed or whatnot, it's caring way too much about implementation 
details of the underlying filesystem. :)

I suppose if I used the funky block allocation range ioctl thing that LILO 
uses to figure out where kernel images live on disk, maybe it would pass it 
through.  I haven't tried.  (I vaguely recall that at one point loopback 
mounting sparse files didn't work, but loopback mounting used to be brittle 
five years or so back.  It seems to have been cleaned up a bit since then...)

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
