Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEXTQ-0000XY-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 09:17:40 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEXTP-00045f-LE
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 28 Oct 2003 09:17:39 -0800
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id A27461F3
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 12:17:38 -0500 (EST)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1AEXTO-00084m-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 12:17:38 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] About COW & filesystems
Message-ID: <20031028171738.GG6350@dijkstra.csh.rit.edu>
References: <BAY2-DAV62hA53ZpEVm00000924@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY2-DAV62hA53ZpEVm00000924@hotmail.com>
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
Date: Tue, 28 Oct 2003 12:17:38 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Tue, Oct 28, 2003 at 01:34:10AM -0800, James McMechan wrote:

> Even better, if you hack it well it would also work on host kernels, well
> 2.6+ host kernels but DM appears to be the wave of the future, and COW
> files on real devices would be sweet.

DM is available and actively maintained on 2.4 as well (LVM2 and EVMS 2.x
use it there).  They already implement snapshots (COW) using device-mapper;
the only difference is that they use a different on-disk metadata format to
store the bitmap.

> This is somewhat backwards in that it stacks the COW file under the ubd
> device, but this is pretty much how it has always been done and once the
> ubd_kern side is cleaned up putting a equivalent on top via DM should not
> make things too complex, I seem to remember booting from DM or worse yet
> loopback is a pain.  Then later once DM is working nicely we can drop the
> COW layer under ubd easily by just replacing the COW_open/close/read/write
> with the normal open/close/read/write functions and let DM do all the hard
> work, alas not in the 2.4 roadmap, though it does seem like something that
> may get backported...

Booting from DM is not bad; there is an ioctl interface to get the physical
block addresses to give to the boot loader, and a patch for LILO to use it.
I don't know whether grub or any non-i386 bootloaders have support yet.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
