Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co0jU-0004Zs-Nj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 06:41:24 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Co0jT-0000PP-W3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 06:41:24 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<41E0C885.3020608@tuxrocks.com>
	<200501091706.58778.rob@landley.net>
In-Reply-To: <200501091706.58778.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501101543.26588.blaisorblade@yahoo.it>
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
Date: Mon, 10 Jan 2005 15:43:26 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Frank Sorenson <frank@tuxrocks.com>

On Sunday 09 January 2005 23:06, Rob Landley wrote:
> On Sunday 09 January 2005 01:00 am, Frank Sorenson wrote:
> > I may not be able to answer all your questions, but I may be able to
> > offer a few pointers.
> >
> > For the UML kernel version, the stock 2.6.x kernel is getting better,
> > but still isn't the most stable and reliable kernel.  Right now, the
> > most stable I've found is using 2.6.9 from kernel.org, with the -bb4
> > patches from
> > http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.9-bb4/
>
> Hmmm...  Cool.  Grabbed it, I'll try to look through it tonight to see
> what's already in 2.6.10 and what isn't...

> > There are several thing you can do to improve the speed at which the UML
> > runs.  When UML starts, it opens a file in /tmp (or somewhere else if
> > TMPDIR is set), mmaps it, and uses that as its memory.  To speed this
> > up, make sure that it's located on a tmpfs-mounted filesystem (so it's
> > real memory).

> I remember way way back, that there used to be a gross hack people would do
> to get shared memory (before shm), which was create a file somewhere, have
> all the processes that needed to share memory open the file, and then
> delete the file.
Well, this is exactly what UML does... it actually deletes the file.
> That signalled the operating system to stop updating the 
> on-disk copy.
> I wonder if that old hack (deleting the file signalling there's no rush
> about writing stuff back to the disk anymore, although it's still your
> backing store) still works?
Well, this is not simply answered... for *any* file, deleted or not, Linux 
caches the write requests... and it still needs to write the datas out to the 
disk, when the system has little memory.

I also think that if the system is idle, Linux could write out the datas 
anyway (I don't know this well, but it's reasonable that the data are sync'd 
after enough time).

Now, your question reduces to only this one:

"Will Linux, without memory pressure but with CPU / disk pressure, start the 
cache writeout or not? "
At this point, I don't know 

> Why does it do this instead of just mallocing stuff, anyway?  (Quick and
> dirty shared memory again?)
Yes, as Henrik Nordstrom said.
> > fstab:
> > none   /UML/MEMORY      tmpfs   defaults,size=768M      0 0
> >
> > Starting the UML:
> > export TMPDIR=/UML/MEMORY
> > /UML/linux ...

> > Also, with an unpatched host kernel, your UML will run slower.  If
> > possible, patch the host kernel to allow UMLs to run in SKAS mode and
> > take advantage of some SYSEMU code.  These patches are also here:
> > http://www.user-mode-linux.org/~blaisorblade/patchlist.html or you can
> > get the 2.6.10 host patch from
> > http://uml.tuxrocks.com/Patches/host-skas3-2.6.10-v7.patch

> I know.  But once again, I'm tryng to use UML in hopes of being more
> portable and doing without root access.  Patching the kernel defeats the
> point entirely, I might as well just tell people "you'll need to boot
> 2.6.10 to build this, and it needs to be run as root".

> I'm more interested in correctness than performance at the moment.  As long
> as it WORKS, they can leave it running overnight for now...
Well, be careful... using TT mode can mean experiencing more UML bugs.
> > I don't know much about hostfs, so I can't give any real ideas there.
> > UML doesn't support TLS yet, so make sure that your UML root_fs doesn't
> > have a /lib/tls directory.

> The knoppix host system does, but the build directory I'm giving it
> doesn't.
He referred to the root_fs, i.e. in your case the directory you have as the 
root of the virtual system.
> Hmmm...  I wonder what TLS _is_?  Internationalization, I suspect.
Not at all!
> It 
> seems unlikely knoppix would waste space on a second copy of libc for any
> other reason...
Well, the 1st copy on glibc runs with any kernel (2.4 and 2.6) and uses 
LinuxThreads for threading support.

The 2nd copy, the one in /lib/tls, requires a 2.6 kernel, uses NPTL for 
threading support, and can give problems to some apps (including sometimes 
UML - but to get those problems, you need to link UML dinamically, while when 
TT mode is active it will link statically, and usually static link is done 
against non-NPTL glibc).

Note:
TLS = Thread Local Storage (one var, with TLS, can have a different value for 
each thread)
NPTL = Next Generation Posix Threading.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
