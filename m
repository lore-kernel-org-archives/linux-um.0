Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BekgZ-0005Fi-B3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Jun 2004 18:11:51 -0700
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BekgY-0003of-V8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Jun 2004 18:11:51 -0700
Received: from mizar.alcor.net ([69.167.148.207]) by mta10.adelphia.net
	(InterMail vM.6.01.03.02 201-2131-111-104-20040324) with ESMTP
	id <20040628011143.XSNG12887.mta10.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 27 Jun 2004 21:11:43 -0400
Received: from mdz by mizar.alcor.net with local (Exim 4.34)
	id 1BekgR-0003T2-GY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Jun 2004 18:11:43 -0700
Resent-Message-ID: <20040628011143.GF5243@alcor.net>
Resent-To: user-mode-linux-devel@lists.sourceforge.net
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040628010443.GD5243@alcor.net>
References: <200406160822.i5G8Mba1020376@cluon.it.bond.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406160822.i5G8Mba1020376@cluon.it.bond.edu.au>
Subject: [uml-devel] Re: Bug#254665: uml-utilities: uml_moo produces broken
	images (short one block)
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
Date: Sun, 27 Jun 2004 18:04:43 -0700
To: user-mode-linux@lists.sourceforge.net
Cc: Alexander Zangerl <az@debian.org>, 254665-forwarded@bugs.debian.org

On Wed, Jun 16, 2004 at 06:22:37PM +1000, Alexander Zangerl wrote:
> Package: uml-utilities
> Version: 20020415-3
> Severity: normal
> 
> i've got some ext2 fs images, normal cow-files, and the need to recombine them.
> but the resulting file is one 1k-block shorter than the original, and doesn't
> work at all. the original images were sparse (but that shouldn't make any
> difference, IMHO).
> 
> the original image is 102401024 bytes (1024x100001),
> as e2fsdump sees it:
> 
> Filesystem volume name:   <none>
> Last mounted on:          <not available>
> Filesystem UUID:          7ae0f33e-3b48-4a97-b8eb-8ecdb21dabfe
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      filetype sparse_super
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              25064
> Block count:              100001
> Reserved block count:     5000
> Free blocks:              87105
> Free inodes:              18818
> First block:              1
> Block size:               1024
> Fragment size:            1024
> Blocks per group:         8192
> Fragments per group:      8192
> Inodes per group:         1928
> Inode blocks per group:   241
> Last mount time:          Tue Jun 15 18:49:46 2004
> Last write time:          Tue Jun 15 18:50:09 2004
> Mount count:              2
> Maximum mount count:      25
> Last checked:             Tue Jun 15 17:51:20 2004
> Check interval:           15552000 (6 months)
> Next check after:         Sun Dec 12 17:51:20 2004
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:               128
> 
> the broken result of uml_moo is 102400000 bytes (1024x100000),
> and e2fsdump gives exaclty the same output as before for the superblock.
> 
> (judicious application of dd if=/dev/zero >> the broken result seems to
> make the image work, but that appears to be only because the area wasn't used
> in the original image.)
> 
> if there is more info required let me know.
> 
> regards
> az
> 
> 
> -- System Information
> Debian Release: 3.0
> Architecture: i386
> Kernel: Linux cluon 2.4.26 #1 Fri Apr 16 12:21:48 EST 2004 i686
> Locale: LANG=C, LC_CTYPE=de_AT
> 
> Versions of packages uml-utilities depends on:
> ii  libc6                     2.3.2-9        GNU C Library: Shared libraries an
> ii  libncurses5               5.3.20030719-1 Shared libraries for terminal hand
> ii  libreadline4              4.3-8          GNU readline and history libraries
> 

-- 
 - mdz


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
