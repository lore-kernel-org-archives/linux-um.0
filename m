Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wX8s-0004NL-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 18:18:02 -0700
Received: from boof.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wX8p-0002eT-Ce
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Sep 2003 18:17:59 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] uml-patch-2.4.20-8
In-Reply-To: <200308291741.h7THfbg7014738@uml.karaya.com>
Message-ID: <Pine.LNX.4.44.0309082015570.26334-100000@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 8 Sep 2003 20:17:14 -0500 (CDT)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 29 Aug 2003, Jeff Dike wrote:

> This patch adds V3 COW support.  New in V3 are
> 	There is a new alignment field in the header.  The start of
> the bitmap and data are aligned according to this value.  This is needed
> for COW files on devices with access alignment restrictions such as /dev/raw
> and also for mmapping data by the ubd driver, since the data in the COW file
> needs to be page aligned.
>
> 	There is a new cow_format field in the header.  This is used
> to specify how COW blocks are specified.  Currently, the only supported value
> is 0, which is the usual COW bitmap.
>
> 	The backing file is moved to the end of the header so that it
> can possibly extend into the alignment padding in the future.
>
> 	The rounding bug is finally fixed.
>
> 	Bit lengths of header fields are more carefully specified.
>
> The ubd driver now has mmap support.  If you put 'ubd=mmap' on the command
> line, then the ubd driver will use mmap wherever possible.  Needless to
> say, this is new and experimental, so don't trust valuable filesystems to
> it just yet.

This appears to make it dead in the water.  I can't use 2.4.22-1um at all.
ubd=mmap(or not) both fail.

ubd=mmap:

VFS: Mounted root (ext2 filesystem) readonly.
INIT: version 2.84 booting
INIT: cannot execute "/etc/init.d/rcS"
INIT: Entering runlevel: 2
INIT: cannot execute "/etc/init.d/rc"
INIT: no more processes left in this runlevel

none:

VFS: Mounted root (ext2 filesystem) readonly.
INIT: version 2.84 booting
Kernel panic: I/O op mismatch
In interrupt handler - not syncing

2.4.20-6um works fine.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
