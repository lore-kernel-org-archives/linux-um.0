Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AijMA-0003Lz-1y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 16:02:58 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AijM9-00014p-I1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 16:02:57 -0800
Message-ID: <20040119.155346.-522689.0.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
Subject: [uml-devel] Re: more on COW (long)
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
Date: Mon, 19 Jan 2004 15:53:43 -0800
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

> What does COW have to do with the LVM driver?  They're completely 
> independent of each other.

They are independent, last time we emailed about this you said, as below
that you wanted to move the COW layer up, where I want to move it
down :), above the ubd device is the request queue where the LVM
system lives, it should be possible to have a LVM module that can
understand the COW format, I think it would work best, from what I
have seen, as part of the device mapper LVM, in 2.6 and there is a
backport to 2.4 apparently

The setup in that case would be to use losetup to make devices using
one for each COW and backing file so you can only have 1/2 of the
available loops used for COW files and the other 1/2 as the backing
files i.e. 4 COW files with 4 backing files from 8 loop back devices
the usual default, as of Feb 2002 you can now have up to 256 loop
devices. But I think that a hard limit of 128 COW files per system is
too small, and if the max_loop is left at the default of 8... 4 COW files
per system would be a great pain, (yes, if they all use the exact same
backing file you could get 255 or 7)

And then you setup LVM using the COW plugin, using the loop
devices as the parts for the LVM device, I am pretty sure that the
COW format does not much resemble the current LVM volume
group headers pvcreate is the command I think

Another option is to upgrade the loop driver much like cryptoloop
but even cryptoloop appears to be moving to using LVM instead of
the loop infrastructure, which few of the kernel hackers seem to like

> The COW stuff is inside the ubd driver, rather than below it.  I 
> want it
> to be above the ubd driver, so that it is completely outside, and a 
> ubd device deals with only one file.

The COW stuff is currently embedded into the ubd driver, this makes
new COW formats & ISAM a pain to link in, you said you wanted to
move it up, to I was assuming the LVM stuff, I wanted to move it down
to a layer below the ubd so the request queue looks normal, I want it
to look to the ubd driver as a single file so none of the COW stuff is
embedded into the ubd driver itself, I also wanted a arch that allows
plugging in of new formats easily so I can stuff ISAM in for example
User side plugins seems easier to work on than kernel plugins.

> This will clean up the code, allow stackable COW files as a trivial
> side-effect, and allow COW volumes to be mounted on the host.  What 
> won't you be able to do if this happens?

Yep, once the ubd driver regards the COW device as a single file
the stacking is more or less free, regardless of above/below the ubd
driver layer, I think of COW as sort of a lib_moo style on the
userspace side it could also be used for the uml_moo program and
be used as a userspace filesystem plugin program, I don't really
want to think about trying to use fstat or mmap from the middle of
the request queue stack, and I don't want those details creeping
back into the ubd driver once they are out of there, since what
needs mmapping needs to change based on format, 

What won't LVM do, well I don't normally use it so I could be
easily wrong, but booting from LVM appeared somewhat different
from regular devices, not a lot harder but different and might take
a initrd for some setups that don't use it now, I would also like
the option of running LVM on top of COW and while I think
LVM can be stacked on LVM I would prefer to have them
separate so that LVM upgrades don't break COW, the ubd
driver and the COW are closely related so changing them together
is less of a problem, I think it should look like a plain device once
you are inside of the UML not having the UML userspace required
to setup a LVM (unless I want to do that also)

> This is another thing a separate COW driver will make possible.  A 
> COW volume
> could mounted on the host and be passed to UML as a device.

Yes any of the un-embedded versions should allow this, I was
thinking the user space file system, then we can keep using mmap
and the other normal features of a XYZ_user.c part :) and have 
someone else working on support of the kernel module.

> Just to be clear, you're suggesting copying a COW file on the host, 
> then
> switching the ubd driver to use the copy?  I don't see how that 
> helps, because
> the COW file needs to be quiescent during the copy.

Um, not exactly, I should not compose e-mail at midnight.
starting with ./linux ubd0=COW1,backing
I was suggesting creating a new COW file COW2,COW1
for example while COW1 is mounted and then at the right time
(after sync or when 2.6 sends the barrier request) replacing
the fd in the ubd structure with the pointer to COW2 which
then will process all of the writes, and COW1 is now effectively
read only and can be closed and the R/O copy from the COW2
creation is used, COW1 and all lower COW files can then be
merged either manually with uml_moo, or as a background task
at cow_user level which after completion can replace the COW1
entry in the COW2 stack, I think the LVM snapshots work
almost the same way and in both cases fsck needs to be run on
rollback to restore the filesystem.
 
> This is better than stuffing geometry in the COW header.  Are there 
> any actual
> uses that you know of for specifying the geometry of a ubd device?

> Again, interesting, but are there any uses for this?

Well yes, I want to be able to read real disk images either from a raw
device, yes we could stick in a special case ioctl to check for a real
device and read its geometry but ick it is easier to specify it, or from
a dd'ed image file of a hard disk which would not work even with the
ioctl, so ubd1C102H15S16 is better from my view :), when I do this
now i have to rewrite the ubd_driver with the new CHS to get the
partitions and I don't really like that much.

None of my real hard disks seem to use H128S32 and S63 is much
more common, and the fake disk geometries are even worse, and I
would like to have a header where I can specify the geometry so that
it is saved with the data and I don't have to keep track of what the
real disk had, see DISK & HEADER one allows me to merge in the
data from the disk image and the other uses just a header so it can
have them separate, and then I usually want a COW on top so it
is read only, I don't want to write to SGI disk images very often
as a example I have actually had, but I do want to mount them.

> > P for padding i.e. 512 byte header
> > padding so that raw devices can be
> > checked without failing due to I/O
> > errors dropping out.
> 
> I think this happens automatically since I/O happens with 512 
> granularity anyway.

Um, no the header of the COW is tried first and it was not a
multiple of 512 that is why the raw device broke it tried to
read the V2 header and had a I/O error and then did not
try the plain file case due to the I/O error though it would
have worked as a plain file, he just wanted ubd1=/dev/raw1
without a COW file so there was no header to read, but
it still had the 512 alignment restriction so read->I/O error

> > M for mmap size index,data
> 
> Do you mean the mmap unit?

Um yes, how big a chunk to mmap in each case
I would guess a default of one page for index/bitmap
would be about right, and no mapping for data  and
other sizes for the expert user or performance tests

My current test maps in all of the bitmap or index and none
of the data, other settings would be nice to have.

> > V to select what version header to create
> > V0 is a raw data file don't check for COW
> > V1 the first version header not portable
> > V2 the second one with the wrong math
> > V3 my version with the separated offset length
> > separated allows for using a program to fix the
> > math errors on detection without having to
> > redo the header format
> 
> I don't want to support old COW versions.  I don't see any point in 
> allowing UML to create V1 or V2 COW files.

I was writing it very generally, V1 and V2 are just normal cases and
it was not hard to put in, also someone always seems to want to do
odd things like run broken versions every once in a while.
As of now V2 is the current format, V3 is being worked on but
is not yet present.
In any case I was planning on a warning message to indicate that V1
is obsolete and add the same message later to V2 once V3 is working,
and it is only a question when creating a new COW file, I have had
V3,V2,V1,backing as a test case last year so sometime you do want
it if only to make sure it still works.

> V0 is needed, but that's the wrong name.  Some other switch is 
> needed to
> tell the driver to treat the file as data even if it looks like a 
> COW file.

Ok how about D -- direct (also uppercase)
V0 is just the free case since it is entry 0 in the table of formats to
try in my table just like V1/2/3/4 are the same entries in the table
it is very easy if they are seq numbers

> > V4 my version of ISAM
> 
> This is a new cow_format, not a new version of the COW file (and I 
> realize
> that sounds confusing :-).  IOW, you set the cow_format field in the 
> header
> to 1, after getting me to assign 1 as the ISAM cow_format.

Why not, we already have a type field the cow_version why do we
need another integer to express that it is a new format plus the data
in the header changes, the current variable for ISAM does
not really map to anything similar in a COW file the index and the
cow bitmap resemble each other but the length computation is very
different sector count/8 vs sector count*8 so there is not much
code in common between a COW & ISAM how it is laid out on
disk is different, how you find a sector is different, when you need
to update the header is different etc.

Also there is not currently a cow_format in V2 header and this has a
different header layout also, additionally DISK & HEADER from the
list of other formats I think would be useful, though they can also be
degenerate cases of COW or ISAM with index/bitmap length = 0
But I would need the CHS in the headers in the latter case, and I
want them in any case.

The method I was using has separate cow_v1/2/3.c files each of
which is self contained the cow_user.c I am building has
common_open/close/pread/pwrite that calls the cow_vX.c and
isam.c through a ops structure linked in but everything is isolated

I am still basing ISAM off of my proposed V3 cow file since I had
it working, and I really like offset,length pairs, they seldom break.
For example this would have made the V2 bug where the map
overlaps data a trivial fix of- run a program like uml_fix to check the 
COW file and rewrite it if it had the overlap with the new offset and
length just moving the data to fix the problem and then new versions
of UML that detects the overlap would say ~"overlapped header run
uml_fix" but the header format would not need to change just the math
to calculate it, which is where we had the error, I also included
overlap checks in the header write routine for my V3 and ISAM.

> > L for symlinks as names
> 
> What this?  I don't remember seeing this before.

To not follow symlinks like we do now and allow that person
who wanted symlinks pointing to where the backing files are kept
to not show up as fixed paths in the COW file, I regarded his
comment as a reasonable request, If you want the COW file to
lie it should pay attention.

> > U for update in place
> > which only really applies to the moo
> > program, but I was thinking should
> > have all the options defined.
> 
> Well, if the ubd (or COW) driver isn't going to do update in place 
> (and I don't
> see why that makes sense), then it should just be specific to 
> uml_moo.

First define it generally so that it is not used differently on moo/UML
and second it might make sense later, like the snapshot uml_moo
to merge layers of COW files below the new snapshot to save space

It had not occurred to me that someone would want to generate a
COW file on a mounted system at runtime, but now it seems clear
that could be very useful.

That is why really I like general solutions, they allow strange things
you did not think of initially to be put in without too much trouble
once it becomes clear why it would be useful.

> > ?? sector size should have a option
> > ?? for page size i.e. use 64k even on i386
> > so COW can be read on say a alpha
> 
> Yeah.
> 
> > A to set AIO mode
> 
> I think this should be auto-detected and used.  Maybe there should 
> be a no-AIO
> for debugging.  In any case, AIO is a lot less useful with ubd-mmap, 
> unless
> there is an AIO way to wait to a page to be faulted in.

AIO was a pain to auto detect, the compile time check will
find it in some cases where glibc emulates it with threads, having glibc
try to create threads from a UML did not work at all last time
so AIO would need both a off and on option last time I tried it
defaulting off would prevent breakage, but default on has better
performance, so off by default with A for on should be ok.
But if it tries to auto-detect a command to force off is needed
in case glibc is being fancy.

Yes it can be useful even with mmap since it allows read/writes
to complete out of order on the host, so if they are really going
to disk you can get a large speedup by having the host reorder
the requests properly just like it does with its own requests,
plus you can have several requests outstanding at once with
AIO just like you can use the cache on the ide drives with
TCQ, the writes would really benefit and would not block
the reads where the data is mmaped in, I sort of remember
a AIO mmap somewhere.

> > R for readonly so all options are uppercase
> > S for sync data at each read/write
> > ?? for sync on barriers for 2.6
> 
> Are you thinking barriers for journalling filesystems?  That would 
> be useful, but I've done no thinking about that.

The new request queue has what I think are the JBD barriers
sent in the queue and I was thinking that would be nice
to sync when we got them, much less overhead than the
ubd=sync option and it should work properly with little effort
Sort of the equivalent of the ide flush command.
And just like the real thing you may not want it turned on :(
even if it is available

> The paged index would be useful (and that's probably the only way 
> mapping the
> index could be useful on x86).  It's not obvious to me that you can 
> keep the
> right parts mapped.  Also, the fact that only little pieces of the 
> index
> are mapped at any time make it a lot harder to make mapping pay.  
> With only
> two words being changed at a time, the writes are pretty damn 
> cheap.

I was no longer planning on just doing two words of update
currently my version is very inefficient and does once sector at a
time and the common_pread/write puts them together, but I was
planning on having runs continue N sectors at a time and that
is harder, for ISAM the index is directly mapped, hey it is proof
of concept I don't want to optimize until the infrastructure is better
I want easy to write and clear to read for the first versions, they
will work better (no crashes) we can make it fancy later but I
want to sketch out what flags I think will be needed later now
so as to avoid forgetting something, my earlier version used the
paged bitmap but it was somewhat complex.

> You'd use __get_free_pages for this, not kmalloc.  But that's 
> exactly what
> happens, and it works cleanly.  You allocate the pages, overmap them 
> from
> the device, and then unmap and replace the original pages on free.

I don't remember the current V2 doing either, but I think it is needed
currently V2 vmalloc's the data area and then just reads it in, I was
actually using mmap itself, that way I did not have to worry about
writing the bitmap/index out at the end, I also use pread/pwrite
since as far as I know every block currently has a seek to the
block's offset anyway :) I don't know of any real seeks on a block
device they all have block numbers

Yet another upgrade for the future, vmalloc is not liked by
Linus, I was just using kmalloc so I only had one type of
memory allocated, get_pages is better in some cases.

> > The types of headers I think should be present
> > COW -- what we have now
> > ISAM -- which will work without sparse files
> > DISK -- just to keep disk image info CHS etc
> > HEADER -- like disk but treats the data in
> > the disk as a separate file sort of like the 
> > backing file in a COW setup
> > several different HEADERs could be setup
> > for one image file, each with a different layout
> > for the C/H/S as a example
> 
> Those are interesting.  However, I must again ask who's crying for 
> these :-)

Me :) for one, and someone else wanted ISAM to run on a DOS?
partition which will not do sparse files...
I want to keep disk images with different CHS geometry

> I am looking for ubd-mmap data corruption, but I don't see any 
> there.  In
> the case that the data can't be mapped (wrong size, wrong alignment, 
> etc), then it just falls back to the old read/write code.

It was a while ago when I was trying to figure out the ubd=mmap
option, seems I was wrong :(, I don't even see where I was
looking, it might also have been in your separate cow layer

Some examples of where I might have been lost:

physmem_subst_mapping seems to be a function which reads in
by mmapping over the buffer in the request and sets up
a hash to keep track of what was mapped where, but it has
no comments at all, unless you just added some recently.

file_io from os/file.c is also quite arcane without comments
the paging in by calling down to get one char from each
page looks like it should work but makes a read or a write
route through several indirect layers and passing in the copy
function pointer is interesting when debugging, I have not
figured out why you wanted to put the interfaces in
those exact spots though.

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
