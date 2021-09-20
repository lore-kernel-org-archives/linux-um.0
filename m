Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuM-003BNG-8e
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:03 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuL-005yeD-1h
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 01/15] uml: trim unused junk from
 arch/x86/um/sys_call_table_*.c
Date: Mon, 20 Sep 2021 21:32:47 +0000
Message-Id: <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
In-Reply-To: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
References: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

a bunch of detritus there - definitions that are never expanded or
checked.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/um/sys_call_table_32.c |  4 ----
 arch/x86/um/sys_call_table_64.c | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 0575decb5e544..89df5d89d6640 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -9,8 +9,6 @@
 #include <linux/cache.h>
 #include <asm/syscall.h>
 
-#define __NO_STUBS
-
 /*
  * Below you can see, in terms of #define's, the differences between the x86-64
  * and the UML syscall table.
@@ -23,8 +21,6 @@
 #define sys_vm86old sys_ni_syscall
 #define sys_vm86 sys_ni_syscall
 
-#define old_mmap sys_old_mmap
-
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 
 #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 95725b5a41ac8..82b695ed23c41 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -9,8 +9,6 @@
 #include <linux/cache.h>
 #include <asm/syscall.h>
 
-#define __NO_STUBS
-
 /*
  * Below you can see, in terms of #define's, the differences between the x86-64
  * and the UML syscall table.
@@ -20,21 +18,9 @@
 #define sys_iopl sys_ni_syscall
 #define sys_ioperm sys_ni_syscall
 
-/*
- * The UML TLS problem. Note that x86_64 does not implement this, so the below
- * is needed only for the ia32 compatibility.
- */
-
 /* On UML we call it this way ("old" means it's not mmap2) */
 #define sys_mmap old_mmap
 
-#define stub_clone sys_clone
-#define stub_fork sys_fork
-#define stub_vfork sys_vfork
-#define stub_execve sys_execve
-#define stub_execveat sys_execveat
-#define stub_rt_sigreturn sys_rt_sigreturn
-
 #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
 
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

