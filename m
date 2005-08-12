Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ceS-00080U-Ne	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 09:45:00 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3ceR-0005W6-FT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 09:45:00 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050812163817.GA7448@ccure.user-mode-linux.org>
References: <200508102136.43763.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508102136.43763.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: madvise(DONTNEED) on tmpfs pages instead of /dev/anon
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
Date: Fri, 12 Aug 2005 12:38:17 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Rik van Riel <riel@redhat.com>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Aug 10, 2005 at 09:36:43PM +0200, Blaisorblade wrote:
> About this, I was thinking back to what Rik said in Ottawa at the OLS. He said 
> "just use madvise(DONTNEED) on it", but I remarked that the pages were 
> file-backed.

> Actually, however, since backing store for tmpfs is just pagecache/swapcache 
> memory,

They are still file-backed, just the underlying filesystem is often tmpfs.

> I have the doubt that madvise(DONTNEED) already does what we need, and if not 
> that it might be easily fixed (since zap_page_range->unmap_vmas -> 
> unmap_page_range accept a range of pages to be flushed - that was a recent 
> change from Hugh Dickins).

The man page is silent about whether the pages are synced to their
backing store, and in any case, tmpfs hsa no real backing store.

The desired behavior is that such pages are dropped as though they
were clean, even if they are dirty.  It goes against the grain of a
filesystem to drop dirty pages on the floor.

Looking at the code, the comment above madvise_dontneed is promising:

/*
 * Application no longer needs these pages.  If the pages are dirty,
 * it's OK to just throw them away.  The app will be more careful about
 * data it wants to keep.  Be sure to free swap resources too.  

which sounds like exactly what we need.

And in zap_pte_range, I don't see any checking of PageDirty, so it
looks like this works.

				Jeff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
