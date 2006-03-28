Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOKUJ-0002fz-Mg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 12:08:23 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FOKUJ-0006jd-7h
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 12:08:23 -0800
Received: from ccure.user-mode-linux.org (littleton.addtoit.com
	[198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id k2SK8L9B030014
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Mar 2006 15:08:22 -0500
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.13.6/8.13.4) with ESMTP id
	k2SK9fFX022055 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Mar 2006 15:09:42 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060328200938.GB22005@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Re: (implementation idea) Re: uml and nonstandard memory
	splits?
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
Date: Tue, 28 Mar 2006 15:09:38 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 27, 2006 at 11:33:37PM +0100, Blaisorblade wrote:
> Especially maybe_map must pin the pages (see implementation of 4G/4G 
> copy_*_user from Ingo Molnar).

Yup, looks like we can follow Ingo's implementation on this one.

> I'll work on this, I had come up with a nice design time ago, if you merge a 
> lockless filehandle I'll be glad to add locking to it. If you have a somehow 
> stable code base on it, let me know and I'll work on the patches.

I believe that the filehandle that's in my patchset is stable.  I've
beat on it with hostfs with no problems.  humfs is less healthy, but
it looks like the problems don't have anything to do with filehandle.

> My design was that you:
> a) take the list lock
> b) remove the fd from the list
> c) drop the list lock
> instead of simply bringing the fd upfront
> d) call read (or whatever) on the interested fd
> e) redo a)-c) but now to _add_ the fd on list, on the front

Which was pretty much the get_fh() and put_fh() I was considering.
It's just a pain to have to wrap that around every file access.

> This may also need a reference count if in step b) the fd may already be on 
> the list.

The scenario I think you have in mind is
	one process gets an fd for file I/O
	so does another one
	the first process finishes and sticks the thing back on the
list
	it is reclaimed, screwing the second process, which hasn't
made the system call yet

In this case, get_fh should just increment a count, put_fh should
decrement it, and the only list operation should be to move it to the
end of the list so it's last to be reclaimed.  The reclaimer would not
reclaim filehandles with non-zero counts.  I see no point in removing
it from the list and adding it back, as that seems not to protect
against anything.

> *) when _any_ fd API of the existing set (os_*) is called, it detects 
> -EMFILE/-ENFILE and closes fd's on the back of the list (i.e. we do LRU on 
> the list)

You're envisioning the os_* interfaces calling back into filehandle.c
to get a descriptor if needed?  That would make this whole thing less
"layery", which I can see.

> *) using new APIs is only needed to register an fd as "reclaimable" - this is
> optional since it can be used only for file-based fds (not for pipes, 
> probably not for sockets)

Which is how things work now, as is_reclaimable is called only when it
is known that a file has been opened.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
