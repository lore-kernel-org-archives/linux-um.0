Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Alhj3-0000OM-5z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:54:53 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Alhj1-0002Kx-SV
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:54:52 -0800
Message-Id: <200401280518.i0S5IOZw005580@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: more on COW (long) 
In-Reply-To: Your message of "Mon, 19 Jan 2004 15:53:43 PST."
	<20040119.155346.-522689.0.mcmechanjw@juno.com> 
References: <20040119.155346.-522689.0.mcmechanjw@juno.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 28 Jan 2004 00:18:24 -0500
To: James W McMechan <mcmechanjw@juno.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

mcmechanjw@juno.com said:
> above the ubd device is the request queue where the LVM system lives,
> it should be possible to have a LVM module that can understand the COW
> format, I think it would work best, from what I have seen, as part of
> the device mapper LVM, in 2.6 and there is a backport to 2.4
> apparently

Ah, that's something I hadn't considered.

> Well yes, I want to be able to read real disk images either from a raw
> device, yes we could stick in a special case ioctl to check for a real
> device and read its geometry but ick it is easier to specify it, or
> from a dd'ed image file of a hard disk which would not work even with
> the ioctl, so ubd1C102H15S16 is better from my view :)

OK, build it and maybe people will come :-)

> Um, no the header of the COW is tried first and it was not a multiple
> of 512 that is why the raw device broke it tried to read the V2 header
> and had a I/O error

Yeah, the driver needs to round up to 512 bytes when reading the header.

> Ok how about D -- direct (also uppercase) 

That's going to get confused with O_DIRECT, especially if the memnonic is
'direct'.  I was also thing 'd', but it meant 'data'.

> Why not, we already have a type field the cow_version why do we need
> another integer to express that it is a new format plus the data in
> the header changes

Because version changes reflect incompatible changes in the format.  You
bump the version number when old UMLs can't read the new format.  When you
add ISAM, old UMLs won't be able to read it, but they will still be able
to read the normal COW bitmaps.  So, this calls for the assignment of a
new cow_format, not a new version.

> the current variable for ISAM does not really map to anything similar
> in a COW file the index and the cow bitmap resemble each other but the
> length computation is very different sector count/8 vs sector count*8
> so there is not much code in common between a COW & ISAM how it is
> laid out on disk is different, how you find a sector is different,
> when you need to update the header is different etc.

This means we need to separate out the stuff that's specific to cow_format
0 from what's not.  This may require COW V4, but it doesn't call for a new
version just for ISAM.

> To not follow symlinks like we do now and allow that person who wanted
> symlinks pointing to where the backing files are kept to not show up
> as fixed paths in the COW file

OK, I think that sounds reasonable.

> It had not occurred to me that someone would want to generate a COW
> file on a mounted system at runtime, but now it seems clear that could
> be very useful.
>
> That is why really I like general solutions, they allow strange things
> you did not think of initially to be put in without too much trouble
> once it becomes clear why it would be useful. 

I agree, but I'd like to see at least a plausible use for something before
writing it up.

> AIO was a pain to auto detect, the compile time check will find it in
> some cases where glibc emulates it with threads

So libc provides emulation of the aio syscalls, not just aio emulation with
its own interface?  In that case, the syscalls can be tested with syscall().

> The new request queue has what I think are the JBD barriers sent in
> the queue and I was thinking that would be nice to sync when we got
> them, much less overhead than the ubd=sync option and it should work
> properly with little effort

Yeah, that would be a good thing.  It would also be a good thing to be able
to pass them into the host kernel, so it respects barriers as well.  That way
we'd get journalling consistency from the UML filesystem down to the host disk
without needing to turn on O_SYNC.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
