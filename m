Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEQP3-0006aU-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 01:44:41 -0800
Received: from bay2-dav62.bay2.hotmail.com ([65.54.246.197] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AEQOI-0001R6-Rn
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 28 Oct 2003 01:43:54 -0800
From: "James McMechan" <James_McMechan@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <BAY2-DAV62hA53ZpEVm00000924@hotmail.com>
Subject: [uml-devel] About COW & filesystems
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
Date: Tue, 28 Oct 2003 01:34:10 -0800
To: user-mode-linux-devel@lists.sourceforge.net

I saw a comment about updateing loopback to do the
COW file functions, some of Jeff Dike's new COW stuff
seems to indicate that he was looking at something like that
though the last status I remember was don't use it yet :/
some of it seems to have been removed from more recent UMLs

If you want to hack on it I would suggest looking at the device mapper
as I seem to remember comments about the loop device being a poor
example to follow, and not being maintained well, and the new device
mapper already has examples of feeding requests back into the block
queue, using DM you could split the request for COW data and
backing data to seperate ubd devices, note that it would be nice to
have more ubd devices when doing this...
Even better, if you hack it well it would also work on host kernels,
well 2.6+ host kernels but DM appears to be the wave of the
future, and COW files on real devices would be sweet.

********

Regarding the new COW V3 format

Jeff I saw your comments about
1) Alignment field in header - to align bitmap & data
2) mmapping option - to mmap the data and bitmap
3) cow format option - to provide for alternate layouts
4) moved backing file to end of header - this puts all the fixed length
stuff first
5) fixed rounding bug - not sure which rounding but this was
6) updated header to fixed lengths - well mostly the time was still a
local fomat
7) d option - to prevent treating a COW file as a COW file (a later
option I think)

********

Commentary on features

1) Alignment -- the previous problems with alignment were
due to reading a header that was not a exact multiple of sector size
this is why it would not work on raw devices, it dumped out
trying to read the header not the data, since it checks first if it is a
cow header and quits on a read error it could not even be the backing
file the alignment of the bitmap and data sectors was not a problem but
fixing that would be nice to have, also I think that putting the real
offsets
rather then a alignment value would make more sense if it is aligned
wrong
it can't be easily changed.

2) mmaping option -- my problem has always been the reverse
my UMLs ran out of address space even when just mmapping
the COW bitmap, I can picture paging in sections of the data by
mmap, but as proposed I would expect to run out of address
space on my first ubd of ~2-4GiB since I have tried (using my
previous patch set) a 64TiB array (sparse) I would expect to
use all of memory for the mmap in short order. I am not sure that
mmapping is faster than pread/pwrite which I was using earlier, I
expect that both would be faster than the seek and then
read+write that currently is in use.

3) cow format option - the ISAM files that have been proposed as
alternatives to the sparse COW files that V2 uses for DOS format
filesystems which don't do spare files well, I seem to remember ~3
different formats for different puropses some of which would require
different layous for the header ... ick, and I have thought it would be
easier to just use new V4..6 for example as the COW version instead
besides I don't seem to remember anyone showing code, I just made
a few fragments as tests.

4) moving backing file to end of structure -- I think I may have
suggested this it makes it much easier for me at least to read the
hex dumps on the COW file, also zeroing the backing file array
make it easier to read, I seemed to get mostly 'Z' in my dumps
which is ok but \0 is nicer, I have slab posioning turned on.

5) fixed rounding bug - I am not sure which of the rounding bugs
this refers to, I think it is the calculate cowbit map size but there
was
also the one about passing 2 words of the bitmap between
ubd_kern and ubd_user which would walk off the end of the mmap
I was working on haveing the bitmap only read from the user side
since I think it makes the ubd_kern driver much clearer

6) update header to fixed lengths - another portability bit I may
have suggested, I think that the time should be converted also.

7) d option - this is another approach that should work when
using raw devices in addation to its commented purpose of
letting UML read a COW file as a plain file.

********

Other featues I seem to remember coding examples for

A) having C/H/S in the header - I would like to be able to have
other partition layouts so that real disk images can be used.

B) treating the COW stuff as private_data to the ubd_kern.c
so that it can stack, and with this we can push the COW
option parsing over to _user side and then the _user side
can also be used as libaray for uml_moo, one implementation
is of course safer in that fixes don't need to match in two
codebases.

C) removing the limitations on 8 ubd devices this gets
rather messy if the COW info (fds, bitmap, is not private to the _user
side

D) create COW file by seek rather then writing lots of zeros

E) I have a preference for making the COW layer look like
other linux file functions i.e. open,close,[p]read,[p]write.
I prefer the pread/pwrite since in halves the number of system
calls by not needing a seek for every read/write

F) paged COW bitmap - I run out of memory when I do
strange things like wanting a COW file on >512GiB files
so I did a paged bitmap

G) alignment - the header needs to be padded one of the
reason was that my test versions had both length and offsets
for the backing file name, COW bitmap, and data area
if this is done they can be placed in any order and
extra fields can be added to the header without breaking
the exisiting code, the other option is to use something like
the tagged headers of e.g. zip files, well one of those DOS
tar replacements.

H) Alignment 2 - another reason for offsets is that when
problems are discoved like the offset calculation the
code to read the old format must still be present in its
errornous form to allow for reading the previous COW
files otherwise the corrected calculation will index to
the wrong part of the file producing a off by 1 error
on the sector address of each data sector and having
all the COW sector adresses off by 1 will be very
corrupt as some sectors, those in the COW file will
have that off by 1 and those in the backing file won't
... ick ....

I) the fast bitmap operations - the bitmap test/set/clear
functions can be done with shift (<<,>>) and &,| this
code is both faster and smaller then the current *,/,%
code

********

Stuff that I have not done but would be willing to code

I) paged COW mmap - if you really think that mmap is
much more efficient than pread I will try out a paged
version so I don't run out of memory

II) paged data mmap - and I am willing to do the same
for the data if you think it would help alot

III) one of the ISAM files as a example if someone
would be willing to use it for a while. One simple
example is ok but there has not been alot of call
for ISAM on the list, and I hate writing brand new
dead code....

IV) updated moo program to convert several layers
of COW file into one
e.g. COWA,COWB,COWC,backing to produce
COWA,backing2
also to update C/H/S for a new partition layout
also change alignment of COW file for different
requirements I like offsets rather than a single
alignment value so that the file elements can be
put in any order and have gaps of desired sizes.

V) add in a sector size option so that we can
play like CDROMs and that funny sectored
hardware, Zip disk maybe?

********

Jeff you had said that you would like it in small parts

I would offer converting to COW_open,close,read,write
first with the private_data so ubd_kern gets cleaned up.
then converting to dynamic disk allocation, stackable
COW files get quite easy with private_data it can just
recurse using the private_data to find the next layer,
and since it does not require static information from
ubd_kern it can stack, my notes indicate I was running
25 deep COW file stacks.

Or perhaps the conversion to external COW
version files, cow_v1.[ch] etc.which makes plugging
in new versions easier e.g. V3 & ISAM, I seem to
recall testing with the fops proposal, and one where
a index was used to select which read/write routines
were used, fops was more the linux kernal style though.

Paged mmap for the bitmap and data could occur in any
order with the other work

The faster bitops are a tranparent replacement.

This is somewhat backwards in that it stacks the COW
file under the ubd device, but this is pretty much how it
has always been done and once the ubd_kern side is
cleaned up putting a equivalent on top via DM should
not make things too complex, I seem to remember
booting from DM or worse yet loopback is a pain.
Then later once DM is working nicely we can drop
the COW layer under ubd easily by just replacing
the COW_open/close/read/write with the normal
open/close/read/write functions and let DM do
all the hard work, alas not in the 2.4 roadmap,
though it does seem like something that may get
backported...

Sorry to be so long but I haven't done much on
UML but some work on booting of the ThinkNIC
distribution on UML, and way to much fighting
with windows at work.

James McMechan


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
