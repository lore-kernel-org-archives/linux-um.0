Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEuss-0008D1-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 10:17:30 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEusq-0004Ff-Ur
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 29 Oct 2003 10:17:29 -0800
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9TI5Lj14528
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 13:05:21 -0500
Message-Id: <200310291823.h9TINV4d002520@ccure.karaya.com>
Subject: Re: [uml-devel] About COW & filesystems 
In-Reply-To: Your message of "Wed, 29 Oct 2003 06:16:18 PST."
             <BAY10-DAV26Yvm7kLig00008a71@hotmail.com> 
References: <BAY2-DAV62hA53ZpEVm00000924@hotmail.com> <200310281723.h9SHNLLJ002565@ccure.karaya.com>  <BAY10-DAV26Yvm7kLig00008a71@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 29 Oct 2003 13:23:31 -0500
To: James McMechan <James_McMechan@hotmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

James_McMechan@hotmail.com said:
> Yes, but I will argue that having the offsets directly in the header
> rather than the __u32 alignment; would seem to make more sense, the
> offsets are what are needed to compute where in the file to read/mmap

As far as calculating offsets, the information content is the same.  Putting
offsets in there strikes me as being a step in the direction of turning the
COW format into some general, self-describing thing, which I don't want.

The alignment field describes the requirement, which an offset field wouldn't,
so it seems better from a documentation point of view.

> I may be missunderstanding this works, it mmaps in from the device and
> then copies to/from the uml buffer, rather than reading/writing from
> the uml buffer?
>
> I think we can't mmap the pages from the device to the buffer address?

Yes, we can, and that's exactly what ubd=mmap does. 

> The read might have the wrong model since any writes to the just read
> buffer would be via mmap be copied back to the device. MAP_PRIVATE
> notes that it is unspecified if writes to the mmaped area will appear
> in the mmaped area, and might end up with SEGV on NORESERVE 

If the buffer wasn't mapped before, then it is written out to the file before
being mapped in again.  The mapping is done with MAP_SHARED.

> Write would have the same soft of problem in that the mmap should
> occur before the data is copied into the buffer not when the ubd
> driver is called 

Again, if the buffer was changed before the map happened, it is written out
first.

> Save memory on host seems like a good reason., I don't see where write
> gains though 

I'm not sure how well the block layer insulates the driver from a flood of
little writes, so that may have been a bogus reason.  But, if you can, within
a fixed amount of memory, cause the driver to do continuous writes, then
mapping is a win because the writes don't touch the host kernel any more.

> Actually it just seemed logical to put it in there and for those that
> don't need COW use a degenerate header e.g. no bitmap/no data area/
> backing file is written to, or no bitmap/no backing file/data area is
> the disk image 

My claim is that a need for geometry is totally independent of whether you're
using COW.  So, introducing a geometry needs to be somewhere else.  If we stick
it in the COW header, someone is going to say that they need geometry, and
they have a good reason that they can't use COW.  So, we need to come up with
something else, and then the geometry in the COW header is useless.

> It was interesting, the bookkeeping was a hassle but not too hard
> Testing it was a bit of work though 

This is basically the same problem that the VM system solves.  So, I would
look at presenting the COW bitmap to the VM system as virtual memory or a file,
and have it deal with swapping it in and out.  It may be impossible because
you can't make high level read-in-a-file-page calls from the driver because of
the locks that are already held, but I think it's worth looking at.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
