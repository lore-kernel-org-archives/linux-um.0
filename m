Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwr-005Vi8-DV
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:02:08 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 10/27] um: Always inline stub functions
Date: Wed,  3 Mar 2021 16:55:06 +0100
Message-Id: <20210303155523.124277-11-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
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
Cc: Benjamin Berg <benjamin@sipsolutions.net>

The stub executable page is remapped to a different location in the
userland process. As these functions may be used by the stub, they
really need to be always inlined rather than permitting the compiler to
emit a function.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/shared/sysdep/stub_32.h | 21 +++++++++++----------
 arch/x86/um/shared/sysdep/stub_64.h | 15 ++++++++-------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index c3891c1ada26..02511d046404 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -12,7 +12,7 @@
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> UM_KERN_PAGE_SHIFT)
 
-static inline long stub_syscall0(long syscall)
+static __always_inline long stub_syscall0(long syscall)
 {
 	long ret;
 
@@ -21,7 +21,7 @@ static inline long stub_syscall0(long syscall)
 	return ret;
 }
 
-static inline long stub_syscall1(long syscall, long arg1)
+static __always_inline long stub_syscall1(long syscall, long arg1)
 {
 	long ret;
 
@@ -30,7 +30,7 @@ static inline long stub_syscall1(long syscall, long arg1)
 	return ret;
 }
 
-static inline long stub_syscall2(long syscall, long arg1, long arg2)
+static __always_inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
@@ -40,7 +40,8 @@ static inline long stub_syscall2(long syscall, long arg1, long arg2)
 	return ret;
 }
 
-static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
+static __always_inline long stub_syscall3(long syscall, long arg1, long arg2,
+					  long arg3)
 {
 	long ret;
 
@@ -50,8 +51,8 @@ static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
 	return ret;
 }
 
-static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
-				 long arg4)
+static __always_inline long stub_syscall4(long syscall, long arg1, long arg2,
+					  long arg3, long arg4)
 {
 	long ret;
 
@@ -61,8 +62,8 @@ static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 	return ret;
 }
 
-static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5)
+static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
+					  long arg3, long arg4, long arg5)
 {
 	long ret;
 
@@ -72,12 +73,12 @@ static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
 	return ret;
 }
 
-static inline void trap_myself(void)
+static __always_inline void trap_myself(void)
 {
 	__asm("int3");
 }
 
-static void inline remap_stack_and_trap(void)
+static __always_inline void remap_stack_and_trap(void)
 {
 	__asm__ volatile (
 		"movl %%esp,%%ebx ;"
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 6e2626b77a2e..871c770fc44b 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -15,7 +15,7 @@
 #define __syscall_clobber "r11","rcx","memory"
 #define __syscall "syscall"
 
-static inline long stub_syscall0(long syscall)
+static __always_inline long stub_syscall0(long syscall)
 {
 	long ret;
 
@@ -26,7 +26,7 @@ static inline long stub_syscall0(long syscall)
 	return ret;
 }
 
-static inline long stub_syscall2(long syscall, long arg1, long arg2)
+static __always_inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
@@ -37,7 +37,8 @@ static inline long stub_syscall2(long syscall, long arg1, long arg2)
 	return ret;
 }
 
-static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
+static __always_inline long stub_syscall3(long syscall, long arg1, long arg2,
+					  long arg3)
 {
 	long ret;
 
@@ -63,8 +64,8 @@ static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 	return ret;
 }
 
-static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5)
+static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
+					  long arg3, long arg4, long arg5)
 {
 	long ret;
 
@@ -77,12 +78,12 @@ static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
 	return ret;
 }
 
-static inline void trap_myself(void)
+static __always_inline void trap_myself(void)
 {
 	__asm("int3");
 }
 
-static inline void remap_stack_and_trap(void)
+static __always_inline void remap_stack_and_trap(void)
 {
 	__asm__ volatile (
 		"movq %0,%%rax ;"
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

