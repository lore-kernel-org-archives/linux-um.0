Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Jaswinder Singh <jaswinder@infradead.org>
In-Reply-To: <1216597993.3679.144.camel@jaswinder.satnam>
References: <1216592500.3679.14.camel@jaswinder.satnam>
	<1216592798.3679.22.camel@jaswinder.satnam>
	<1216592879.3679.24.camel@jaswinder.satnam>
	<1216593035.3679.27.camel@jaswinder.satnam>
	<1216596035.3679.95.camel@jaswinder.satnam>
	<1216596106.3679.98.camel@jaswinder.satnam>
	<1216596325.3679.104.camel@jaswinder.satnam>
	<1216596669.3679.112.camel@jaswinder.satnam>
	<1216596749.3679.115.camel@jaswinder.satnam>
	<1216596835.3679.117.camel@jaswinder.satnam>
	<1216596932.3679.120.camel@jaswinder.satnam>
	<1216597066.3679.123.camel@jaswinder.satnam>
	<1216597151.3679.125.camel@jaswinder.satnam>
	<1216597237.3679.128.camel@jaswinder.satnam>
	<1216597352.3679.131.camel@jaswinder.satnam>
	<1216597566.3679.135.camel@jaswinder.satnam>
	<1216597856.3679.139.camel@jaswinder.satnam>
	<1216597923.3679.141.camel@jaswinder.satnam>
	<1216597993.3679.144.camel@jaswinder.satnam>
Date: Mon, 21 Jul 2008 05:24:27 +0530
Message-Id: <1216598067.3679.146.camel@jaswinder.satnam>
Mime-Version: 1.0
Subject: [uml-devel] [PATCH 19/22] um: Introducing asm/syscalls.h
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>, kernelnewbies <kernelnewbies@nl.linux.org>, David Woodhouse <dwmw2@infradead.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Declaring arch-dependent syscalls for um architecture

Signed-off-by: Jaswinder Singh <jaswinder@infradead.org>
---
 arch/um/kernel/exec.c     |    1 +
 arch/um/kernel/signal.c   |    3 +--
 arch/um/kernel/syscall.c  |    1 +
 include/asm-um/syscalls.h |   32 ++++++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index f5d7f45..cd9fa46 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -8,6 +8,7 @@
 #include "linux/smp_lock.h"
 #include "linux/ptrace.h"
 #include "linux/sched.h"
+#include "linux/syscalls.h"
 #include "asm/current.h"
 #include "asm/processor.h"
 #include "asm/uaccess.h"
diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index b0fce72..9a72afc 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -6,8 +6,7 @@
 #include <linux/module.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
-#include <asm/siginfo.h>
-#include <asm/signal.h>
+#include <linux/syscalls.h>
 #include <asm/unistd.h>
 #include "frame_kern.h"
 #include "kern_util.h"
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
index 128ee85..0c35194 100644
--- a/arch/um/kernel/syscall.c
+++ b/arch/um/kernel/syscall.c
@@ -8,6 +8,7 @@
 #include "linux/mm.h"
 #include "linux/sched.h"
 #include "linux/utsname.h"
+#include "linux/syscalls.h"
 #include "asm/current.h"
 #include "asm/mman.h"
 #include "asm/uaccess.h"
diff --git a/include/asm-um/syscalls.h b/include/asm-um/syscalls.h
index e69de29..2124282 100644
--- a/include/asm-um/syscalls.h
+++ b/include/asm-um/syscalls.h
@@ -0,0 +1,32 @@
+/*
+ * syscalls.h - Linux syscall interfaces (arch-specific)
+ *
+ * Copyright (c) 2008 Jaswinder Singh
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ *
+ * Please do not call me directly, include linux/syscalls.h
+ */
+
+#ifndef _ASM_UM_SYSCALLS_H
+#define _ASM_UM_SYSCALLS_H
+
+/* kernel/exec.c */
+long sys_execve(char __user *, char __user *__user *,
+		char __user * __user *);
+
+/* kernel/signal.c */
+long sys_sigsuspend(int, int, old_sigset_t);
+long sys_sigaltstack(const stack_t __user *, stack_t __user *);
+
+/* kernel/syscall.c */
+long sys_fork(void);
+long sys_vfork(void);
+long sys_mmap2(unsigned long, unsigned long, unsigned long,
+	       unsigned long, unsigned long, unsigned long);
+long old_mmap(unsigned long, unsigned long, unsigned long,
+	      unsigned long, unsigned long, unsigned long);
+long sys_uname(struct old_utsname __user *);
+
+#endif /* _ASM_UM_SYSCALLS_H */
-- 
1.5.5.1




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
