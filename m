Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Na1-0002Ds-7D for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:49 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8NZz-0001di-8v for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:49 -0800
Message-Id: <200503072037.j27Kb7bc003942@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/16] UML - 2.6.11 updates
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
Date: Mon, 07 Mar 2005 15:37:07 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This patch makes some small changes that parallel changes in 2.6.11:
	The csum buffers are now unsigned char.
	Got rid of an unused define from pgtable-2level.h.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/include/sysdep-x86_64/checksum.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/sysdep-x86_64/checksum.h	2005-03-04 14:16:38.000000000 -0500
+++ linux-2.6.11/arch/um/include/sysdep-x86_64/checksum.h	2005-03-04 19:28:02.000000000 -0500
@@ -9,7 +9,7 @@
 #include "linux/in6.h"
 #include "asm/uaccess.h"
 
-extern unsigned int csum_partial_copy_from(const char *src, char *dst, int len,
+extern unsigned int csum_partial_copy_from(const unsigned char *src, unsigned char *dst, int len,
 					   int sum, int *err_ptr);
 extern unsigned csum_partial(const unsigned char *buff, unsigned len,
                              unsigned sum);
@@ -23,7 +23,7 @@
  */
 
 static __inline__
-unsigned int csum_partial_copy_nocheck(const char *src, char *dst,
+unsigned int csum_partial_copy_nocheck(const unsigned char *src, unsigned char *dst,
 				       int len, int sum)
 {
 	memcpy(dst, src, len);
@@ -31,7 +31,7 @@
 }
 
 static __inline__
-unsigned int csum_partial_copy_from_user(const char *src, char *dst,
+unsigned int csum_partial_copy_from_user(const unsigned char *src, unsigned char *dst,
 					 int len, int sum, int *err_ptr)
 {
 	return csum_partial_copy_from(src, dst, len, sum, err_ptr);
Index: linux-2.6.11/arch/um/kernel/checksum.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/checksum.c	2005-03-04 14:16:38.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/checksum.c	2005-03-04 19:31:26.000000000 -0500
@@ -6,40 +6,31 @@
 
 unsigned int csum_partial(unsigned char *buff, int len, int sum)
 {
-	return arch_csum_partial(buff, len, sum);
+        return arch_csum_partial(buff, len, sum);
 }
 
 EXPORT_SYMBOL(csum_partial);
 
-unsigned int csum_partial_copy_to(const unsigned char *src, char __user *dst,
-				int len, int sum, int *err_ptr)
+unsigned int csum_partial_copy_to(const unsigned char *src, 
+                                  unsigned char __user *dst, int len, int sum,
+                                  int *err_ptr)
 {
-	if(copy_to_user(dst, src, len)){
-		*err_ptr = -EFAULT;
-		return(-1);
-	}
+        if(copy_to_user(dst, src, len)){
+                *err_ptr = -EFAULT;
+                return(-1);
+        }
 
-	return(arch_csum_partial(src, len, sum));
+        return(arch_csum_partial(src, len, sum));
 }
 
-unsigned int csum_partial_copy_from(const unsigned char __user *src, char *dst,
-				int len, int sum, int *err_ptr)
+unsigned int csum_partial_copy_from(const unsigned char __user *src, 
+                                    unsigned char *dst,	int len, int sum, 
+                                    int *err_ptr)
 {
-	if(copy_from_user(dst, src, len)){
-		*err_ptr = -EFAULT;
-		return(-1);
-	}
+        if(copy_from_user(dst, src, len)){
+                *err_ptr = -EFAULT;
+                return(-1);
+        }
 
-	return arch_csum_partial(dst, len, sum);
+        return arch_csum_partial(dst, len, sum);
 }
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
Index: linux-2.6.11/include/asm-um/pgtable-2level.h
===================================================================
--- linux-2.6.11.orig/include/asm-um/pgtable-2level.h	2005-03-04 14:17:00.000000000 -0500
+++ linux-2.6.11/include/asm-um/pgtable-2level.h	2005-03-04 19:38:54.000000000 -0500
@@ -21,7 +21,6 @@
  * we don't really have any PMD directory physically.
  */
 #define PTRS_PER_PTE	1024
-#define PTRS_PER_PMD	1
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 #define PTRS_PER_PGD	1024
 #define FIRST_USER_PGD_NR       0



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
