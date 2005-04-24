Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPlk0-00054U-R7 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:22:00 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DPlk0-0003WW-17 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:22:00 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050424181010.78C2D55D03@zion>
Subject: [uml-devel] [patch 6/6] uml: move va_copy conditional def
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
Date: Sun, 24 Apr 2005 20:10:10 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


GCC 2.95 uses __va_copy instead of va_copy. Handle it inside compiler.h
instead of in a casual file, and avoid the risk that this breaks with a
newer compiler (which it could do).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/skas/uaccess.c |    4 ++--
 linux-2.6.12-paolo/include/linux/compiler-gcc2.h |    5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/skas/uaccess.c~uml-move-va-copy-conditional arch/um/kernel/skas/uaccess.c
--- linux-2.6.12/arch/um/kernel/skas/uaccess.c~uml-move-va-copy-conditional	2005-04-24 19:32:18.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/skas/uaccess.c	2005-04-24 19:32:18.000000000 +0200
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include "linux/compiler.h"
 #include "linux/stddef.h"
 #include "linux/kernel.h"
 #include "linux/string.h"
@@ -61,8 +62,7 @@ static void do_buffer_op(void *jmpbuf, v
 	void *arg;
 	int *res;
 
-	/* Some old gccs recognize __va_copy, but not va_copy */
-	__va_copy(args, *(va_list *)arg_ptr);
+	va_copy(args, *(va_list *)arg_ptr);
 	addr = va_arg(args, unsigned long);
 	len = va_arg(args, int);
 	is_write = va_arg(args, int);
diff -puN include/linux/compiler-gcc2.h~uml-move-va-copy-conditional include/linux/compiler-gcc2.h
--- linux-2.6.12/include/linux/compiler-gcc2.h~uml-move-va-copy-conditional	2005-04-24 19:32:18.000000000 +0200
+++ linux-2.6.12-paolo/include/linux/compiler-gcc2.h	2005-04-24 19:32:18.000000000 +0200
@@ -22,3 +22,8 @@
 # define __attribute_pure__	__attribute__((pure))
 # define __attribute_const__	__attribute__((__const__))
 #endif
+
+/* GCC 2.95.x/2.96 recognize __va_copy, but not va_copy. Actually later GCC's
+ * define both va_copy and __va_copy, but the latter may go away, so limit this
+ * to this header */
+#define va_copy			__va_copy
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
