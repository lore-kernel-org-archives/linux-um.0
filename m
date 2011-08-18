Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7yD-00080J-SF
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:37 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7yD-0000Ia-3B
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:37 +0000
Date: Thu, 18 Aug 2011 20:09:29 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7y5-0007vu-Qa@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 63/91] um: merge host_ldt_{32,64}.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/um/shared/sysdep/host_ldt.h    |   38 ++++++++++++++++++++++++++++--
 arch/x86/um/shared/sysdep/host_ldt_32.h |   34 ---------------------------
 arch/x86/um/shared/sysdep/host_ldt_64.h |   38 -------------------------------
 3 files changed, 35 insertions(+), 75 deletions(-)
 delete mode 100644 arch/x86/um/shared/sysdep/host_ldt_32.h
 delete mode 100644 arch/x86/um/shared/sysdep/host_ldt_64.h

diff --git a/arch/x86/um/shared/sysdep/host_ldt.h b/arch/x86/um/shared/sysdep/host_ldt.h
index 94518b3..246ff7a 100644
--- a/arch/x86/um/shared/sysdep/host_ldt.h
+++ b/arch/x86/um/shared/sysdep/host_ldt.h
@@ -1,5 +1,37 @@
-#ifdef __i386__
-#include "host_ldt_32.h"
+#ifndef __ASM_HOST_LDT_H
+#define __ASM_HOST_LDT_H
+
+#include <asm/ldt.h>
+
+#define LDT_entry_a(info) \
+	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
+
+#define LDT_entry_b(info) \
+	(((info)->base_addr & 0xff000000) | \
+	(((info)->base_addr & 0x00ff0000) >> 16) | \
+	((info)->limit & 0xf0000) | \
+	(((info)->read_exec_only ^ 1) << 9) | \
+	((info)->contents << 10) | \
+	(((info)->seg_not_present ^ 1) << 15) | \
+	((info)->seg_32bit << 22) | \
+	((info)->limit_in_pages << 23) | \
+	((info)->useable << 20) | \
+	0x7000)
+
+#define _LDT_empty(info) (\
+	(info)->base_addr	== 0	&& \
+	(info)->limit		== 0	&& \
+	(info)->contents	== 0	&& \
+	(info)->read_exec_only	== 1	&& \
+	(info)->seg_32bit	== 0	&& \
+	(info)->limit_in_pages	== 0	&& \
+	(info)->seg_not_present	== 1	&& \
+	(info)->useable		== 0	)
+
+#ifdef CONFIG_X86_64
+#define LDT_empty(info) (_LDT_empty(info) && ((info)->lm == 0))
 #else
-#include "host_ldt_64.h"
+#define LDT_empty(info) (_LDT_empty(info))
+#endif
+
 #endif
diff --git a/arch/x86/um/shared/sysdep/host_ldt_32.h b/arch/x86/um/shared/sysdep/host_ldt_32.h
deleted file mode 100644
index 0953cc4..0000000
--- a/arch/x86/um/shared/sysdep/host_ldt_32.h
+++ /dev/null
@@ -1,34 +0,0 @@
-#ifndef __ASM_HOST_LDT_I386_H
-#define __ASM_HOST_LDT_I386_H
-
-#include <asm/ldt.h>
-
-/*
- * macros stolen from include/asm-i386/desc.h
- */
-#define LDT_entry_a(info) \
-	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
-
-#define LDT_entry_b(info) \
-	(((info)->base_addr & 0xff000000) | \
-	(((info)->base_addr & 0x00ff0000) >> 16) | \
-	((info)->limit & 0xf0000) | \
-	(((info)->read_exec_only ^ 1) << 9) | \
-	((info)->contents << 10) | \
-	(((info)->seg_not_present ^ 1) << 15) | \
-	((info)->seg_32bit << 22) | \
-	((info)->limit_in_pages << 23) | \
-	((info)->useable << 20) | \
-	0x7000)
-
-#define LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	)
-
-#endif
diff --git a/arch/x86/um/shared/sysdep/host_ldt_64.h b/arch/x86/um/shared/sysdep/host_ldt_64.h
deleted file mode 100644
index e8b1be1..0000000
--- a/arch/x86/um/shared/sysdep/host_ldt_64.h
+++ /dev/null
@@ -1,38 +0,0 @@
-#ifndef __ASM_HOST_LDT_X86_64_H
-#define __ASM_HOST_LDT_X86_64_H
-
-#include <asm/ldt.h>
-
-/*
- * macros stolen from include/asm-x86_64/desc.h
- */
-#define LDT_entry_a(info) \
-	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
-
-/* Don't allow setting of the lm bit. It is useless anyways because
- * 64bit system calls require __USER_CS. */
-#define LDT_entry_b(info) \
-	(((info)->base_addr & 0xff000000) | \
-	(((info)->base_addr & 0x00ff0000) >> 16) | \
-	((info)->limit & 0xf0000) | \
-	(((info)->read_exec_only ^ 1) << 9) | \
-	((info)->contents << 10) | \
-	(((info)->seg_not_present ^ 1) << 15) | \
-	((info)->seg_32bit << 22) | \
-	((info)->limit_in_pages << 23) | \
-	((info)->useable << 20) | \
-	/* ((info)->lm << 21) | */ \
-	0x7000)
-
-#define LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	&& \
-	(info)->lm              == 0)
-
-#endif
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

