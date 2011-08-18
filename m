Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7uf-0002vl-6i
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:57 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7ue-0004uF-EL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:57 +0000
Date: Thu, 18 Aug 2011 20:05:49 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7uX-0007kB-JX@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 41/91] um: merge skas_ptrace.h 32/64bit
	variants
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/sys-x86/shared/sysdep/skas_ptrace.h    |   25 ++++++++++++++++++++---
 arch/um/sys-x86/shared/sysdep/skas_ptrace_32.h |   22 ---------------------
 arch/um/sys-x86/shared/sysdep/skas_ptrace_64.h |   22 ---------------------
 3 files changed, 21 insertions(+), 48 deletions(-)
 delete mode 100644 arch/um/sys-x86/shared/sysdep/skas_ptrace_32.h
 delete mode 100644 arch/um/sys-x86/shared/sysdep/skas_ptrace_64.h

diff --git a/arch/um/sys-x86/shared/sysdep/skas_ptrace.h b/arch/um/sys-x86/shared/sysdep/skas_ptrace.h
index e63b575..453febe 100644
--- a/arch/um/sys-x86/shared/sysdep/skas_ptrace.h
+++ b/arch/um/sys-x86/shared/sysdep/skas_ptrace.h
@@ -1,5 +1,22 @@
-#ifdef __i386__
-#include "skas_ptrace_32.h"
-#else
-#include "skas_ptrace_64.h"
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_X86_SKAS_PTRACE_H
+#define __SYSDEP_X86_SKAS_PTRACE_H
+
+struct ptrace_faultinfo {
+        int is_write;
+        unsigned long addr;
+};
+
+struct ptrace_ldt {
+        int func;
+        void *ptr;
+        unsigned long bytecount;
+};
+
+#define PTRACE_LDT 54
+
 #endif
diff --git a/arch/um/sys-x86/shared/sysdep/skas_ptrace_32.h b/arch/um/sys-x86/shared/sysdep/skas_ptrace_32.h
deleted file mode 100644
index e27b8a7..0000000
--- a/arch/um/sys-x86/shared/sysdep/skas_ptrace_32.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYSDEP_I386_SKAS_PTRACE_H
-#define __SYSDEP_I386_SKAS_PTRACE_H
-
-struct ptrace_faultinfo {
-        int is_write;
-        unsigned long addr;
-};
-
-struct ptrace_ldt {
-        int func;
-        void *ptr;
-        unsigned long bytecount;
-};
-
-#define PTRACE_LDT 54
-
-#endif
diff --git a/arch/um/sys-x86/shared/sysdep/skas_ptrace_64.h b/arch/um/sys-x86/shared/sysdep/skas_ptrace_64.h
deleted file mode 100644
index 95db4be7..0000000
--- a/arch/um/sys-x86/shared/sysdep/skas_ptrace_64.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYSDEP_X86_64_SKAS_PTRACE_H
-#define __SYSDEP_X86_64_SKAS_PTRACE_H
-
-struct ptrace_faultinfo {
-        int is_write;
-        unsigned long addr;
-};
-
-struct ptrace_ldt {
-        int func;
-        void *ptr;
-        unsigned long bytecount;
-};
-
-#define PTRACE_LDT 54
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

