Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eazhd-0004fW-Q2 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:13 -0800
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eazha-0000VI-SS for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:13 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051112180754.20133.28856.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 8/9] Uml: fix access_ok
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 12 Nov 2005 19:07:59 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The access_ok_tt() macro is bogus, in that a read access is unconditionally
considered valid.

I couldn't find in SCM logs the introduction of this check, but I went back to
 2.4.20-1um and the definition was the same.

Possibly this was done to avoid problems with missing set_fs() calls, but there
can't be any I think because they would fail with SKAS mode. TT-specific code is
still to check.

Also, this patch joins common code together, and makes the "address range
wrapping" check happen for all cases, rather than for only some.

This may, possibly, be reoptimized at some time, but the current code doesn't
seem clever, just confused.

* Important: I've also had to change references to access_ok_{tt,skas} back to
  access_ok - the kernel wasn't that happy otherwise.
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/um_uaccess.h               |   19 ++++++++++++++++++-
 arch/um/kernel/skas/include/uaccess-skas.h |   10 ++--------
 arch/um/kernel/skas/uaccess.c              |    8 ++++----
 arch/um/kernel/tt/include/uaccess-tt.h     |    8 +-------
 arch/um/kernel/tt/uaccess.c                |    8 ++++----
 5 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/um/include/um_uaccess.h b/arch/um/include/um_uaccess.h
index 84c0868..f8760a3 100644
--- a/arch/um/include/um_uaccess.h
+++ b/arch/um/include/um_uaccess.h
@@ -17,8 +17,25 @@
 #include "uaccess-skas.h"
 #endif
 
+#define __under_task_size(addr, size) \
+	(((unsigned long) (addr) < TASK_SIZE) && \
+         (((unsigned long) (addr) + (size)) < TASK_SIZE))
+
+#define __access_ok_vsyscall(type, addr, size) \
+	 ((type == VERIFY_READ) && \
+	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
+	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr)))
+
+#define __addr_range_nowrap(addr, size) \
+	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
+
 #define access_ok(type, addr, size) \
-	CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)
+	(__addr_range_nowrap(addr, size) && \
+	 (__under_task_size(addr, size) || \
+	  __access_ok_vsyscall(type, addr, size) || \
+	  segment_eq(get_fs(), KERNEL_DS) || \
+	  CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)))
 
 static inline int copy_from_user(void *to, const void __user *from, int n)
 {
diff --git a/arch/um/kernel/skas/include/uaccess-skas.h b/arch/um/kernel/skas/include/uaccess-skas.h
index 7da0c2d..f611f83 100644
--- a/arch/um/kernel/skas/include/uaccess-skas.h
+++ b/arch/um/kernel/skas/include/uaccess-skas.h
@@ -9,14 +9,8 @@
 #include "asm/errno.h"
 #include "asm/fixmap.h"
 
-#define access_ok_skas(type, addr, size) \
-	((segment_eq(get_fs(), KERNEL_DS)) || \
-	 (((unsigned long) (addr) < TASK_SIZE) && \
-	  ((unsigned long) (addr) + (size) <= TASK_SIZE)) || \
-	 ((type == VERIFY_READ ) && \
-	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
-	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
-	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
+/* No SKAS-specific checking. */
+#define access_ok_skas(type, addr, size) 0
 
 extern int copy_from_user_skas(void *to, const void __user *from, int n);
 extern int copy_to_user_skas(void __user *to, const void *from, int n);
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 7519528..a5a4752 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -143,7 +143,7 @@ int copy_from_user_skas(void *to, const 
 		return(0);
 	}
 
-	return(access_ok_skas(VERIFY_READ, from, n) ?
+	return(access_ok(VERIFY_READ, from, n) ?
 	       buffer_op((unsigned long) from, n, 0, copy_chunk_from_user, &to):
 	       n);
 }
@@ -164,7 +164,7 @@ int copy_to_user_skas(void __user *to, c
 		return(0);
 	}
 
-	return(access_ok_skas(VERIFY_WRITE, to, n) ?
+	return(access_ok(VERIFY_WRITE, to, n) ?
 	       buffer_op((unsigned long) to, n, 1, copy_chunk_to_user, &from) :
 	       n);
 }
@@ -193,7 +193,7 @@ int strncpy_from_user_skas(char *dst, co
 		return(strnlen(dst, count));
 	}
 
-	if(!access_ok_skas(VERIFY_READ, src, 1))
+	if(!access_ok(VERIFY_READ, src, 1))
 		return(-EFAULT);
 
 	n = buffer_op((unsigned long) src, count, 0, strncpy_chunk_from_user,
@@ -221,7 +221,7 @@ int clear_user_skas(void __user *mem, in
 		return(0);
 	}
 
-	return(access_ok_skas(VERIFY_WRITE, mem, len) ?
+	return(access_ok(VERIFY_WRITE, mem, len) ?
 	       buffer_op((unsigned long) mem, len, 1, clear_chunk, NULL) : len);
 }
 
diff --git a/arch/um/kernel/tt/include/uaccess-tt.h b/arch/um/kernel/tt/include/uaccess-tt.h
index dc2ebfa..b9bfe9c 100644
--- a/arch/um/kernel/tt/include/uaccess-tt.h
+++ b/arch/um/kernel/tt/include/uaccess-tt.h
@@ -19,19 +19,13 @@
 extern unsigned long end_vm;
 extern unsigned long uml_physmem;
 
-#define under_task_size(addr, size) \
-	(((unsigned long) (addr) < TASK_SIZE) && \
-         (((unsigned long) (addr) + (size)) < TASK_SIZE))
-
 #define is_stack(addr, size) \
 	(((unsigned long) (addr) < STACK_TOP) && \
 	 ((unsigned long) (addr) >= STACK_TOP - ABOVE_KMEM) && \
 	 (((unsigned long) (addr) + (size)) <= STACK_TOP))
 
 #define access_ok_tt(type, addr, size) \
-	((type == VERIFY_READ) || (segment_eq(get_fs(), KERNEL_DS)) || \
-         (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
-          (under_task_size(addr, size) || is_stack(addr, size))))
+	(is_stack(addr, size))
 
 extern unsigned long get_fault_addr(void);
 
diff --git a/arch/um/kernel/tt/uaccess.c b/arch/um/kernel/tt/uaccess.c
index a72aa63..1cb6072 100644
--- a/arch/um/kernel/tt/uaccess.c
+++ b/arch/um/kernel/tt/uaccess.c
@@ -8,7 +8,7 @@
 
 int copy_from_user_tt(void *to, const void __user *from, int n)
 {
-	if(!access_ok_tt(VERIFY_READ, from, n))
+	if(!access_ok(VERIFY_READ, from, n))
 		return(n);
 
 	return(__do_copy_from_user(to, from, n, &current->thread.fault_addr,
@@ -17,7 +17,7 @@ int copy_from_user_tt(void *to, const vo
 
 int copy_to_user_tt(void __user *to, const void *from, int n)
 {
-	if(!access_ok_tt(VERIFY_WRITE, to, n))
+	if(!access_ok(VERIFY_WRITE, to, n))
 		return(n);
 
 	return(__do_copy_to_user(to, from, n, &current->thread.fault_addr,
@@ -28,7 +28,7 @@ int strncpy_from_user_tt(char *dst, cons
 {
 	int n;
 
-	if(!access_ok_tt(VERIFY_READ, src, 1))
+	if(!access_ok(VERIFY_READ, src, 1))
 		return(-EFAULT);
 
 	n = __do_strncpy_from_user(dst, src, count,
@@ -47,7 +47,7 @@ int __clear_user_tt(void __user *mem, in
 
 int clear_user_tt(void __user *mem, int len)
 {
-	if(!access_ok_tt(VERIFY_WRITE, mem, len))
+	if(!access_ok(VERIFY_WRITE, mem, len))
 		return(len);
 
 	return(__do_clear_user(mem, len, &current->thread.fault_addr,



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
