Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7y3-0003Jg-ME
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:27 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7y2-00051g-Pc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:27 +0000
Date: Thu, 18 Aug 2011 20:09:19 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7xv-0007t6-QK@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 62/91] um: merge tls_{32,64}.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/um/shared/sysdep/tls.h    |   38 +++++++++++++++++++++++++++++++++--
 arch/x86/um/shared/sysdep/tls_32.h |   32 ------------------------------
 arch/x86/um/shared/sysdep/tls_64.h |   29 ---------------------------
 3 files changed, 35 insertions(+), 64 deletions(-)
 delete mode 100644 arch/x86/um/shared/sysdep/tls_32.h
 delete mode 100644 arch/x86/um/shared/sysdep/tls_64.h

diff --git a/arch/x86/um/shared/sysdep/tls.h b/arch/x86/um/shared/sysdep/tls.h
index 4d8f752..db2ae9c 100644
--- a/arch/x86/um/shared/sysdep/tls.h
+++ b/arch/x86/um/shared/sysdep/tls.h
@@ -1,5 +1,37 @@
+#ifndef _SYSDEP_TLS_H
+#define _SYSDEP_TLS_H
+
+# ifndef __KERNEL__
+
+/* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
+ * may be named user_desc (but in 2.4 and in header matching its API was named
+ * modify_ldt_ldt_s). */
+
+typedef struct um_dup_user_desc {
+	unsigned int  entry_number;
+	unsigned int  base_addr;
+	unsigned int  limit;
+	unsigned int  seg_32bit:1;
+	unsigned int  contents:2;
+	unsigned int  read_exec_only:1;
+	unsigned int  limit_in_pages:1;
+	unsigned int  seg_not_present:1;
+	unsigned int  useable:1;
+#ifdef __x86_64__
+	unsigned int  lm:1;
+#endif
+} user_desc_t;
+
+# else /* __KERNEL__ */
+
+#  include <ldt.h>
+typedef struct user_desc user_desc_t;
+
+# endif /* __KERNEL__ */
+
 #ifdef __i386__
-#include "tls_32.h"
-#else
-#include "tls_64.h"
+#define GDT_ENTRY_TLS_MIN_I386 6
+#define GDT_ENTRY_TLS_MIN_X86_64 12
 #endif
+
+#endif /* _SYSDEP_TLS_H */
diff --git a/arch/x86/um/shared/sysdep/tls_32.h b/arch/x86/um/shared/sysdep/tls_32.h
deleted file mode 100644
index 3455075..0000000
--- a/arch/x86/um/shared/sysdep/tls_32.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef _SYSDEP_TLS_H
-#define _SYSDEP_TLS_H
-
-# ifndef __KERNEL__
-
-/* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
- * may be named user_desc (but in 2.4 and in header matching its API was named
- * modify_ldt_ldt_s). */
-
-typedef struct um_dup_user_desc {
-	unsigned int  entry_number;
-	unsigned int  base_addr;
-	unsigned int  limit;
-	unsigned int  seg_32bit:1;
-	unsigned int  contents:2;
-	unsigned int  read_exec_only:1;
-	unsigned int  limit_in_pages:1;
-	unsigned int  seg_not_present:1;
-	unsigned int  useable:1;
-} user_desc_t;
-
-# else /* __KERNEL__ */
-
-#  include <ldt.h>
-typedef struct user_desc user_desc_t;
-
-# endif /* __KERNEL__ */
-
-#define GDT_ENTRY_TLS_MIN_I386 6
-#define GDT_ENTRY_TLS_MIN_X86_64 12
-
-#endif /* _SYSDEP_TLS_H */
diff --git a/arch/x86/um/shared/sysdep/tls_64.h b/arch/x86/um/shared/sysdep/tls_64.h
deleted file mode 100644
index 18c000d..0000000
--- a/arch/x86/um/shared/sysdep/tls_64.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef _SYSDEP_TLS_H
-#define _SYSDEP_TLS_H
-
-# ifndef __KERNEL__
-
-/* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
- * may be named user_desc (but in 2.4 and in header matching its API was named
- * modify_ldt_ldt_s). */
-
-typedef struct um_dup_user_desc {
-	unsigned int  entry_number;
-	unsigned int  base_addr;
-	unsigned int  limit;
-	unsigned int  seg_32bit:1;
-	unsigned int  contents:2;
-	unsigned int  read_exec_only:1;
-	unsigned int  limit_in_pages:1;
-	unsigned int  seg_not_present:1;
-	unsigned int  useable:1;
-	unsigned int  lm:1;
-} user_desc_t;
-
-# else /* __KERNEL__ */
-
-#  include <ldt.h>
-typedef struct user_desc user_desc_t;
-
-# endif /* __KERNEL__ */
-#endif /* _SYSDEP_TLS_H */
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

