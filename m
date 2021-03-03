Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTvu-005VSr-8h
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:08 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 15/27] um: Add generic stub_syscall6 function
Date: Wed,  3 Mar 2021 16:55:11 +0100
Message-Id: <20210303155523.124277-16-benjamin@sipsolutions.net>
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

This function will be used by the new syscall handling code.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/shared/sysdep/stub_32.h | 22 ++++++++++++++++++++++
 arch/x86/um/shared/sysdep/stub_64.h | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index d7284dd4a850..3fb8559fe994 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -79,6 +79,28 @@ static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
 	return ret;
 }
 
+static __always_inline long stub_syscall6(long syscall, long arg1, long arg2,
+					  long arg3, long arg4, long arg5,
+					  long arg6)
+{
+	struct syscall_args {
+	  int ebx, ebp;
+	} args = { arg1, arg6 };
+	long ret;
+
+	__asm__ volatile ("pushl %%ebp;"
+			"movl 0x4(%%ebx),%%ebp;"
+			"movl (%%ebx),%%ebx;"
+			"int $0x80;"
+			"popl %%ebp"
+			: "=a" (ret)
+			: "0" (syscall), "b" (&args),
+			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
+			: "memory");
+
+	return ret;
+}
+
 static __always_inline void trap_myself(void)
 {
 	__asm("int3");
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 871c770fc44b..c41ae0462c8f 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -78,6 +78,22 @@ static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
 	return ret;
 }
 
+static __always_inline long stub_syscall6(long syscall, long arg1, long arg2,
+					  long arg3, long arg4, long arg5,
+					  long arg6)
+{
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; movq %7,%%r9 ; "
+		__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4), "g" (arg5), "g" (arg6)
+		: __syscall_clobber, "r10", "r8", "r9");
+
+	return ret;
+}
+
 static __always_inline void trap_myself(void)
 {
 	__asm("int3");
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

