Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YrwCK-0006Ef-Ie
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 22:29:16 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YrwCI-000596-Iz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 22:29:16 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 12 May 2015 00:28:55 +0200
Message-Id: <1431383335-15315-6-git-send-email-richard@nod.at>
In-Reply-To: <1431383335-15315-1-git-send-email-richard@nod.at>
References: <1431383335-15315-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 5/5] um: Rework uaccess code
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

Rework UML's uaccess code to reuse as much as possible
from asm-generic/uaccess.c.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/thread_info.h |   2 +-
 arch/um/include/asm/uaccess.h     | 176 ++++++--------------------------------
 arch/um/kernel/skas/uaccess.c     |  47 ++++------
 arch/x86/um/asm/checksum.h        |   1 +
 arch/x86/um/asm/elf.h             |   2 -
 arch/x86/um/asm/processor.h       |   2 +
 arch/x86/um/asm/segment.h         |   8 ++
 7 files changed, 54 insertions(+), 184 deletions(-)

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index b30c85b..53968aa 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -10,7 +10,7 @@
 
 #include <asm/types.h>
 #include <asm/page.h>
-#include <asm/uaccess.h>
+#include <asm/segment.h>
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 3f22fbf..3705620 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -1,178 +1,52 @@
 /* 
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2015 Richard Weinberger (richard@nod.at)
  * Licensed under the GPL
  */
 
 #ifndef __UM_UACCESS_H
 #define __UM_UACCESS_H
 
-/* thread_info has a mm_segment_t in it, so put the definition up here */
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
-#include <linux/thread_info.h>
-#include <linux/errno.h>
-#include <asm/processor.h>
+#include <asm/thread_info.h>
 #include <asm/elf.h>
 
-#define VERIFY_READ 0
-#define VERIFY_WRITE 1
-
-/*
- * The fs value determines whether argument validity checking should be
- * performed or not.  If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- */
-
-#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
-
-#define KERNEL_DS	MAKE_MM_SEG(0xFFFFFFFF)
-#define USER_DS		MAKE_MM_SEG(TASK_SIZE)
-
-#define get_ds()	(KERNEL_DS)
-#define get_fs()	(current_thread_info()->addr_limit)
-#define set_fs(x)	(current_thread_info()->addr_limit = (x))
-
-#define segment_eq(a, b) ((a).seg == (b).seg)
-
 #define __under_task_size(addr, size) \
 	(((unsigned long) (addr) < TASK_SIZE) && \
 	 (((unsigned long) (addr) + (size)) < TASK_SIZE))
 
-#define __access_ok_vsyscall(type, addr, size) \
-	 ((type == VERIFY_READ) && \
-	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
+#define __access_ok_vsyscall(addr, size) \
+	  (((unsigned long) (addr) >= FIXADDR_USER_START) && \
 	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
 	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr)))
 
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
-#define access_ok(type, addr, size) \
-	(__addr_range_nowrap(addr, size) && \
-	 (__under_task_size(addr, size) || \
-	  __access_ok_vsyscall(type, addr, size) || \
-	  segment_eq(get_fs(), KERNEL_DS)))
-
-extern int copy_from_user(void *to, const void __user *from, int n);
-extern int copy_to_user(void __user *to, const void *from, int n);
-
-/*
- * strncpy_from_user: - Copy a NUL terminated string from userspace.
- * @dst:   Destination address, in kernel space.  This buffer must be at
- *         least @count bytes long.
- * @src:   Source address, in user space.
- * @count: Maximum number of bytes to copy, including the trailing NUL.
- *
- * Copies a NUL-terminated string from userspace to kernel space.
- *
- * On success, returns the length of the string (not including the trailing
- * NUL).
- *
- * If access to userspace fails, returns -EFAULT (some data may have been
- * copied).
- *
- * If @count is smaller than the length of the string, copies @count bytes
- * and returns @count.
- */
-
-extern int strncpy_from_user(char *dst, const char __user *src, int count);
-
-/*
- * __clear_user: - Zero a block of memory in user space, with less checking.
- * @to:   Destination address, in user space.
- * @n:    Number of bytes to zero.
- *
- * Zero a block of memory in user space.  Caller must check
- * the specified block with access_ok() before calling this function.
- *
- * Returns number of bytes that could not be cleared.
- * On success, this will be zero.
- */
-extern int __clear_user(void __user *mem, int len);
-
-/*
- * clear_user: - Zero a block of memory in user space.
- * @to:   Destination address, in user space.
- * @n:    Number of bytes to zero.
- *
- * Zero a block of memory in user space.
- *
- * Returns number of bytes that could not be cleared.
- * On success, this will be zero.
- */
-extern int clear_user(void __user *mem, int len);
-
-/*
- * strlen_user: - Get the size of a string in user space.
- * @str: The string to measure.
- * @n:   The maximum valid length
- *
- * Get the size of a NUL-terminated string in user space.
- *
- * Returns the size of the string INCLUDING the terminating NUL.
- * On exception, returns 0.
- * If the string is too long, returns a value greater than @n.
- */
-extern int strnlen_user(const void __user *str, int len);
-
-#define __copy_from_user(to, from, n) copy_from_user(to, from, n)
-
-#define __copy_to_user(to, from, n) copy_to_user(to, from, n)
-
+extern long __copy_from_user(void *to, const void __user *from, unsigned long n);
+extern long __copy_to_user(void __user *to, const void *from, unsigned long n);
+extern long __strncpy_from_user(char *dst, const char __user *src, long count);
+extern long __strnlen_user(const void __user *str, long len);
+extern unsigned long __clear_user(void __user *mem, unsigned long len);
+static inline int __access_ok(unsigned long addr, unsigned long size);
+
+/* Teach asm-generic/uaccess.h that we have C functions for these. */
+#define __access_ok __access_ok
+#define __clear_user __clear_user
+#define __copy_to_user __copy_to_user
+#define __copy_from_user __copy_from_user
+#define __strnlen_user __strnlen_user
+#define __strncpy_from_user __strncpy_from_user
 #define __copy_to_user_inatomic __copy_to_user
 #define __copy_from_user_inatomic __copy_from_user
 
-#define __get_user(x, ptr) \
-({ \
-	const __typeof__(*(ptr)) __user *__private_ptr = (ptr);	\
-	__typeof__(x) __private_val;			\
-	int __private_ret = -EFAULT;			\
-	(x) = (__typeof__(*(__private_ptr)))0;				\
-	if (__copy_from_user((__force void *)&__private_val, (__private_ptr),\
-			     sizeof(*(__private_ptr))) == 0) {		\
-		(x) = (__typeof__(*(__private_ptr))) __private_val;	\
-		__private_ret = 0;					\
-	}								\
-	__private_ret;							\
-}) 
-
-#define get_user(x, ptr) \
-({ \
-        const __typeof__((*(ptr))) __user *private_ptr = (ptr); \
-        (access_ok(VERIFY_READ, private_ptr, sizeof(*private_ptr)) ? \
-	 __get_user(x, private_ptr) : ((x) = (__typeof__(*ptr))0, -EFAULT)); \
-})
-
-#define __put_user(x, ptr) \
-({ \
-        __typeof__(*(ptr)) __user *__private_ptr = ptr; \
-        __typeof__(*(__private_ptr)) __private_val; \
-        int __private_ret = -EFAULT; \
-        __private_val = (__typeof__(*(__private_ptr))) (x); \
-        if (__copy_to_user((__private_ptr), &__private_val, \
-			   sizeof(*(__private_ptr))) == 0) { \
-		__private_ret = 0; \
-	} \
-        __private_ret; \
-})
-
-#define put_user(x, ptr) \
-({ \
-        __typeof__(*(ptr)) __user *private_ptr = (ptr); \
-        (access_ok(VERIFY_WRITE, private_ptr, sizeof(*private_ptr)) ? \
-	 __put_user(x, private_ptr) : -EFAULT); \
-})
-
-#define strlen_user(str) strnlen_user(str, ~0U >> 1)
+#include <asm-generic/uaccess.h>
 
-struct exception_table_entry
+static inline int __access_ok(unsigned long addr, unsigned long size)
 {
-        unsigned long insn;
-	unsigned long fixup;
-};
+	return __addr_range_nowrap(addr, size) &&
+		(__under_task_size(addr, size) ||
+		__access_ok_vsyscall(addr, size) ||
+		segment_eq(get_fs(), KERNEL_DS));
+}
 
 #endif
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 4ffb644..85ac8ad 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -87,10 +87,10 @@ static int do_op_one_page(unsigned long addr, int len, int is_write,
 	return n;
 }
 
-static int buffer_op(unsigned long addr, int len, int is_write,
-		     int (*op)(unsigned long, int, void *), void *arg)
+static long buffer_op(unsigned long addr, int len, int is_write,
+		      int (*op)(unsigned long, int, void *), void *arg)
 {
-	int size, remain, n;
+	long size, remain, n;
 
 	size = min(PAGE_ALIGN(addr) - addr, (unsigned long) len);
 	remain = len;
@@ -139,18 +139,16 @@ static int copy_chunk_from_user(unsigned long from, int len, void *arg)
 	return 0;
 }
 
-int copy_from_user(void *to, const void __user *from, int n)
+long __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	if (segment_eq(get_fs(), KERNEL_DS)) {
 		memcpy(to, (__force void*)from, n);
 		return 0;
 	}
 
-	return access_ok(VERIFY_READ, from, n) ?
-	       buffer_op((unsigned long) from, n, 0, copy_chunk_from_user, &to):
-	       n;
+	return buffer_op((unsigned long) from, n, 0, copy_chunk_from_user, &to);
 }
-EXPORT_SYMBOL(copy_from_user);
+EXPORT_SYMBOL(__copy_from_user);
 
 static int copy_chunk_to_user(unsigned long to, int len, void *arg)
 {
@@ -161,18 +159,16 @@ static int copy_chunk_to_user(unsigned long to, int len, void *arg)
 	return 0;
 }
 
-int copy_to_user(void __user *to, const void *from, int n)
+long __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	if (segment_eq(get_fs(), KERNEL_DS)) {
 		memcpy((__force void *) to, from, n);
 		return 0;
 	}
 
-	return access_ok(VERIFY_WRITE, to, n) ?
-	       buffer_op((unsigned long) to, n, 1, copy_chunk_to_user, &from) :
-	       n;
+	return buffer_op((unsigned long) to, n, 1, copy_chunk_to_user, &from);
 }
-EXPORT_SYMBOL(copy_to_user);
+EXPORT_SYMBOL(__copy_to_user);
 
 static int strncpy_chunk_from_user(unsigned long from, int len, void *arg)
 {
@@ -188,9 +184,9 @@ static int strncpy_chunk_from_user(unsigned long from, int len, void *arg)
 	return 0;
 }
 
-int strncpy_from_user(char *dst, const char __user *src, int count)
+long __strncpy_from_user(char *dst, const char __user *src, long count)
 {
-	int n;
+	long n;
 	char *ptr = dst;
 
 	if (segment_eq(get_fs(), KERNEL_DS)) {
@@ -198,16 +194,13 @@ int strncpy_from_user(char *dst, const char __user *src, int count)
 		return strnlen(dst, count);
 	}
 
-	if (!access_ok(VERIFY_READ, src, 1))
-		return -EFAULT;
-
 	n = buffer_op((unsigned long) src, count, 0, strncpy_chunk_from_user,
 		      &ptr);
 	if (n != 0)
 		return -EFAULT;
 	return strnlen(dst, count);
 }
-EXPORT_SYMBOL(strncpy_from_user);
+EXPORT_SYMBOL(__strncpy_from_user);
 
 static int clear_chunk(unsigned long addr, int len, void *unused)
 {
@@ -215,22 +208,16 @@ static int clear_chunk(unsigned long addr, int len, void *unused)
 	return 0;
 }
 
-int __clear_user(void __user *mem, int len)
-{
-	return buffer_op((unsigned long) mem, len, 1, clear_chunk, NULL);
-}
-
-int clear_user(void __user *mem, int len)
+unsigned long __clear_user(void __user *mem, unsigned long len)
 {
 	if (segment_eq(get_fs(), KERNEL_DS)) {
 		memset((__force void*)mem, 0, len);
 		return 0;
 	}
 
-	return access_ok(VERIFY_WRITE, mem, len) ?
-	       buffer_op((unsigned long) mem, len, 1, clear_chunk, NULL) : len;
+	return buffer_op((unsigned long) mem, len, 1, clear_chunk, NULL);
 }
-EXPORT_SYMBOL(clear_user);
+EXPORT_SYMBOL(__clear_user);
 
 static int strnlen_chunk(unsigned long str, int len, void *arg)
 {
@@ -244,7 +231,7 @@ static int strnlen_chunk(unsigned long str, int len, void *arg)
 	return 0;
 }
 
-int strnlen_user(const void __user *str, int len)
+long __strnlen_user(const void __user *str, long len)
 {
 	int count = 0, n;
 
@@ -256,4 +243,4 @@ int strnlen_user(const void __user *str, int len)
 		return count + 1;
 	return 0;
 }
-EXPORT_SYMBOL(strnlen_user);
+EXPORT_SYMBOL(__strnlen_user);
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index 4b181b7..ee94018 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -3,6 +3,7 @@
 
 #include <linux/string.h>
 #include <linux/in6.h>
+#include <linux/uaccess.h>
 
 /*
  * computes the checksum of a memory block at buff, length len,
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 0a656b7..5481972 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -200,8 +200,6 @@ typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
 typedef struct user_i387_struct elf_fpregset_t;
 
-#define task_pt_regs(t) (&(t)->thread.regs)
-
 struct task_struct;
 
 extern int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu);
diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
index 2a206d2..233ee09 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -28,6 +28,8 @@ static inline void rep_nop(void)
 #define cpu_relax()		rep_nop()
 #define cpu_relax_lowlatency()	cpu_relax()
 
+#define task_pt_regs(t) (&(t)->thread.regs)
+
 #include <asm/processor-generic.h>
 
 #endif
diff --git a/arch/x86/um/asm/segment.h b/arch/x86/um/asm/segment.h
index 45183fc..41dd5e1 100644
--- a/arch/x86/um/asm/segment.h
+++ b/arch/x86/um/asm/segment.h
@@ -7,4 +7,12 @@ extern int host_gdt_entry_tls_min;
 #define GDT_ENTRY_TLS_MIN host_gdt_entry_tls_min
 #define GDT_ENTRY_TLS_MAX (GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
 
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
+#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
+#define KERNEL_DS	MAKE_MM_SEG(~0UL)
+#define USER_DS		MAKE_MM_SEG(TASK_SIZE)
+
 #endif
-- 
1.8.4.5


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

