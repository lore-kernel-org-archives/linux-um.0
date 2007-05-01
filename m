Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hix30-0000xF-Nv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 May 2007 11:25:58 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hix2z-0008Eo-T6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 May 2007 11:25:58 -0700
Date: Tue, 1 May 2007 14:21:58 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070501182158.GA8353@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/6] Create asm-x86_64/cmpxchg.h
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
To: akpm@osdl.org, Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This is the x86_64 movement of cmpxchg into its own header.  atomic.h
already included system.h, so this is changed to include cmpxchg.h.

This is purely cleanup - it's not fixing any warnings - so if the
x86_64 system.h isn't considered as cleanup-worthy as i386, then this
can be dropped.

It causes no noticable damage to the x86_64 build.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 include/asm-x86_64/atomic.h  |    2 
 include/asm-x86_64/cmpxchg.h |  134 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-x86_64/system.h  |  130 -----------------------------------------
 3 files changed, 136 insertions(+), 130 deletions(-)

Index: linux-2.6.21-mm/include/asm-x86_64/atomic.h
===================================================================
--- linux-2.6.21-mm.orig/include/asm-x86_64/atomic.h	2007-04-30 18:04:43.000000000 -0400
+++ linux-2.6.21-mm/include/asm-x86_64/atomic.h	2007-05-01 12:42:34.000000000 -0400
@@ -2,7 +2,7 @@
 #define __ARCH_X86_64_ATOMIC__
 
 #include <asm/alternative.h>
-#include <asm/system.h>
+#include <asm/cmpxchg.h>
 
 /* atomic_t should be 32 bit signed type */
 
Index: linux-2.6.21-mm/include/asm-x86_64/cmpxchg.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.21-mm/include/asm-x86_64/cmpxchg.h	2007-05-01 12:43:48.000000000 -0400
@@ -0,0 +1,134 @@
+#ifndef __ASM_CMPXCHG_H
+#define __ASM_CMPXCHG_H
+
+#include <asm/alternative.h> /* Provides LOCK_PREFIX */
+
+#define xchg(ptr,v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v),(ptr),sizeof(*(ptr))))
+
+#define __xg(x) ((volatile long *)(x))
+
+static inline void set_64bit(volatile unsigned long *ptr, unsigned long val)
+{
+	*ptr = val;
+}
+
+#define _set_64bit set_64bit
+
+/*
+ * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
+ * Note 2: xchg has side effect, so that attribute volatile is necessary,
+ *	  but generally the primitive is invalid, *ptr is output argument. --ANK
+ */
+static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
+{
+	switch (size) {
+		case 1:
+			__asm__ __volatile__("xchgb %b0,%1"
+				:"=q" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+		case 2:
+			__asm__ __volatile__("xchgw %w0,%1"
+				:"=r" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+		case 4:
+			__asm__ __volatile__("xchgl %k0,%1"
+				:"=r" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+		case 8:
+			__asm__ __volatile__("xchgq %0,%1"
+				:"=r" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+	}
+	return x;
+}
+
+/*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+
+#define __HAVE_ARCH_CMPXCHG 1
+
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+				      unsigned long new, int size)
+{
+	unsigned long prev;
+	switch (size) {
+	case 1:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 2:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 4:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %k1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 8:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgq %1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	}
+	return old;
+}
+
+static inline unsigned long __cmpxchg_local(volatile void *ptr,
+			unsigned long old, unsigned long new, int size)
+{
+	unsigned long prev;
+	switch (size) {
+	case 1:
+		__asm__ __volatile__("cmpxchgb %b1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 2:
+		__asm__ __volatile__("cmpxchgw %w1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 4:
+		__asm__ __volatile__("cmpxchgl %k1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 8:
+		__asm__ __volatile__("cmpxchgq %1,%2"
+				     : "=a"(prev)
+				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	}
+	return old;
+}
+
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
+#define cmpxchg_local(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
+
+#endif
Index: linux-2.6.21-mm/include/asm-x86_64/system.h
===================================================================
--- linux-2.6.21-mm.orig/include/asm-x86_64/system.h	2007-04-30 18:04:43.000000000 -0400
+++ linux-2.6.21-mm/include/asm-x86_64/system.h	2007-05-01 12:42:34.000000000 -0400
@@ -3,7 +3,7 @@
 
 #include <linux/kernel.h>
 #include <asm/segment.h>
-#include <asm/alternative.h>
+#include <asm/cmpxchg.h>
 
 #ifdef __KERNEL__
 
@@ -124,134 +124,6 @@ static inline void sched_cacheflush(void
 
 #define nop() __asm__ __volatile__ ("nop")
 
-#define xchg(ptr,v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v),(ptr),sizeof(*(ptr))))
-
-#define __xg(x) ((volatile long *)(x))
-
-static inline void set_64bit(volatile unsigned long *ptr, unsigned long val)
-{
-	*ptr = val;
-}
-
-#define _set_64bit set_64bit
-
-/*
- * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
- * Note 2: xchg has side effect, so that attribute volatile is necessary,
- *	  but generally the primitive is invalid, *ptr is output argument. --ANK
- */
-static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
-{
-	switch (size) {
-		case 1:
-			__asm__ __volatile__("xchgb %b0,%1"
-				:"=q" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-		case 2:
-			__asm__ __volatile__("xchgw %w0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-		case 4:
-			__asm__ __volatile__("xchgl %k0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-		case 8:
-			__asm__ __volatile__("xchgq %0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-	}
-	return x;
-}
-
-/*
- * Atomic compare and exchange.  Compare OLD with MEM, if identical,
- * store NEW in MEM.  Return the initial value in MEM.  Success is
- * indicated by comparing RETURN with OLD.
- */
-
-#define __HAVE_ARCH_CMPXCHG 1
-
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, int size)
-{
-	unsigned long prev;
-	switch (size) {
-	case 1:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 2:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
-				     : "=a"(prev)
-				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 4:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %k1,%2"
-				     : "=a"(prev)
-				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 8:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgq %1,%2"
-				     : "=a"(prev)
-				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	}
-	return old;
-}
-
-static inline unsigned long __cmpxchg_local(volatile void *ptr,
-			unsigned long old, unsigned long new, int size)
-{
-	unsigned long prev;
-	switch (size) {
-	case 1:
-		__asm__ __volatile__("cmpxchgb %b1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 2:
-		__asm__ __volatile__("cmpxchgw %w1,%2"
-				     : "=a"(prev)
-				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 4:
-		__asm__ __volatile__("cmpxchgl %k1,%2"
-				     : "=a"(prev)
-				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 8:
-		__asm__ __volatile__("cmpxchgq %1,%2"
-				     : "=a"(prev)
-				     : "r"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	}
-	return old;
-}
-
-#define cmpxchg(ptr,o,n)\
-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
-					(unsigned long)(n),sizeof(*(ptr))))
-#define cmpxchg_local(ptr,o,n)\
-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
-					(unsigned long)(n),sizeof(*(ptr))))
-
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
