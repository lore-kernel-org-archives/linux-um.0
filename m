Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCzF-0001ba-RM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:37 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CpCzD-0001PL-DP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:37 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113210053.ED4D0B0F7@zion>
Subject: [uml-devel] [patch 03/11] uml: fix some UML own initcall macros
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
Date: Thu, 13 Jan 2005 22:00:53 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


UML has his own initcall mechanism to handle his special userspace
initialization (they are called in different moments, so they are indeed
different).

It must also duplicate some definition for the benefit of userspace code - but
those definition weren't in sync with the main code. Also, the UML own macros
missed __attribute_used__. Both problems are fixed by this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/init.h |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff -puN arch/um/include/init.h~uml-init_h-fix arch/um/include/init.h
--- linux-2.6.11/arch/um/include/init.h~uml-init_h-fix	2005-01-13 02:55:49.051805472 +0100
+++ linux-2.6.11-paolo/arch/um/include/init.h	2005-01-13 02:55:49.088799848 +0100
@@ -40,9 +40,18 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-#define __init          __attribute__ ((__section__ (".text.init")))
-#define __exit          __attribute__ ((unused, __section__(".text.exit")))
-#define __initdata      __attribute__ ((__section__ (".data.init")))
+/* These are for everybody (although not all archs will actually
+   discard it in modules) */
+#define __init		__attribute__ ((__section__ (".init.text")))
+#define __initdata	__attribute__ ((__section__ (".init.data")))
+#define __exitdata	__attribute__ ((__section__(".exit.data")))
+#define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
+
+#ifdef MODULE
+#define __exit		__attribute__ ((__section__(".exit.text")))
+#else
+#define __exit		__attribute_used__ __attribute__ ((__section__(".exit.text")))
+#endif
 
 #endif
 
@@ -94,11 +103,11 @@ extern struct uml_param __uml_setup_star
  * Mark functions and data as being only used at initialization
  * or exit time.
  */
-#define __uml_init_setup	__attribute__ ((unused,__section__ (".uml.setup.init")))
-#define __uml_setup_help	__attribute__ ((unused,__section__ (".uml.help.init")))
-#define __uml_init_call		__attribute__ ((unused,__section__ (".uml.initcall.init")))
-#define __uml_postsetup_call	__attribute__ ((unused,__section__ (".uml.postsetup.init")))
-#define __uml_exit_call		__attribute__ ((unused,__section__ (".uml.exitcall.exit")))
+#define __uml_init_setup	__attribute_used__ __attribute__ ((__section__ (".uml.setup.init")))
+#define __uml_setup_help	__attribute_used__ __attribute__ ((__section__ (".uml.help.init")))
+#define __uml_init_call		__attribute_used__ __attribute__ ((__section__ (".uml.initcall.init")))
+#define __uml_postsetup_call	__attribute_used__ __attribute__ ((__section__ (".uml.postsetup.init")))
+#define __uml_exit_call		__attribute_used__ __attribute__ ((__section__ (".uml.exitcall.exit")))
 
 #endif /* _LINUX_UML_INIT_H */
 
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
