Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Na0-0002Dd-96 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:48 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8NZz-0002d3-K4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:48 -0800
Message-Id: <200503072038.j27Kcfbc003993@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 11/16] UML - add a comment explaining pread
	availability
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
Date: Mon, 07 Mar 2005 15:38:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Prompted by Dave Mielke: This adds a comment explaining why we do not
define _XOPEN_SOURCE, even though the pread man page says you should.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/cow_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/cow_user.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/cow_user.c	2005-03-05 12:19:11.000000000 -0500
@@ -1,6 +1,9 @@
 #include <stddef.h>
 #include <string.h>
 #include <errno.h>
+/* _XOPEN_SOURCE is needed for pread, but we define _GNU_SOURCE, which defines
+ * that.
+ */
 #include <unistd.h>
 #include <byteswap.h>
 #include <sys/time.h>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
