Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEt5t-0001fe-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 08:22:49 -0800
Received: from bay10-dav26.bay10.hotmail.com ([64.4.37.200] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AEt5t-0004mh-AM
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 29 Oct 2003 08:22:49 -0800
From: "James McMechan" <James_McMechan@hotmail.com>
References: <BAY2-DAV62hA53ZpEVm00000924@hotmail.com>  <200310281723.h9SHNLLJ002565@ccure.karaya.com>
Subject: Re: [uml-devel] About COW & filesystems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <BAY10-DAV26Yvm7kLig00008a71@hotmail.com>
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
Date: Wed, 29 Oct 2003 06:16:18 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> James_McMechan@hotmail.com said:
> > 1) Alignment -- the previous problems with alignment were due to
>
> The alignment was really needed for mmap.  The data needed to be page
aligned
> in order to be mmapped.  I aligned everything else more or less for
the
> hell of it.  It does have the advantage that there is now some extra
room
> after the header that can be used for new stuff without necessarily
needing
> a new version of the format.

Yes, but I will argue that having the offsets directly in the header
rather than the
__u32 alignment; would seem to make more sense, the offsets are what are
needed
to compute where in the file to read/mmap, the pad size can actually be
different,
and the prefered natural size for read/mmap can also be different and we
might
want to set both at runtime a pad of 512 for raw devices and 64K for
natural size
since the read/mmap would likely gain

>
> > 2) mmaping option -- my problem has always been the reverse my UMLs
>
> First, the mmap option is used to map pages from the device directly
into
> UML physical memory.  So, address space isn't a problem here because
it's
> already allocated.

I may be missunderstanding this works, it mmaps in from the device and
then
copies to/from the uml buffer, rather than reading/writing from the uml
buffer?

I think we can't mmap the pages from the device to the buffer address?

The read might have the wrong model since any writes to the just read
buffer would be via mmap be copied back to the device.
MAP_PRIVATE notes that it is unspecified if writes to the mmaped area
will appear in the mmaped area, and might end up with SEGV on NORESERVE

Write would have the same soft of problem in that the mmap should occur
before the data is copied into the buffer not when the ubd driver is
called

>
> Second, 64 bit machines have lots of address space.
>
Yes that will be nice but I expect that even 5 years from now 32bit
systems
will still be quite common, and I don't have a 64bit system yet :(

> As for speed, using mmap trades a tlb flush for data copying.  Here, a
kernel
> build is about the same speed either way.  It would be a win for very
> write-dominated loads, though.  The real reason for doing it was to
save
> memory on the host.

Save memory on host seems like a good reason., I don't see where write
gains though

> pread/pwrite would be good.  I'm not too interested in reducing the
system call
> count, but it has other advantages.  It eliminates a bit of code.  It
also
> makes the seek and read/write atomic, which isn't an issue now, but it
may
> become one in the future.

I also like the look since it does exactly what we want.

> > 3) cow format option - the ISAM files that have been proposed as
>
> It would be good to have at least one working alternative so we can
see what
> changes are needed.  Then we can split the header between stuff that
all
> formats will need and stuff that's format zero-specific.  That should
make
> it easier to add new formats.  Also, a non-sparse format will make it
easier
> to put COW files on physical devices, where you want to use the space
> efficiently.

I am willing put in one of the stupid ones, I think you could gain on
physical
devices only if you were running something like LVM which allows
resizing
or were using a device that was smaller than the backing device + map
which will fail a write it you keep using it, that of course is very
bad.

> > 5) fixed rounding bug - I am not sure which of the rounding bugs
this
> > refers to, I think it is the calculate cowbit map size
>
> It is.
>
> > but there was
> > also the one about passing 2 words of the bitmap between ubd_kern
and
> > ubd_user which would walk off the end of the mmap I was working on
> > haveing the bitmap only read from the user side since I think it
makes
> > the ubd_kern driver much clearer
>
> Ummm, I don't remember that one.  The problem is that the first word
would
> be the last one in the bitmap, and the second word would be the one
following
> that?

Yes that one, I would have to recheck what I thought was wrong,
and I could also be wrong myself :)

> > 6) update header to fixed lengths - another portability bit I may
have
> > suggested, I think that the time should be converted also.
>
> I switched some of the fields - others I wasn't sure about so I left
them
> alone.

Yes, I did regard it as progress but thought that time should be changed
too.

> > A) having C/H/S in the header - I would like to be able to have
other
> > partition layouts so that real disk images can be used.
>
> I don't like this in the COW header.  If you want CHS, you want it for
all
> devices, COWed or not.  So some way of specifying geometry is needed
that
> doesn't involve the COW header.

Actually it just seemed logical to put it in there and for those that
don't need
COW use a degenerate header e.g. no bitmap/no data area/backing file is
written to, or no bitmap/no backing file/data area is the disk image

> > B) treating the COW stuff as private_data to the ubd_kern.c so that
it
> > can stack, and with this we can push the COW option parsing over to
> > _user side and then the _user side can also be used as libaray for
> > uml_moo, one implementation is of course safer in that fixes don't
> > need to match in two codebases.
>
> The COW stuff needs to be removed from the ubd driver totally, and
turned into
> a separate driver.  This is why I didn't merge your COW layering
stuff.  The
> real way to do that is
> cow0=cow0_file,/dev/cow1 cow1=cow1_file,backing_file

I would think it would be easier to remove it, if it was not so tightly
bound
also are you sure you want to remove it, the layer above ubd should be
DM
based and would be the user inside of the UML setting up COW
What we have now is a system feature under ubd  that does not
require that the user inside set it up, and is instead setup by the user
outside of the UML at runtime.
<lead balloon>
If you want to get rid of the COW feature under the ubd.
We could just delete it and use the DM functional equivialent from
inside
the UML.
</lead balloon>

> > D) create COW file by seek rather then writing lots of zeros
>
> This is done, and has been for a while.

Sorry, I was checking my old info and was not sure it had made it in

> > F) paged COW bitmap - I run out of memory when I do strange things
> > like wanting a COW file on >512GiB files so I did a paged bitmap
>
> Yeah.  Don't know what to do about this.  One wacko idea I was
pondering was
> (in skas mode), making multiple kernel address spaces which are the
same, except
> they have different sections of the COW bitmap mapped.  So, rather
than mapping
> the bitmap in and out, you switch to the address space that has the
section
> you need.

Not so wacko, I had the same idea but what a pain and tt would still
need another
way.  I was not mmapping I emulated it with a dirty flag and
pread/pwrite since I
was not sure about mmaping into the UML address space without mangleing
your
address spaces, I think I could have MAP_FIXED but pread/pwrite was safe

> > G) alignment - the header needs to be padded one of the reason was
> > that my test versions had both length and offsets for the backing
file
> > name, COW bitmap, and data area if this is done they can be placed
in
> > any order and extra fields can be added to the header without
breaking
> > the exisiting code, the other option is to use something like the
> > tagged headers of e.g. zip files, well one of those DOS tar
> > replacements.
>
> This sounds over-engineered to me.  I'd rather leave things more
constrained
> as they are now, and make people have to justify new things that don't
fit.

Yes tagged headers seemed that way to me also.  The length offset pairs
I was using make the degenerate cases easier

> > I would offer converting to COW_open,close,read,write first with the
> > private_data so ubd_kern gets cleaned up. then converting to dynamic
> > disk allocation, stackable COW files get quite easy with
private_data
> > it can just recurse using the private_data to find the next layer,
and
> > since it does not require static information from ubd_kern it can
> > stack, my notes indicate I was running 25 deep COW file stacks.
>
> I'd like the separate COW driver.  The ubd driver is messy enough as
it is,
> and I'd just like the COW stuff out of there.

Well above ubd we can use DM from inside the UML but outside of the UML
I still want to be able to set up COW files at the system level.
Matt Zimmerman said that DM is in 2.4 which I had somehow missed and
that
the DM snapshot feature could be used in place of COW

> > Or perhaps the conversion to external COW version files, cow_v1.[ch]
> > etc.which makes plugging in new versions easier e.g. V3 & ISAM, I
seem
> > to recall testing with the fops proposal, and one where a index was
> > used to select which read/write routines were used, fops was more
the
> > linux kernal style though.
>
> A working non-sparse COW file format would be useful.

I am willing to do a stupid one.

> > Paged mmap for the bitmap and data could occur in any order with the
> > other work
>
> That would be interesting.  I think that qualifies as research and
> experimentation at this point.

It was interesting, the bookkeeping was a hassle but not too hard
Testing it was a bit of work though

> > The faster bitops are a tranparent replacement.
>
> Yeah, although I don't think it makes much difference overall.

Well not a huge amount, but I am an old programmer and still
like my utilites in the classic forms.
Especially stuff on the common/fast paths


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
