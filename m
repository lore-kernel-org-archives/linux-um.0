Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOSPI-0002oR-7H for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 20:35:44 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FOSPG-0000Rf-Sp
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 20:35:44 -0800
Received: from ccure.user-mode-linux.org (littleton.addtoit.com
	[198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id k2T4ZdB4005311
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Mar 2006 23:35:39 -0500
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.13.6/8.13.4) with ESMTP id
	k2T4awQI025534 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Mar 2006 23:36:58 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060329043656.GA25520@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Re: SMP skas requirements
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
Date: Tue, 28 Mar 2006 23:36:56 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, Mar 29, 2006 at 12:40:00AM +0200, Blaisorblade wrote:
> Since you've now split out delete-hostfs, why don't you merge the new hostfs,
> possibly labeling it as "EXPERIMENTAL"?

My two main gripes right now are
	there are three filesystems (or one framework and two
filesystems) in one directory
	it depends on filehandle, which has aspects that neither of us likes

> Btw, there's a ton of other patches which I don't see reasons for not 
> merging like Al Viro's cleanups (I've given a look to them and they
> seem safe). 

Just sent in today.

> And is punctuaction_fixes likely to cause instability?

No, but I recall that you didn't really like it.

> Finally, I'd like to get devshm merged if there aren't problems with the 
> code.

That one needs to check if /dev/shm is present, and fall back to /tmp
if not.

> Don't know how do you implemented it this time, but since we had special 
> read/write functions for filehandles, the get_fh() and put_fh() could be 
> simply put in their body. Has this changed?

No, but you didn't like those (and I agree) because of the extra
layering they added.

> > In this case, get_fh should just increment a count, put_fh should
> > decrement it, and the only list operation should be to move it to the
> > end of the list so it's last to be reclaimed.  The reclaimer would not
> > reclaim filehandles with non-zero counts.  I see no point in removing
> > it from the list and adding it back, as that seems not to protect
> > against anything.
> 
> You need a spinlock on the list. With the non-reference-counted approach, 
> removing that from the list allowed dropping the spinlock over the I/O call 
> on the host. That's not needed with the refcount.
> 
> With the refcount, likely you don't need to move it off-list, but that could 
> maybe be useful to avoid looping on unused fd; however, this requires taking 
> the spinlock when reinserting the element on the list.

I think you're agreeing with me, but I'm missing why we want to move
things on and off the list.

> Instead, with the refcount, if you decrease to 0 the refcount of FH_1 while a
> reclaim loop is iterating over FH_1, you only risk that FH_1 is missed on 
> that reclaim pass, which isn't a race.

Yup.

> Note: testing that a fd has refcount 0 must be done atomically with freeing 
> it; i.e. even with an atomic_t refcount, it must be incremented only while 
> you have a lock on the list; and while freeing it, you must use 
> atomic_dec_and_lock() so you get a lock on the list if the refcount goes to 0
> (atomic_dec_and_lock() is equivalent to taking the lock, doing dec and test, 
> and releasing it, but is faster).
> 
> get_fh() {
> 	spin_lock(&list_lock);
> 	<iterate on list>
> 	atomic_inc(fd->count); //while still holding the lock!!
> 	if (atomic_read(fd->count) <= 0)
> 		BUG();
> 	spin_unlock(&list_lock);
> }
> 
> put_fh(pointer to fd on list "fd") {
> 	if(atomic_dec_and_lock(fd->count, &list_lock)) {
> 		//Here we have the lock!
> 		//Remove the thing from list and free it
> 	}
> }

Yes, this looks reasonable.

> > You're envisioning the os_* interfaces calling back into filehandle.c
> > to get a descriptor if needed?
> 
> To cause fd reclaim, that's what I mean (not sure if you meant the
> same).

Yes.

> I suggested last time to rename this as "make_reclaimable" (or 
> set_reclaimable), is_reclaimable() sounds as an interrogation
> method.

Fine by me.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
