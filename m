Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ai9FN-0008CV-1g for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 01:29:33 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ai9FM-00064J-MG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 01:29:32 -0800
Subject: Re: [uml-devel] Dynamic remount with variable COW stacking/merging
	needed, support  for snapshot repilication
Message-ID: <20040118.002101.-9063.0.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
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
Date: Sun, 18 Jan 2004 00:20:58 -0800
To: sdw@lig.net, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

The stackable COW was not merged,
I have a new more abstracted version I
am working on, but Jeff seemed to want
to replace the LVM driver layer above
the ubd device to implement the COW
features rather then having COW as a
system feature below the ubd layer where
I need it, for it to work like a hardware
function. The LVM system can do its
own snapshot feature above the ubd
driver.
That puts LVM as the user of the UML
setting up a snapshot, and COW being
setup by the host admin completely
outside of the UML invisible (mostly)
to the admin of the UML (guest root)
Which provides two separate but
useful capabilities to the host admin
and the guest admin

Mostly I have been tinkering with the
ISAM style COW so that filesystems
that do not do sparse files will work
better,  but there are a lot of corner
cases to look at. So it is a bit slow.

The Dynamic remount could be done
in much less than one second, if you
prepare as a separate step, then
it is just replacing the file handle in the
device structure with a new handle
all writes before will occur to the
original COW and afterwards all
writes will occur to the new COW
since that is just a single pointer
write, it does not have too many
problems, only closing while running
the snapshot is likely to break things
and once the new COW is in place
the lower layer COWs can be merged
since they are then readonly, if it is
mounted r/w on more than one device
things would get messy, but that is bad
anyway I don't consider it a major
bug, but rather a user problem.

I have been thinking of some more
ubd flags ubd=C10H128S63 to
change disk layout or ubd1C10
for the ubd device 1 cylinder 10
case as a individual example.
C for cylinder
H for heads
S for sectors
P for padding i.e. 512 byte header
padding so that raw devices can be
checked without failing due to I/O
errors dropping out.
M for mmap size index,data
V to select what version header to create
V0 is a raw data file don't check for COW
V1 the first version header not portable
V2 the second one with the wrong math
V3 my version with the separated offset length
separated allows for using a program to fix the
math errors on detection without having to
redo the header format
V4 my version of ISAM
L for symlinks as names
U for update in place
which only really applies to the moo
program, but I was thinking should
have all the options defined.
?? sector size should have a option
?? for page size i.e. use 64k even on i386
so COW can be read on say a alpha
A to set AIO mode
R for readonly so all options are uppercase
S for sync data at each read/write
?? for sync on barriers for 2.6

The types of mmaping I think might be needed
no mmap in use -- for when mmap does not
work some fs do not mmap well
index mmap -- like now only the index/bitmap
is mmaped uses a fair amount of address space
full mmap -- map in both the index/bitmap and
the data, uses a huge amount of address space
paged index -- map in a (few) pages of the
index at a time, I have run with one page nicely
paged data -- map in a (few) pages of the data
at a time, I am not sure that this is helpful?

The problem I see with mmaping is that in order
to mmap properly I need to kmalloc a buffer
of the right size first, and then mmap on top of
the buffer, so that the kernel does not try to
use the space that is mmaped for other purposes
outside of the ubd_user/cow_user functions
which it would be free to do if it is not kmalloc'ed
and then if it tries to read/write that address space
the _user function would be using the mmaped
area not the kernel memory, or when the kernel
overwrites the index/bitmap with kernel data
Ick the mind boggles

The types of headers I think should be present
COW -- what we have now
ISAM -- which will work without sparse files
DISK -- just to keep disk image info CHS etc
HEADER -- like disk but treats the data in
the disk as a separate file sort of like the 
backing file in a COW setup
several different HEADERs could be setup
for one image file, each with a different layout
for the C/H/S as a example

The problem I see with the ubd=mmap is that
it does not have a failure path for a
non-page-aligned data sector, it looks like it
just drops it, this would I think occur mostly
on metadata updates, 2.4.23-1um was where
I was looking, and I could be wrong, but if it
does I would expect massive data corruption

My infrastructure currently uses mmap but I
hope to make that optional since it gobbles
address space, ISAM uses 8 bytes/sector as
index entries and so gobbles 64 times as much
as regular COW files, and I have problems
with the regular COW now, if I get the paged
version it will be much better.
The only other calls it uses are
ubd_malloc/ubd_free, (kmalloc/kfree) 
open, close, pread, pwrite
all of which are being abstracted through
common_open, common_close
common_pread, common_pwrite
so that ubd_user gets much nicer and
ubd_kern stops having bits of the COW
layer stuck in the device structure.

Then later the entire section can be replaced
if desired with a different implementation so
long as it provides open/close/pread/pwrite
or something similar.

Oh yes as a side note 2.6.0 and 2.4.25pre
have the fix for Oops on the host kernel
when reading /dev/shm with hostfs so if
that was bothering you the 2.6 or next
2.4 kernel should help.

James McMechan

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
