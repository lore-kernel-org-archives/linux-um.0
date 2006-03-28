Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOMx3-00047L-O0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:46:13 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FOMx3-0006sR-0z
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:46:13 -0800
Content-Disposition: inline
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603290046.05889.blaisorblade@yahoo.it>
Subject: [uml-devel] Fwd: Re: SMP skas requirements
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
Date: Wed, 29 Mar 2006 00:46:05 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Forwarding this again...

Jeff, user-mode-linux-devel@projects.sourceforge.net address is wrong! It's 
@_lists_, not @_projects_.

----------  Forwarded Message  ----------

Subject: Re: SMP skas requirements
Date: Wednesday 29 March 2006 00:40
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@projects.sourceforge.net

On Tuesday 28 March 2006 21:38, Jeff Dike wrote:
> On Mon, Mar 27, 2006 at 11:33:37PM +0100, Blaisorblade wrote:
> > Especially maybe_map must pin the pages (see implementation of 4G/4G
> > copy_*_user from Ingo Molnar).
>
> Yup, looks like we can follow Ingo's implementation on this one.
>
> > I'll work on this, I had come up with a nice design time ago, if you
> > merge a lockless filehandle I'll be glad to add locking to it. If you
> > have a somehow stable code base on it, let me know and I'll work on the
> > patches.
>
> I believe that the filehandle that's in my patchset is stable.  I've
> beat on it with hostfs with no problems.  humfs is less healthy, but
> it looks like the problems don't have anything to do with filehandle.

Since you've now split out delete-hostfs, why don't you merge the new hostfs,
possibly labeling it as "EXPERIMENTAL"?

Btw, there's a ton of other patches which I don't see reasons for not
 merging, like Al Viro's cleanups (I've given a look to them and they seem
 safe). And is punctuaction_fixes likely to cause instability? IMHO it causes
 much more problems to leave it (and other patches) undefinitely hanging in
 the tree.

Finally, I'd like to get devshm merged if there aren't problems with the
 code.

> > My design was that you:
> > a) take the list lock
> > b) remove the fd from the list
> > c) drop the list lock
> > instead of simply bringing the fd upfront
> > d) call read (or whatever) on the interested fd
> > e) redo a)-c) but now to _add_ the fd on list, on the front
>
> Which was pretty much the get_fh() and put_fh() I was considering.
> It's just a pain to have to wrap that around every file access.

Don't know how do you implemented it this time, but since we had special
read/write functions for filehandles, the get_fh() and put_fh() could be
simply put in their body. Has this changed?

> > This may also need a reference count if in step b) the fd may already be
> > on the list.

I meant "off the list", but you understood me equally.

> The scenario I think you have in mind is
> 	one process gets an fd for file I/O
> 	so does another one
> 	the first process finishes and sticks the thing back on the
> list
> 	it is reclaimed, screwing the second process, which hasn't
> made the system call yet

Exactly.

> In this case, get_fh should just increment a count, put_fh should
> decrement it, and the only list operation should be to move it to the
> end of the list so it's last to be reclaimed.  The reclaimer would not
> reclaim filehandles with non-zero counts.  I see no point in removing
> it from the list and adding it back, as that seems not to protect
> against anything.

You need a spinlock on the list. With the non-reference-counted approach,
removing that from the list allowed dropping the spinlock over the I/O call
on the host. That's not needed with the refcount.

With the refcount, likely you don't need to move it off-list, but that could
maybe be useful to avoid looping on unused fd; however, this requires taking
the spinlock when reinserting the element on the list.

Instead, with the refcount, if you decrease to 0 the refcount of FH_1 while a
reclaim loop is iterating over FH_1, you only risk that FH_1 is missed on
that reclaim pass, which isn't a race.

Note: testing that a fd has refcount 0 must be done atomically with freeing
it; i.e. even with an atomic_t refcount, it must be incremented only while
you have a lock on the list; and while freeing it, you must use
atomic_dec_and_lock() so you get a lock on the list if the refcount goes to 0
(atomic_dec_and_lock() is equivalent to taking the lock, doing dec and test,
and releasing it, but is faster).

get_fh() {
	spin_lock(&list_lock);
	<iterate on list>
	atomic_inc(fd->count); //while still holding the lock!!
	if (atomic_read(fd->count) <= 0)
		BUG();
	spin_unlock(&list_lock);
}

put_fh(pointer to fd on list "fd") {
	if(atomic_dec_and_lock(fd->count, &list_lock)) {
		//Here we have the lock!
		//Remove the thing from list and free it
	}
}

> > *) when _any_ fd API of the existing set (os_*) is called, it detects
> > -EMFILE/-ENFILE and closes fd's on the back of the list (i.e. we do LRU
> > on the list)
>
> You're envisioning the os_* interfaces calling back into filehandle.c
> to get a descriptor if needed?

To cause fd reclaim, that's what I mean (not sure if you meant the same).

> That would make this whole thing less
> "layery", which I can see.

We discussed and agreed on this last time, in the end, and I'd like not to
argue again on this.

Transparence to callers is more important than layerization. The point of
having an os_{file I/O op. name} layer is to allow the callers not to change
when the implementation changes.

> > *) using new APIs is only needed to register an fd as "reclaimable" -
> > this is optional since it can be used only for file-based fds (not for
> > pipes, probably not for sockets)
>
> Which is how things work now, as is_reclaimable is called only when it
> is known that a file has been opened.

I suggested last time to rename this as "make_reclaimable" (or
set_reclaimable), is_reclaimable() sounds as an interrogation method.
--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
