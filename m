Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEXTK-0000Wt-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 09:17:34 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEXTH-00043j-Bs
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 28 Oct 2003 09:17:31 -0800
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9SH5Rj01107
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 12:05:27 -0500
Message-Id: <200310281723.h9SHNLLJ002565@ccure.karaya.com>
Subject: Re: [uml-devel] About COW & filesystems 
In-Reply-To: Your message of "Tue, 28 Oct 2003 01:34:10 PST."
             <BAY2-DAV62hA53ZpEVm00000924@hotmail.com> 
References: <BAY2-DAV62hA53ZpEVm00000924@hotmail.com> 
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
Date: Tue, 28 Oct 2003 12:23:21 -0500
To: James McMechan <James_McMechan@hotmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

James_McMechan@hotmail.com said:
> 1) Alignment -- the previous problems with alignment were due to
> reading a header that was not a exact multiple of sector size this is
> why it would not work on raw devices, it dumped out trying to read the
> header not the data, since it checks first if it is a cow header and
> quits on a read error it could not even be the backing file the
> alignment of the bitmap and data sectors was not a problem but fixing
> that would be nice to have, also I think that putting the real offsets
> rather then a alignment value would make more sense if it is aligned
> wrong it can't be easily changed.

The alignment was really needed for mmap.  The data needed to be page aligned
in order to be mmapped.  I aligned everything else more or less for the
hell of it.  It does have the advantage that there is now some extra room
after the header that can be used for new stuff without necessarily needing
a new version of the format.

> 2) mmaping option -- my problem has always been the reverse my UMLs
> ran out of address space even when just mmapping the COW bitmap, I can
> picture paging in sections of the data by mmap, but as proposed I
> would expect to run out of address space on my first ubd of ~2-4GiB
> since I have tried (using my previous patch set) a 64TiB array
> (sparse) I would expect to use all of memory for the mmap in short
> order. I am not sure that mmapping is faster than pread/pwrite which I
> was using earlier, I expect that both would be faster than the seek
> and then read+write that currently is in use.

First, the mmap option is used to map pages from the device directly into
UML physical memory.  So, address space isn't a problem here because it's
already allocated.

Second, 64 bit machines have lots of address space.

As for speed, using mmap trades a tlb flush for data copying.  Here, a kernel
build is about the same speed either way.  It would be a win for very 
write-dominated loads, though.  The real reason for doing it was to save
memory on the host.

pread/pwrite would be good.  I'm not too interested in reducing the system call
count, but it has other advantages.  It eliminates a bit of code.  It also
makes the seek and read/write atomic, which isn't an issue now, but it may
become one in the future.

> 3) cow format option - the ISAM files that have been proposed as
> alternatives to the sparse COW files that V2 uses for DOS format
> filesystems which don't do spare files well, I seem to remember ~3
> different formats for different puropses some of which would require
> different layous for the header ... ick, and I have thought it would
> be easier to just use new V4..6 for example as the COW version instead
> besides I don't seem to remember anyone showing code, I just made a
> few fragments as tests. 

It would be good to have at least one working alternative so we can see what
changes are needed.  Then we can split the header between stuff that all
formats will need and stuff that's format zero-specific.  That should make
it easier to add new formats.  Also, a non-sparse format will make it easier
to put COW files on physical devices, where you want to use the space 
efficiently.

> 5) fixed rounding bug - I am not sure which of the rounding bugs this
> refers to, I think it is the calculate cowbit map size 

It is.

> but there was
> also the one about passing 2 words of the bitmap between ubd_kern and
> ubd_user which would walk off the end of the mmap I was working on
> haveing the bitmap only read from the user side since I think it makes
> the ubd_kern driver much clearer 

Ummm, I don't remember that one.  The problem is that the first word would
be the last one in the bitmap, and the second word would be the one following
that?

> 6) update header to fixed lengths - another portability bit I may have
> suggested, I think that the time should be converted also. 

I switched some of the fields - others I wasn't sure about so I left them
alone.

> A) having C/H/S in the header - I would like to be able to have other
> partition layouts so that real disk images can be used. 

I don't like this in the COW header.  If you want CHS, you want it for all
devices, COWed or not.  So some way of specifying geometry is needed that
doesn't involve the COW header.

> B) treating the COW stuff as private_data to the ubd_kern.c so that it
> can stack, and with this we can push the COW option parsing over to
> _user side and then the _user side can also be used as libaray for
> uml_moo, one implementation is of course safer in that fixes don't
> need to match in two codebases. 

The COW stuff needs to be removed from the ubd driver totally, and turned into
a separate driver.  This is why I didn't merge your COW layering stuff.  The
real way to do that is
	cow0=cow0_file,/dev/cow1 cow1=cow1_file,backing_file

> D) create COW file by seek rather then writing lots of zeros 

This is done, and has been for a while.

> F) paged COW bitmap - I run out of memory when I do strange things
> like wanting a COW file on >512GiB files so I did a paged bitmap 

Yeah.  Don't know what to do about this.  One wacko idea I was pondering was
(in skas mode), making multiple kernel address spaces which are the same, except
they have different sections of the COW bitmap mapped.  So, rather than mapping
the bitmap in and out, you switch to the address space that has the section
you need.

> G) alignment - the header needs to be padded one of the reason was
> that my test versions had both length and offsets for the backing file
> name, COW bitmap, and data area if this is done they can be placed in
> any order and extra fields can be added to the header without breaking
> the exisiting code, the other option is to use something like the
> tagged headers of e.g. zip files, well one of those DOS tar
> replacements. 

This sounds over-engineered to me.  I'd rather leave things more constrained
as they are now, and make people have to justify new things that don't fit.

> I would offer converting to COW_open,close,read,write first with the
> private_data so ubd_kern gets cleaned up. then converting to dynamic
> disk allocation, stackable COW files get quite easy with private_data
> it can just recurse using the private_data to find the next layer, and
> since it does not require static information from ubd_kern it can
> stack, my notes indicate I was running 25 deep COW file stacks. 

I'd like the separate COW driver.  The ubd driver is messy enough as it is,
and I'd just like the COW stuff out of there.

> Or perhaps the conversion to external COW version files, cow_v1.[ch]
> etc.which makes plugging in new versions easier e.g. V3 & ISAM, I seem
> to recall testing with the fops proposal, and one where a index was
> used to select which read/write routines were used, fops was more the
> linux kernal style though. 

A working non-sparse COW file format would be useful.

> Paged mmap for the bitmap and data could occur in any order with the
> other work

That would be interesting.  I think that qualifies as research and 
experimentation at this point.

> The faster bitops are a tranparent replacement.

Yeah, although I don't think it makes much difference overall.

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
