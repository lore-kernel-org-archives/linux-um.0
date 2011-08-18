Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7up-0007au-6i
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:06:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7uo-0002OR-Cx
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:06:07 +0000
Date: Thu, 18 Aug 2011 20:05:59 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7uh-0007kR-Jk@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 42/91] um: merge kernel_offsets_*.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/sys-x86/shared/sysdep/kernel-offsets.h    |   26 +++++++++++++++++----
 arch/um/sys-x86/shared/sysdep/kernel-offsets_32.h |   21 -----------------
 arch/um/sys-x86/shared/sysdep/kernel-offsets_64.h |   23 ------------------
 3 files changed, 21 insertions(+), 49 deletions(-)
 delete mode 100644 arch/um/sys-x86/shared/sysdep/kernel-offsets_32.h
 delete mode 100644 arch/um/sys-x86/shared/sysdep/kernel-offsets_64.h

diff --git a/arch/um/sys-x86/shared/sysdep/kernel-offsets.h b/arch/um/sys-x86/shared/sysdep/kernel-offsets.h
index 346bc08..5868526 100644
--- a/arch/um/sys-x86/shared/sysdep/kernel-offsets.h
+++ b/arch/um/sys-x86/shared/sysdep/kernel-offsets.h
@@ -1,5 +1,21 @@
-#ifdef __i386__
-#include "kernel-offsets_32.h"
-#else
-#include "kernel-offsets_64.h"
-#endif
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/elf.h>
+#include <linux/crypto.h>
+#include <asm/mman.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define STR(x) #x
+#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " STR(val) " " #val: : )
+
+#define BLANK() asm volatile("\n->" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
+void foo(void)
+{
+#include <common-offsets.h>
+}
diff --git a/arch/um/sys-x86/shared/sysdep/kernel-offsets_32.h b/arch/um/sys-x86/shared/sysdep/kernel-offsets_32.h
deleted file mode 100644
index 5868526..0000000
--- a/arch/um/sys-x86/shared/sysdep/kernel-offsets_32.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/elf.h>
-#include <linux/crypto.h>
-#include <asm/mman.h>
-
-#define DEFINE(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define STR(x) #x
-#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " STR(val) " " #val: : )
-
-#define BLANK() asm volatile("\n->" : : )
-
-#define OFFSET(sym, str, mem) \
-	DEFINE(sym, offsetof(struct str, mem));
-
-void foo(void)
-{
-#include <common-offsets.h>
-}
diff --git a/arch/um/sys-x86/shared/sysdep/kernel-offsets_64.h b/arch/um/sys-x86/shared/sysdep/kernel-offsets_64.h
deleted file mode 100644
index a307237..0000000
--- a/arch/um/sys-x86/shared/sysdep/kernel-offsets_64.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/time.h>
-#include <linux/elf.h>
-#include <linux/crypto.h>
-#include <asm/page.h>
-#include <asm/mman.h>
-
-#define DEFINE(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define DEFINE_STR1(x) #x
-#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " DEFINE_STR1(val) " " #val: : )
-
-#define BLANK() asm volatile("\n->" : : )
-
-#define OFFSET(sym, str, mem) \
-	DEFINE(sym, offsetof(struct str, mem));
-
-void foo(void)
-{
-#include <common-offsets.h>
-}
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

