Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWqt-0004ix-3y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:51 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWqq-0004Kl-NJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:51 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231757.63EB155C8B@zion.localdomain>
Subject: [uml-devel] [patch 18/20] uml: clear errno in CATCH_EINTR
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
Date: Thu, 04 Nov 2004 00:17:57 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


To avoid silly messages coming out during debugging or when things break,
after that we've read in CATCH_EINTR that errno == EINTR, clear it, so that
it's 0 in next iteration.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/include/user_util.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/include/user_util.h~uml-clear-errno-in-CATCH_EINTR arch/um/include/user_util.h
--- vanilla-linux-2.6.9/arch/um/include/user_util.h~uml-clear-errno-in-CATCH_EINTR	2004-11-03 23:30:34.178063672 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/user_util.h	2004-11-03 23:30:34.181063216 +0100
@@ -8,7 +8,7 @@
 
 #include "sysdep/ptrace.h"
 
-#define CATCH_EINTR(expr) while (((expr) < 0) && (errno == EINTR))
+#define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
 
 extern int mode_tt;
 
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
