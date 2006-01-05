Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EudAv-0006Uh-VO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jan 2006 14:01:37 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EudAu-0007dT-2u
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jan 2006 14:01:38 -0800
Message-Id: <200601052253.k05MrngR010777@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/4] Consolidate asm/futex.h
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
Date: Thu, 05 Jan 2006 17:53:48 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Most of the architectures have the same asm/futex.h.  This
consolidates them into asm-generic, with the arches including it
from their own asm/futex.h.

In the case of UML, this reverts the old broken futex.h and goes back
to using the same one as almost everyone else.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/include/asm-alpha/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-alpha/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-alpha/futex.h	2005-12-31 13:45:50.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-arm/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-arm/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-arm/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-arm26/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-arm26/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-arm26/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-cris/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-cris/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-cris/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-frv/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-frv/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-frv/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-generic/futex.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/include/asm-generic/futex.h	2005-12-31 13:45:16.000000000 -0500
@@ -0,0 +1,53 @@
+#ifndef _ASM_GENERIC_FUTEX_H
+#define _ASM_GENERIC_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
Index: linux-2.6.15/include/asm-h8300/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-h8300/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-h8300/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-ia64/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-ia64/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-ia64/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-m32r/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-m32r/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-m32r/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-m68k/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-m68k/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-m68k/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-m68knommu/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-m68knommu/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-m68knommu/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-parisc/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-parisc/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-parisc/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-s390/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-s390/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-s390/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-sh/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-sh/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-sh/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-sh64/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-sh64/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-sh64/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-sparc/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-sparc/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-sparc/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-sparc64/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-sparc64/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-sparc64/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-um/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-um/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-um/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,12 +1,6 @@
-#ifndef __UM_FUTEX_H
-#define __UM_FUTEX_H
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/system.h>
-#include <asm/processor.h>
-#include <asm/uaccess.h>
-
-#include "asm/arch/futex.h"
+#include <asm-generic/futex.h>
 
 #endif
Index: linux-2.6.15/include/asm-v850/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-v850/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-v850/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
