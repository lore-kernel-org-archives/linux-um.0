Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DHSRg-0004Zi-Qe for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Apr 2005 12:08:44 -0800
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DHSRg-0000w1-29 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Apr 2005 12:08:44 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050401200547.ED17CA8A2@zion>
Subject: [uml-devel] [patch 1/1] uml: fix compilation for __CHOOSE_MODE
	addition
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
Date: Fri, 01 Apr 2005 22:05:46 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I had added the __CHOOSE_MODE syntax to fix some warnings with newer GCC's in
the uml-fix-cond-expr-as-lvalues-warning patch.

Here is the update from the version I sent to make it work also when only one
mode (TT or SKAS) is enabled.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/choose-mode.h |   27 ++++++++---------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff -puN arch/um/include/choose-mode.h~uml-fix-cond-expr-as-lvalues-rediffed arch/um/include/choose-mode.h
--- linux-2.6.11/arch/um/include/choose-mode.h~uml-fix-cond-expr-as-lvalues-rediffed	2005-04-01 21:48:45.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/include/choose-mode.h	2005-04-01 21:50:16.000000000 +0200
@@ -11,6 +11,13 @@
 #if defined(UML_CONFIG_MODE_TT) && defined(UML_CONFIG_MODE_SKAS)
 #define CHOOSE_MODE(tt, skas) (mode_tt ? (tt) : (skas))
 
+extern int mode_tt;
+static inline void *__choose_mode(void *tt, void *skas) {
+	return mode_tt ? tt : skas;
+}
+
+#define __CHOOSE_MODE(tt, skas) (*( (typeof(tt) *) __choose_mode(&(tt), &(skas))))
+
 #elif defined(UML_CONFIG_MODE_SKAS)
 #define CHOOSE_MODE(tt, skas) (skas)
 
@@ -21,22 +28,8 @@
 #define CHOOSE_MODE_PROC(tt, skas, args...) \
 	CHOOSE_MODE(tt(args), skas(args))
 
-extern int mode_tt;
-static inline void *__choose_mode(void *tt, void *skas) {
-	return mode_tt ? tt : skas;
-}
-
-#define __CHOOSE_MODE(tt, skas) (*( (typeof(tt) *) __choose_mode(&(tt), &(skas))))
-
+#ifndef __CHOOSE_MODE
+#define __CHOOSE_MODE(tt, skas) CHOOSE_MODE(tt, skas)
 #endif
 
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
+#endif
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
