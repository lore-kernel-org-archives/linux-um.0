Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXRvZ-0008SD-7C
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 13:12:53 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AXRvX-0000Fu-BH
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 13:12:51 -0800
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id hBJLSge5008238
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 19 Dec 2003 16:28:42 -0500
Received: (from jdike@localhost)
	by ccure.user-mode-linux.org (8.12.5/8.12.5/Submit) id hBJLSffs008236
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 16:28:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20031219212840.GA8203@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] uml-patch-2.4.23-1
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
Date: Fri, 19 Dec 2003 16:28:40 -0500
To: user-mode-linux-devel@lists.sourceforge.net

This patch updates UML to 2.4.23.  The only change required by 2.4.23 was
the ELF_PLAT_INIT that other people saw and fixed.

In other changes, there are a couple bug fixes that I would like confirmation
of -
	the COW bitmap overrun bug which caused UML hangs for some people
	the ubd-mmap file corruption bug

So, if you were seeing either, can you try this patch and let me know one
way or the other if they are gone?

There were also some compilation fixes, a new export, and host_hz is now
64 bits.

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
