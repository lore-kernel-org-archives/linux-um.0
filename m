Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GoR9t-00054L-UU for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 13:03:30 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user54890)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GoR9s-0001Sq-Sz
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 13:03:29 -0800
From: Nix <nix@esperi.org.uk>
Date: Sun, 26 Nov 2006 21:03:26 +0000
Message-ID: <87wt5h9azl.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [uml-devel] PATCH [02/03]: eliminate skas_ptrace.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade@yahoo.it

This diff removes references to the conflicting-with-kernel-headers
skas_ptrace.h, and moves skas_ptrace.h into the um header
tree. There are still some trees (PPC, IA64) with a copy of a
skas_ptrace.h left and without ptrace-skas.h broken off from
ptrace.h: these may be broken by this change, but I can't test
them so I can't tell.

Signed-off-by: Nick Alcock <nix@esperi.org.uk>

 arch/um/include/sysdep-i386/skas_ptrace.h   |   22 --------------------
 arch/um/include/sysdep-x86_64/skas_ptrace.h |   22 --------------------
 arch/um/kernel/ptrace.c                     |    2 +-
 arch/um/os-Linux/process.c                  |    2 +-
 arch/um/os-Linux/skas/process.c             |    2 +-
 arch/um/os-Linux/start_up.c                 |    2 +-
 arch/um/sys-i386/ldt.c                      |    2 +-
 include/asm-i386/Kbuild                     |    1 +
 include/asm-i386/ptrace-skas.h              |   29 +++++++++++++++++++++++++++
 include/asm-um/ptrace-skas.h                |   29 +++++++++++++++++++++++++++
 include/asm-x86_64/Kbuild                   |    1 +
 include/asm-x86_64/ptrace-skas.h            |   27 +++++++++++++++++++++++++
 include/asm-x86_64/ptrace.h                 |    2 ++
 13 files changed, 94 insertions(+), 49 deletions(-)

diff --git a/arch/um/include/sysdep-i386/skas_ptrace.h b/arch/um/include/sysdep-i386/skas_ptrace.h
deleted file mode 100644
index e27b8a7..0000000
--- a/arch/um/include/sysdep-i386/skas_ptrace.h
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
diff --git a/arch/um/include/sysdep-x86_64/skas_ptrace.h b/arch/um/include/sysdep-x86_64/skas_ptrace.h
deleted file mode 100644
index 95db4be..0000000
--- a/arch/um/include/sysdep-x86_64/skas_ptrace.h
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
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 9a77fb3..8c003e5 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -14,9 +14,9 @@
 #include "linux/proc_mm.h"
 #endif
 #include "asm/ptrace.h"
+#include "asm/ptrace-skas.h"
 #include "asm/uaccess.h"
 #include "kern_util.h"
-#include "skas_ptrace.h"
 #include "sysdep/ptrace.h"
 
 static inline void set_singlestepping(struct task_struct *child, int on)
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index c8bf772..1ae1795 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -12,6 +12,7 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <asm/ptrace-skas.h>
 #include "ptrace_user.h"
 #include "os.h"
 #include "user.h"
@@ -20,7 +21,6 @@
 #include "irq_user.h"
 #include "kern_util.h"
 #include "longjmp.h"
-#include "skas_ptrace.h"
 #include "kern_constants.h"
 
 #define ARBITRARY_ADDR -1
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 7baf90f..4cf9387 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -17,6 +17,7 @@
 #include <sys/time.h>
 #include <asm/unistd.h>
 #include <asm/types.h>
+#include <asm/ptrace-skas.h>
 #include "user.h"
 #include "sysdep/ptrace.h"
 #include "user_util.h"
@@ -28,7 +29,6 @@
 #include "sysdep/stub.h"
 #include "os.h"
 #include "proc_mm.h"
-#include "skas_ptrace.h"
 #include "chan_user.h"
 #include "registers.h"
 #include "mem.h"
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 5031485..46c2410 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -40,7 +40,7 @@
 
 #ifdef UML_CONFIG_MODE_SKAS
 #include "skas.h"
-#include "skas_ptrace.h"
+#include <asm/ptrace-skas.h>
 #include "registers.h"
 #endif
 
diff --git a/arch/um/sys-i386/ldt.c b/arch/um/sys-i386/ldt.c
index fe0877b..b50c8b5 100644
--- a/arch/um/sys-i386/ldt.c
+++ b/arch/um/sys-i386/ldt.c
@@ -87,7 +87,7 @@ out:
 #ifdef CONFIG_MODE_SKAS
 
 #include "skas.h"
-#include "skas_ptrace.h"
+#include "asm/ptrace-skas.h"
 #include "asm/mmu_context.h"
 #include "proc_mm.h"
 
diff --git a/include/asm-i386/Kbuild b/include/asm-i386/Kbuild
index b75a348..03f1fa1 100644
--- a/include/asm-i386/Kbuild
+++ b/include/asm-i386/Kbuild
@@ -8,3 +8,4 @@ header-y += ucontext.h
 unifdef-y += mtrr.h
 unifdef-y += setup.h
 unifdef-y += vm86.h
+unifdef-y += ptrace-skas.h
diff --git a/include/asm-i386/ptrace-skas.h b/include/asm-i386/ptrace-skas.h
new file mode 100644
index 0000000..6842650
--- /dev/null
+++ b/include/asm-i386/ptrace-skas.h
@@ -0,0 +1,29 @@
+#ifndef _I386_PTRACE_SKAS_H
+#define _I386_PTRACE_SKAS_H
+
+/*For SKAS3 support.*/
+
+#define PTRACE_FAULTINFO	  52
+/* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
+#define PTRACE_LDT		  54
+#define PTRACE_SWITCH_MM 	  55
+#define PTRACE_EX_FAULTINFO	  56
+
+struct ptrace_faultinfo {
+	int is_write;
+	unsigned long addr;
+};
+
+struct ptrace_ex_faultinfo {
+	int is_write;
+	unsigned long addr;
+	int trap_no;
+};
+
+struct ptrace_ldt {
+	int func;
+  	void *ptr;
+	unsigned long bytecount;
+};
+
+#endif
diff --git a/include/asm-um/ptrace-skas.h b/include/asm-um/ptrace-skas.h
new file mode 100644
index 0000000..2c54ac2
--- /dev/null
+++ b/include/asm-um/ptrace-skas.h
@@ -0,0 +1,29 @@
+#ifndef _UM_PTRACE_SKAS_H
+#define _UM_PTRACE_SKAS_H
+
+/*For SKAS3 support.*/
+
+#define PTRACE_FAULTINFO	  52
+/* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
+#define PTRACE_LDT		  54
+#define PTRACE_SWITCH_MM 	  55
+#define PTRACE_EX_FAULTINFO	  56
+
+struct ptrace_faultinfo {
+	int is_write;
+	unsigned long addr;
+};
+
+struct ptrace_ex_faultinfo {
+	int is_write;
+	unsigned long addr;
+	int trap_no;
+};
+
+struct ptrace_ldt {
+	int func;
+  	void *ptr;
+	unsigned long bytecount;
+};
+
+#endif
diff --git a/include/asm-x86_64/Kbuild b/include/asm-x86_64/Kbuild
index 40f2f13..d49d004 100644
--- a/include/asm-x86_64/Kbuild
+++ b/include/asm-x86_64/Kbuild
@@ -19,3 +19,4 @@ header-y += vsyscall32.h
 unifdef-y += mce.h
 unifdef-y += mtrr.h
 unifdef-y += vsyscall.h
+unifdef-y += ptrace-skas.h
diff --git a/include/asm-x86_64/ptrace-skas.h b/include/asm-x86_64/ptrace-skas.h
new file mode 100644
index 0000000..7f8ac4b
--- /dev/null
+++ b/include/asm-x86_64/ptrace-skas.h
@@ -0,0 +1,27 @@
+#ifndef _X86_64_PTRACE_SKAS_H
+#define _X86_64_PTRACE_SKAS_H
+
+#define PTRACE_FAULTINFO 52
+/* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
+#define PTRACE_LDT 54
+#define PTRACE_SWITCH_MM 55
+#define PTRACE_EX_FAULTINFO	  56
+
+struct ptrace_faultinfo {
+	int is_write;
+	unsigned long addr;
+};
+
+struct ptrace_ex_faultinfo {
+	int is_write;
+	unsigned long addr;
+	int trap_no;
+};
+
+struct ptrace_ldt {
+	int func;
+  	void *ptr;
+	unsigned long bytecount;
+};
+
+#endif
diff --git a/include/asm-x86_64/ptrace.h b/include/asm-x86_64/ptrace.h
index ca6f15f..171bfbd 100644
--- a/include/asm-x86_64/ptrace.h
+++ b/include/asm-x86_64/ptrace.h
@@ -66,6 +66,8 @@ struct pt_regs {
 
 #endif
 
+#include <asm/ptrace-skas.h>
+
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
 #define PTRACE_GETREGS            12
 #define PTRACE_SETREGS            13


-- 
`The main high-level difference between Emacs and (say) UNIX, Windows,
 or BeOS... is that Emacs boots quicker.' --- PdS

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
