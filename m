Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOh44-0003WA-5D	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:42:32 -0700
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EOh44-0003aX-Ql	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:42:34 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051009193745.26019.3947.stgit@zion.home.lan>
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
References: <200510092118.21032.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 5/6] uml: cleanup byte order macros for COW driver
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
Date: Sun, 09 Oct 2005 21:37:45 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

After restoring the existing code, make it work also when included in
kernelspace code (which isn't currently the case, but at least this will prevent
people from "fixing" it as just happened).
Whitespace is fixed in next patch - it cluttered the diff too much.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow.h      |   27 ++++++++++++++++++++++++++-
 arch/um/drivers/cow_user.c |    1 -
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -3,6 +3,26 @@
 
 #include <asm/types.h>
 
+#if defined(__KERNEL__)
+
+# include <asm/byteorder.h>
+
+# if defined(__BIG_ENDIAN)
+#	define ntohll(x) (x)
+#	define htonll(x) (x)
+# elif defined(__LITTLE_ENDIAN)
+#	define ntohll(x)  be64_to_cpu(x)
+#	define htonll(x)  cpu_to_be64(x)
+# else
+#	error "Could not determine byte order"
+# endif
+
+#else
+/* For the definition of ntohl, htonl and __BYTE_ORDER */
+#include <endian.h>
+#include <netinet/in.h>
+#if defined(__BYTE_ORDER)
+
 #if __BYTE_ORDER == __BIG_ENDIAN
 # define ntohll(x) (x)
 # define htonll(x) (x)
@@ -10,8 +30,13 @@
 # define ntohll(x)  bswap_64(x)
 # define htonll(x)  bswap_64(x)
 #else
-#error "__BYTE_ORDER not defined"
+# error "Could not determine byte order: __BYTE_ORDER uncorrectly defined"
+#endif
+
+#else  /* ! defined(__BYTE_ORDER) */
+#	error "Could not determine byte order: __BYTE_ORDER not defined"
 #endif
+#endif /* ! defined(__KERNEL__) */
 
 extern int init_cow_file(int fd, char *cow_file, char *backing_file,
 			 int sectorsize, int alignment, int *bitmap_offset_out,
diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -9,7 +9,6 @@
 #include <sys/time.h>
 #include <sys/param.h>
 #include <sys/user.h>
-#include <netinet/in.h>
 
 #include "os.h"
 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
