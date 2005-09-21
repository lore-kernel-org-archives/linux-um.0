Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI7kM-0001E9-86	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:02 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI7kL-0003vY-Rv
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:02 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921163711.30500.53955.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 01/10] uml: adapt asm/futex.h to our arch
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
Date: Wed, 21 Sep 2005 18:37:14 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Follow up to 4732efbeb997189d9f9b04708dc26bf8613ed721 - uml must just reuse
as-is the backing architecture support. There is a micro-fixup is needed for the
included file, which won't affect i386 behaviour at all.

I've not tested compilation on x86_64, only on x86, but the code is almost the
same except the culprit test, so everything should be ok on x86_64 too.

Cc: Jakub Jelinek <jakub@redhat.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-i386/futex.h |    2 +-
 include/asm-um/futex.h   |   51 +++++-----------------------------------------
 2 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/include/asm-i386/futex.h b/include/asm-i386/futex.h
--- a/include/asm-i386/futex.h
+++ b/include/asm-i386/futex.h
@@ -61,7 +61,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	if (op == FUTEX_OP_SET)
 		__futex_atomic_op1("xchgl %0, %2", ret, oldval, uaddr, oparg);
 	else {
-#ifndef CONFIG_X86_BSWAP
+#if !defined(CONFIG_X86_BSWAP) && !defined(CONFIG_UML)
 		if (boot_cpu_data.x86 == 3)
 			ret = -ENOSYS;
 		else
diff --git a/include/asm-um/futex.h b/include/asm-um/futex.h
--- a/include/asm-um/futex.h
+++ b/include/asm-um/futex.h
@@ -1,53 +1,12 @@
-#ifndef _ASM_FUTEX_H
-#define _ASM_FUTEX_H
-
-#ifdef __KERNEL__
+#ifndef __UM_FUTEX_H
+#define __UM_FUTEX_H
 
 #include <linux/futex.h>
 #include <asm/errno.h>
+#include <asm/system.h>
+#include <asm/processor.h>
 #include <asm/uaccess.h>
 
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
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
+#include "asm/arch/futex.h"
 
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
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
