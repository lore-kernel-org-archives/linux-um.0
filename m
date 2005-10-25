Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUX0q-00051j-G2	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:11:20 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUX0p-0000Yu-4L
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:11:20 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051025221229.21106.22616.stgit@zion.home.lan>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 3/6] uml: remove old UM_FASTCALL, and make the
	thing work again
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
Date: Wed, 26 Oct 2005 00:12:30 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This was used in the old dark age of 2.4, ARCH_CFLAGS doesn't work any more
since some time, and UM_FASTCALL was never used in 2.6.

Instead, reintroduce the thing more properly now, directly in
include/asm-um/linkage.h.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-i386    |    4 ----
 include/asm-um/linkage.h |    8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -29,10 +29,6 @@ endif
 
 CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
 
-ifneq ($(CONFIG_GPROF),y)
-ARCH_CFLAGS += -DUM_FASTCALL
-endif
-
 # First of all, tune CFLAGS for the specific CPU. This actually sets cflags-y.
 include $(srctree)/arch/i386/Makefile.cpu
 
diff --git a/include/asm-um/linkage.h b/include/asm-um/linkage.h
--- a/include/asm-um/linkage.h
+++ b/include/asm-um/linkage.h
@@ -3,4 +3,12 @@
 
 #include "asm/arch/linkage.h"
 
+#include <linux/config.h>
+
+/* <linux/linkage.h> will pick sane defaults */
+#ifdef CONFIG_GPROF
+#undef FASTCALL
+#undef fastcall
+#endif
+
 #endif



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
