Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cp6wG-0005ae-Bs for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:08 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cp6wC-0005zT-G0 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:07 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113051332.4F4AA6324F@zion>
Subject: [uml-devel] [patch 4/8] uml: drop unused buffer_head.h header from
	hostfs
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
Date: Thu, 13 Jan 2005 06:13:32 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Drop that header inclusion - I discovered this header was unused while
checking whether I can use the __set_page_dirty_nobuffers speedup suggested by
Andrew Morton.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-drop-buffer_head-header-from-hostfs fs/hostfs/hostfs_kern.c
--- linux-2.6.11/fs/hostfs/hostfs_kern.c~uml-drop-buffer_head-header-from-hostfs	2005-01-13 01:57:47.533076768 +0100
+++ linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c	2005-01-13 01:57:47.564072056 +0100
@@ -15,7 +15,6 @@
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/list.h>
-#include <linux/buffer_head.h>
 #include <linux/root_dev.h>
 #include <linux/statfs.h>
 #include <linux/kdev_t.h>
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
