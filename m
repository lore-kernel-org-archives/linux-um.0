Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cp6wZ-0005bv-NR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:27 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cp6wV-0005zU-GO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:27 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113051334.BF94263251@zion>
Subject: [uml-devel] [patch 5/8] delete unused header umn.h
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
Date: Thu, 13 Jan 2005 06:13:34 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, domen@coderock.org


From: Domen Puncer <domen@coderock.org>
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>

Remove nowhere referenced header. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11/arch/um/include/umn.h |   27 ---------------------------
 1 files changed, 27 deletions(-)

diff -L arch/um/include/umn.h -puN arch/um/include/umn.h~uml-delete-unused-header-umn_h /dev/null
--- linux-2.6.11/arch/um/include/umn.h
+++ /dev/null	2005-01-10 11:39:51.461898480 +0100
@@ -1,27 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __UMN_H
-#define __UMN_H
-
-extern int open_umn_tty(int *slave_out, int *slipno_out);
-extern void close_umn_tty(int master, int slave);
-extern int umn_send_packet(int fd, void *data, int len);
-extern int set_umn_addr(int fd, char *addr, char *ptp_addr);
-extern void slip_unesc(unsigned char s);
-extern void umn_read(int fd);
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
