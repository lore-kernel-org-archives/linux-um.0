Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWID2-0001dd-Db
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 08:38:08 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AWID0-0002FN-9Q
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 08:38:06 -0800
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id hBGGrDkS002312
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 16 Dec 2003 11:53:14 -0500
Message-Id: <200312161653.hBGGrDkS002312@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.4.22-7
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Dec 2003 11:53:13 -0500
To: user-mode-linux-devel@lists.sourceforge.net

This is another sizable set of changes.  The major items in it are
	Sapan's real-time clock patch - this allows UML to sleep accurately,
assuming enough idle cycles on the host
	highmem support is back - it seems to work, but I haven't banged on
it to much.  One caveat is that using highmem in skas mode is very slow because
of the need to do kmapping in the copy_user routines.
	the start of SMP support in skas mode - it's not totally there, but
it now compiles and runs with one processor
	it will now use /dev/anon if it's present on the host, which it won't
be until I release that patch, which will be fairly soon.  In conjunction with
ubd-mmap, I'm seeing ~25% host memory use reduction.

There are also a number of smaller fixes, code cleanup, improved error
messages, etc.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
