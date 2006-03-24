Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqmf-0003VZ-Rg for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:13 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqme-0001FW-6m
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:13 -0800
Message-Id: <200603241814.k2OIESh7005500@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/16] UML - Fix build warnings in __get_user
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
Date: Fri, 24 Mar 2006 13:14:28 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Fix a gcc warning about losing qualifiers to the first argument of
copy_from_user.  The typeof change for correctness, and fixes a lot
of the warnings, but there are some cases where x has some extra
qualifiers, like volatile, which copy_from_user can't know about.
For these, the void * cast seems to be necessary.

Also cleaned up some of the whitespace and got rid of the emacs comment
at the bottom.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/include/asm-um/uaccess.h
===================================================================
--- linux-2.6.16.orig/include/asm-um/uaccess.h	2006-03-23 17:49:25.000000000 -0500
+++ linux-2.6.16/include/asm-um/uaccess.h	2006-03-23 18:41:57.000000000 -0500
@@ -41,16 +41,16 @@
 
 #define __get_user(x, ptr) \
 ({ \
-        const __typeof__(ptr) __private_ptr = ptr; \
-        __typeof__(*(__private_ptr)) __private_val; \
-        int __private_ret = -EFAULT; \
-        (x) = (__typeof__(*(__private_ptr)))0; \
-	if (__copy_from_user(&__private_val, (__private_ptr), \
-	    sizeof(*(__private_ptr))) == 0) {\
-        	(x) = (__typeof__(*(__private_ptr))) __private_val; \
-		__private_ret = 0; \
-	} \
-        __private_ret; \
+	const __typeof__(ptr) __private_ptr = ptr;	\
+	__typeof__(x) __private_val;			\
+	int __private_ret = -EFAULT;			\
+	(x) = (__typeof__(*(__private_ptr)))0;				\
+	if (__copy_from_user((void *) &__private_val, (__private_ptr),	\
+			     sizeof(*(__private_ptr))) == 0) {		\
+		(x) = (__typeof__(*(__private_ptr))) __private_val;	\
+		__private_ret = 0;					\
+	}								\
+	__private_ret;							\
 }) 
 
 #define get_user(x, ptr) \
@@ -89,14 +89,3 @@ struct exception_table_entry
 };
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
