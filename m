Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Yb6sp-0007ZL-91
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:35 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yb6sn-00087L-AF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:35 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 26 Mar 2015 13:27:13 +0100
Message-Id: <1427372838-16605-2-git-send-email-richard@nod.at>
In-Reply-To: <1427372838-16605-1-git-send-email-richard@nod.at>
References: <1427372838-16605-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 2/7] um: Remove ia64 cruft
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

That code is a relict from the early days of UML.
ia64 support was never completed nor worked.
Let's rip it out.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Makefile-ia64                 |  1 -
 arch/um/sys-ia64/Makefile             | 11 -----------
 arch/um/sys-ia64/sysdep/ptrace.h      | 16 ----------------
 arch/um/sys-ia64/sysdep/sigcontext.h  | 10 ----------
 arch/um/sys-ia64/sysdep/skas_ptrace.h | 22 ----------------------
 arch/um/sys-ia64/sysdep/syscalls.h    | 10 ----------
 6 files changed, 70 deletions(-)
 delete mode 100644 arch/um/Makefile-ia64
 delete mode 100644 arch/um/sys-ia64/Makefile
 delete mode 100644 arch/um/sys-ia64/sysdep/ptrace.h
 delete mode 100644 arch/um/sys-ia64/sysdep/sigcontext.h
 delete mode 100644 arch/um/sys-ia64/sysdep/skas_ptrace.h
 delete mode 100644 arch/um/sys-ia64/sysdep/syscalls.h

diff --git a/arch/um/Makefile-ia64 b/arch/um/Makefile-ia64
deleted file mode 100644
index f84dc23..0000000
--- a/arch/um/Makefile-ia64
+++ /dev/null
@@ -1 +0,0 @@
-START_ADDR = 0x1000000000000000
diff --git a/arch/um/sys-ia64/Makefile b/arch/um/sys-ia64/Makefile
deleted file mode 100644
index d02f4c2..0000000
--- a/arch/um/sys-ia64/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-OBJ = built-in.o
-
-OBJS =
-
-all: $(OBJ)
-
-$(OBJ): $(OBJS)
-	rm -f $@
-	$(LD) $(LINKFLAGS) --start-group $^ --end-group -o $@
-
-clean-files := $(OBJS) link.ld
diff --git a/arch/um/sys-ia64/sysdep/ptrace.h b/arch/um/sys-ia64/sysdep/ptrace.h
deleted file mode 100644
index 0f0f4e6..0000000
--- a/arch/um/sys-ia64/sysdep/ptrace.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYSDEP_IA64_PTRACE_H
-#define __SYSDEP_IA64_PTRACE_H
-
-struct sys_pt_regs {
-  int foo;
-};
-
-#define EMPTY_REGS { 0 }
-
-#endif
-
diff --git a/arch/um/sys-ia64/sysdep/sigcontext.h b/arch/um/sys-ia64/sysdep/sigcontext.h
deleted file mode 100644
index 76b4316..0000000
--- a/arch/um/sys-ia64/sysdep/sigcontext.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYSDEP_IA64_SIGCONTEXT_H
-#define __SYSDEP_IA64_SIGCONTEXT_H
-
-#endif
-
diff --git a/arch/um/sys-ia64/sysdep/skas_ptrace.h b/arch/um/sys-ia64/sysdep/skas_ptrace.h
deleted file mode 100644
index 25a38e7..0000000
--- a/arch/um/sys-ia64/sysdep/skas_ptrace.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYSDEP_IA64_SKAS_PTRACE_H
-#define __SYSDEP_IA64_SKAS_PTRACE_H
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
diff --git a/arch/um/sys-ia64/sysdep/syscalls.h b/arch/um/sys-ia64/sysdep/syscalls.h
deleted file mode 100644
index 5f6700c..0000000
--- a/arch/um/sys-ia64/sysdep/syscalls.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYSDEP_IA64_SYSCALLS_H
-#define __SYSDEP_IA64_SYSCALLS_H
-
-#endif
-
-- 
1.8.4.5


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

