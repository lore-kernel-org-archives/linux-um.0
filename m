Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-user] Re: [uml-devel] Dynamic remount with variable COW
	stacking/merging needed, support  for snapshot repilication
Message-ID: <20040119041049.GA21670@ccure.user-mode-linux.org>
References: <20040118.002101.-9063.0.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118.002101.-9063.0.mcmechanjw@juno.com>
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
Date: Sun, 18 Jan 2004 23:10:49 -0500
To: James W McMechan <mcmechanjw@juno.com>
Cc: sdw@lig.net, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Sun, Jan 18, 2004 at 12:20:58AM -0800, James W McMechan wrote:
> The stackable COW was not merged,
> I have a new more abstracted version I
> am working on, but Jeff seemed to want
> to replace the LVM driver layer above
> the ubd device to implement the COW
> features rather then having COW as a
> system feature below the ubd layer where
> I need it, for it to work like a hardware
> function. 

What does COW have to do with the LVM driver?  They're completely independent
of each other.

The COW stuff is inside the ubd driver, rather than below it.  I want it
to be above the ubd driver, so that it is complely outside, and a ubd device
deals with only one file.

This will clean up the code, allow stackable COW files as a trivial 
side-effect, and allow COW volumes to be mounted on the host.  What won't
you be able to do if this happens?

> and COW being
> setup by the host admin completely
> outside of the UML invisible (mostly)
> to the admin of the UML (guest root)
> Which provides two separate but
> useful capabilities to the host admin
> and the guest admin

This is another thing a separate COW driver will make possible.  A COW volume
could mounted on the host and be passed to UML as a device.

> The Dynamic remount could be done
> in much less than one second, if you
> prepare as a separate step, then
> it is just replacing the file handle in the
> device structure with a new handle
> all writes before will occur to the
> original COW and afterwards all
> writes will occur to the new COW

Just to be clear, you're suggesting copying a COW file on the host, then
switching the ubd driver to use the copy?  I don't see how that helps, because
the COW file needs to be quiescent during the copy.

> I have been thinking of some more
> ubd flags ubd=C10H128S63 to
> change disk layout 

This is better than stuffing geometry in the COW header.  Are there any actual
uses that you know of for specifying the geometry of a ubd device?

> or ubd1C10
> for the ubd device 1 cylinder 10
> case as a individual example.
> C for cylinder
> H for heads
> S for sectors

Again, interesting, but are there any uses for this?

> P for padding i.e. 512 byte header
> padding so that raw devices can be
> checked without failing due to I/O
> errors dropping out.

I think this happens automatically since I/O happens with 512 granularity
anyway.

> M for mmap size index,data

Do you mean the mmap unit?

> V to select what version header to create
> V0 is a raw data file don't check for COW
> V1 the first version header not portable
> V2 the second one with the wrong math
> V3 my version with the separated offset length
> separated allows for using a program to fix the
> math errors on detection without having to
> redo the header format

I don't want to support old COW versions.  I don't see any point in allowing
UML to create V1 or V2 COW files.

V0 is needed, but that's the wrong name.  Some other switch is needed to
tell the driver to treat the file as data even if it looks like a COW file.

> V4 my version of ISAM

This is a new cow_format, not a new version of the COW file (and I realize
that sounds confusing :-).  IOW, you set the cow_format field in the header
to 1, after getting me to assign 1 as the ISAM cow_format.

> L for symlinks as names

What this?  I don't remember seeing this before.

> U for update in place
> which only really applies to the moo
> program, but I was thinking should
> have all the options defined.

Well, if the ubd (or COW) driver isn't going to do update in place (and I don't
see why that makes sense), then it should just be specific to uml_moo.

> ?? sector size should have a option
> ?? for page size i.e. use 64k even on i386
> so COW can be read on say a alpha

Yeah.

> A to set AIO mode

I think this should be auto-detected and used.  Maybe there should be a no-AIO
for debugging.  In any case, AIO is a lot less useful with ubd-mmap, unless
there is an AIO way to wait to a page to be faulted in.

> R for readonly so all options are uppercase
> S for sync data at each read/write
> ?? for sync on barriers for 2.6

Are you thinking barriers for journalling filesystems?  That would be useful,
but I've done no thinking about that.

> The types of mmaping I think might be needed
> no mmap in use -- for when mmap does not
> work some fs do not mmap well
> index mmap -- like now only the index/bitmap
> is mmaped uses a fair amount of address space
> full mmap -- map in both the index/bitmap and
> the data, uses a huge amount of address space
> paged index -- map in a (few) pages of the
> index at a time, I have run with one page nicely
> paged data -- map in a (few) pages of the data
> at a time, I am not sure that this is helpful?

The paged index would be useful (and that's probably the only way mapping the
index could be useful on x86).  It's not obvious to me that you can keep the
right parts mapped.  Also, the fact that only little pieces of the index
are mapped at any time make it a lot harder to make mapping pay.  With only
two words being changed at a time, the writes are pretty damn cheap.

> The problem I see with mmaping is that in order
> to mmap properly I need to kmalloc a buffer
> of the right size first, and then mmap on top of
> the buffer, so that the kernel does not try to
> use the space that is mmaped for other purposes
> outside of the ubd_user/cow_user functions
> which it would be free to do if it is not kmalloc'ed
> and then if it tries to read/write that address space
> the _user function would be using the mmaped
> area not the kernel memory, or when the kernel
> overwrites the index/bitmap with kernel data
> Ick the mind boggles

You'd use __get_free_pages for this, not kmalloc.  But that's exactly what
happens, and it works cleanly.  You allocate the pages, overmap them from
the device, and then unmap and replace the original pages on free.

> The types of headers I think should be present
> COW -- what we have now
> ISAM -- which will work without sparse files
> DISK -- just to keep disk image info CHS etc
> HEADER -- like disk but treats the data in
> the disk as a separate file sort of like the 
> backing file in a COW setup
> several different HEADERs could be setup
> for one image file, each with a different layout
> for the C/H/S as a example

Those are interesting.  However, I must again ask who's crying for these :-)

> The problem I see with the ubd=mmap is that
> it does not have a failure path for a
> non-page-aligned data sector, it looks like it
> just drops it, this would I think occur mostly
> on metadata updates, 2.4.23-1um was where
> I was looking, and I could be wrong, but if it
> does I would expect massive data corruption

I am looking for ubd-mmap data corruption, but I don't see any there.  In
the case that the data can't be mapped (wrong size, wrong alignment, etc),
then it just falls back to the old read/write code.

> Oh yes as a side note 2.6.0 and 2.4.25pre
> have the fix for Oops on the host kernel
> when reading /dev/shm with hostfs so if
> that was bothering you the 2.6 or next
> 2.4 kernel should help.

Yup, I saw that.  Nice work.

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
