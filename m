Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4NK5-0004oF-UG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Mar 2004 08:58:17 -0800
Received: from tektonic.net ([69.93.28.254] helo=unix.easyadmin)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B4NK4-0003FI-3i for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Mar 2004 08:58:16 -0800
Subject: Re: [uml-devel] Swapping directly to host swap area?
From: Matt Ayres <matta@tektonic.net>
Reply-To: matta@tektonic.net
In-Reply-To: <Pine.LNX.4.44.0403190014030.2368-200000@sparrow>
References: <Pine.LNX.4.44.0403190014030.2368-200000@sparrow>
Content-Type: text/plain
Message-Id: <1079715490.11383.5.camel@cpx.office.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Fri, 19 Mar 2004 11:58:11 -0500
To: William Stearns <wstearns@pobox.com>
Cc: Jeff Dike <jdike@addtoit.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Does this actually work?  I had tried something similiar and it couldn't
read/write the file as O_DIRECT requires the data to be aligned.

Also, in my thinking it would be better to open the rootfs O_DIRECT and
leave swap as is.  O_DIRECT was made for applications who do their own
caching (such as UML).  You're essentially caching the data twice (which
ubd-mmap was aiming to fix).  If you open swapfs as O_DIRECT and a UML
swaps a lot it will just thrash the disk, normally the swapping will be
done in memory and might not ever touch the disk.

Here is the link to my patch, it's not clean as it was never intended to
be distributed.  It also doesn't work, it's very close to working I just
lack good pointer/memory allocation knowledge.

http://www.tektonic.net/public/odirect-not-working.diff

On Fri, 2004-03-19 at 00:51, William Stearns wrote:
> Good morning, Jeff,
> 
> On Tue, 27 Jan 2004, Jeff Dike wrote:
> 
> > wstearns@pobox.com said:
> > > In the current setup, the host kernel sees this as a normal
> > > write to an open file, caching it in the process and so not truly
> > > freeing up the ram for a bit. 
> > 
> > This is, and this could be done by setting O_DIRECT on UML swap devices.  That
> > way, writes go directly (and asynchronously) to the device without landing
> > in the cache.
> > 
> > With mmap in effect, this can also be done with a MADVISE_DONTNEED on the
> > relevant pages of the swap file.
> > 
> > Patches cheerfully accepted.
> 
> 	In that case, patch cheerfully submitted.  :-)
> 	The attached adds a fourth ubd option, "D".  When enabled, the 
> open call for that ubd file will use the O_DIRECT option.  I didn't tackle 
> the MADVISE portion, sorry.
> 	When I try to use it, I get back "cannot stat /dev/ubd/1: No 
> such file or directory."  The file is, of course, there, and I've checked 
> I'm using a kernel with this patch.  Does the Linux open64 not handle 
> O_DIRECT?
> 
> 	If the patch is mangled in transit or missing, it will also be up
> at http://www.stearns.org/uml/ in a bit, along with a kernel compiled with 
> this patch.
> 	Cheers,
> 	- Bill
> 
> ---------------------------------------------------------------------------
>         "Where's the kaboom, there was supposed to be
> an earth-shattering kaboom!"
>         -- Marvin Martian
> (Courtesy of John Green <johngreen@starband.net>)
> --------------------------------------------------------------------------
> William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
> rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
> --------------------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
