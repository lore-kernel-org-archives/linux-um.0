Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxcD4-0004fd-KF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 18:59:22 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BxcD2-0004U3-9k
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 18:59:22 -0700
Message-Id: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.6.7-2
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
Date: Wed, 18 Aug 2004 23:00:59 -0400
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

I've released a second 2.6.7 UML patch.  This is to push out the changes I
have in order to give me a clean slate for the 2.6.8.1 UML.  These changes
sync up my 2.4 and 2.6 trees, and include

	Build cleanups, including 'linux' is now the default target, an
updated defconfig, and Kconfig updates
	Code cleanup, including removal of unused SMP code, removal of a 
userspace file, more EINTR handling, more error checking
	Time fixes, including switching from rdtsc to gettimeofday for the
real-time clock option and better handling of the host clock jumping backwards
	Introduction of centralized file descriptor management, allowing 
descriptors to be reclaimed if UML has hit the host's limit and the files
can be reopened to provide access to the same object on the host
	Introduction of externfs, which allows host resources to be mounted
as UML filesystems.  externfs handles the kernel interface and plug-ins to
it handle the host resources.  There are two users, hostfs and humfs, both
of which provide access to host directory hierarchies.  humfs stores metadata
separately, ala umsdos, which allows operations within the mount which would
require root privileges on the host with hostfs.  hostfs and humfs are still
somewhat dodgy on 2.6.
	UML can load at 0x8048000 like every other binary when MODE_SKAS
is enabled and MODE_TT is off.  This makes valgrind happier, and also
allows UML to have more physical memory without resorting to highmem.  With
STATIC_LINK disabled, the limit is ~750M, and with it enabled, the limit is 
~2.75G.
	A good number of bugs, including some crashes were also fixed.

For the full details, see
	http://user-mode-linux.sourceforge.net/changelog-uml-patch-2.6.7-2.bz2.html

For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html

Incremental patches between UML releases are available at
	http://user-mode-linux.sourceforge.net/patches.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org

				Jeff



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
