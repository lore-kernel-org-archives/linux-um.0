Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cpwjt-00049N-4y for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Jan 2005 14:49:49 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cpwjs-0007ai-J9 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Jan 2005 14:49:49 -0800
Message-Id: <200501152249.j0FMngl08629@mail.osdl.org>
From: akpm@osdl.org
Subject: [uml-devel] [patch 051/122] uml: delete unused header umn.h
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
Date: Sat, 15 Jan 2005 14:49:23 -0800
To: torvalds@osdl.org
Cc: akpm@osdl.org, blaisorblade_spam@yahoo.it, domen@coderock.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>,
      Domen Puncer <domen@coderock.org>

Remove nowhere referenced header. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 /dev/null |   27 ---------------------------
 1 files changed, 27 deletions(-)

diff -L arch/um/include/umn.h -puN arch/um/include/umn.h~uml-delete-unused-header-umnh /dev/null
--- 25/arch/um/include/umn.h
+++ /dev/null	2003-09-15 06:40:47.000000000 -0700
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
