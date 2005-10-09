Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOh3w-0003Vj-JO	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:42:24 -0700
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EOh3x-0003Xw-9g	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:42:27 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051009193753.26019.59186.stgit@zion.home.lan>
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
References: <200510092118.21032.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 6/6] uml: cleanup whitespace for COW driver
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
Date: Sun, 09 Oct 2005 21:37:53 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix whitespace - I split this off the previous patch for easier review.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -23,15 +23,15 @@
 #include <netinet/in.h>
 #if defined(__BYTE_ORDER)
 
-#if __BYTE_ORDER == __BIG_ENDIAN
-# define ntohll(x) (x)
-# define htonll(x) (x)
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
-# define ntohll(x)  bswap_64(x)
-# define htonll(x)  bswap_64(x)
-#else
-# error "Could not determine byte order: __BYTE_ORDER uncorrectly defined"
-#endif
+#  if __BYTE_ORDER == __BIG_ENDIAN
+#	define ntohll(x) (x)
+#	define htonll(x) (x)
+#  elif __BYTE_ORDER == __LITTLE_ENDIAN
+#	define ntohll(x)  bswap_64(x)
+#	define htonll(x)  bswap_64(x)
+#  else
+#	error "Could not determine byte order: __BYTE_ORDER uncorrectly defined"
+#  endif
 
 #else  /* ! defined(__BYTE_ORDER) */
 #	error "Could not determine byte order: __BYTE_ORDER not defined"



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
