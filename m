Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CE8ig-0003Yl-7k for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 08:56:18 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CE8iD-00027P-Ku for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 08:56:18 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041003134109.248FFCBF1@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml: fix get_user warning
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
Date: Sun, 03 Oct 2004 15:41:08 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Adds some more parenthesis for a macro arg to fix a warning (which was in
kernel/uid16.c).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/include/asm-um/uaccess.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-um/uaccess.h~uml-fix-get_user-warning include/asm-um/uaccess.h
--- linux-2.6.9-current/include/asm-um/uaccess.h~uml-fix-get_user-warning	2004-10-03 15:37:45.654671792 +0200
+++ linux-2.6.9-current-paolo/include/asm-um/uaccess.h	2004-10-03 15:37:45.657671336 +0200
@@ -55,7 +55,7 @@
 
 #define get_user(x, ptr) \
 ({ \
-        const __typeof__((*ptr)) *private_ptr = (ptr); \
+        const __typeof__((*(ptr))) *private_ptr = (ptr); \
         (access_ok(VERIFY_READ, private_ptr, sizeof(*private_ptr)) ? \
 	 __get_user(x, private_ptr) : ((x) = 0, -EFAULT)); \
 })
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
