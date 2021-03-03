Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwF-005VXv-O9
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:29 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 13/27] um: Mark 32bit syscall helpers as clobbering memory
Date: Wed,  3 Mar 2021 16:55:09 +0100
Message-Id: <20210303155523.124277-14-benjamin@sipsolutions.net>
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

The 64bit helper are marked to clobber the memory, but the 32bit ones
are not. Add the appropriate clobber to the 32bit helper routines so
that the compiler cannot do invalid optimizations.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/shared/sysdep/stub_32.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 02511d046404..d7284dd4a850 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -16,7 +16,8 @@ static __always_inline long stub_syscall0(long syscall)
 {
 	long ret;
 
-	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall));
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall)
+			: "memory");
 
 	return ret;
 }
@@ -25,7 +26,8 @@ static __always_inline long stub_syscall1(long syscall, long arg1)
 {
 	long ret;
 
-	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1));
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1)
+			: "memory");
 
 	return ret;
 }
@@ -35,7 +37,8 @@ static __always_inline long stub_syscall2(long syscall, long arg1, long arg2)
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2));
+			"c" (arg2)
+			: "memory");
 
 	return ret;
 }
@@ -46,7 +49,8 @@ static __always_inline long stub_syscall3(long syscall, long arg1, long arg2,
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2), "d" (arg3));
+			"c" (arg2), "d" (arg3)
+			: "memory");
 
 	return ret;
 }
@@ -57,7 +61,8 @@ static __always_inline long stub_syscall4(long syscall, long arg1, long arg2,
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2), "d" (arg3), "S" (arg4));
+			"c" (arg2), "d" (arg3), "S" (arg4)
+			: "memory");
 
 	return ret;
 }
@@ -68,7 +73,8 @@ static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5));
+			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
+			: "memory");
 
 	return ret;
 }
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

