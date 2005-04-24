Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPm4O-0005yQ-9P for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:43:04 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DPm4K-00056Q-JW for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:43:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504242039.57025.blaisorblade@yahoo.it>
Subject: [uml-devel] [patch 0/7] uml: some invasive changes for -mm
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
Date: Sun, 24 Apr 2005 20:39:55 +0200
To: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it

This is the first of a series of 7 invasive patches for the -mm tree, which 
are to be reviewed (not only by UML folks), and possibly merged for the 
2.6.13 cycle.

The first one splits the i386 syscall table out of entry.S, without any real 
change for them (the file is included in the old place); if there are any 
syscall table changes, please be careful; this maybe means place *this* one 
before the others (or even merge now the i386 code movement part); I don't 
want that this patch is modified and that subtle bugs are introduced. The 
code movement is a really trivial code movement, however (no hidden changes).

This is needed to enable us to include the i386 syscall table, so that we are 
sure that they match. I already handled the real differences between i386 and 
UML (see the patch).

uml-fix-syscall-table-i386.patch
  uml: fix syscall table by including $(SUBARCH)'s one, for i386

uml-quick-fix-syscall-table-x86_64.patch
  uml: quick fix syscall table for x86_64

uml-fix-syscall-table-rem-for-x86-64.patch
  uml: fix syscall table by including $(SUBARCH)'s one, for x86-64

uml-console-redo-locking.patch
  uml: redo console locking
[ It's invasive, but seems to work well; wide testing is needed ]

uml-hostfs-avoid-buffers.patch
  uml - hostfs: avoid buffers
[ This is something which should work, even because you said that; I've 
partially verified this myself ]

uml-commentary-about-forking-flag.patch
  uml: commentary about forking flag
[ Jeff, give a look and possibly correct it. ]

uml-ubd-handle-readonly.patch
  uml ubd: handle readonly status
[ I cc'ed Jens Axboe ]

They are not to be confused with the previous series of 6 patches I also sent 
today, which are mostly little or already tested patches (list below); the 
explicitly marked one are urgent for 2.6.12, while for the other just take 
your choice (they should be trivial and have been tested):

[LIST of patches TO MERGE]:
uml-workaround-sed-behaviour.patch
  uml: workaround old problematic sed behaviour [compile-fix, for 2.6.12]

uml-nfsd-syscall.patch
  uml: add nfsd syscall when nfsd is modular [for 2.6.12]

uml-crypto-i586.patch
  uml: support AES i586 crypto driver [for 2.6.12]

uml-Makefile-avoid-rebuild.patch
  uml kbuild: avoid useless rebuilds [for 2.6.13]

uml-inline-empty.patch
  uml: inline empty proc

uml-move-va-copy-conditional.patch
  uml: move va_copy conditional def

Thanks a lot for the attention and regards.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
