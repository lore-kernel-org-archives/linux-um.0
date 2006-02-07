Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6IUu-0003pD-LK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:28 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6IUu-00085f-3Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:28 -0800
Message-Id: <200602070223.k172Nmvq009649@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/8] UML - Compilation warning removal
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
Date: Mon, 06 Feb 2006 21:23:48 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

With gcc 4.1.0, I get a bunch of warnings about consts being lost in the
copy_user code.  This patch fixes them by adding consts where necessary.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/skas/uaccess-skas.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/skas/uaccess-skas.h	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/include/skas/uaccess-skas.h	2006-02-06 17:34:21.000000000 -0500
@@ -11,8 +11,8 @@
 /* No SKAS-specific checking. */
 #define access_ok_skas(type, addr, size) 0
 
-extern int copy_from_user_skas(void *to, const void __user *from, int n);
-extern int copy_to_user_skas(void __user *to, const void *from, int n);
+extern int copy_from_user_skas(const void *to, const void __user *from, int n);
+extern int copy_to_user_skas(const void __user *to, const void *from, int n);
 extern int strncpy_from_user_skas(char *dst, const char __user *src, int count);
 extern int __clear_user_skas(void __user *mem, int len);
 extern int clear_user_skas(void __user *mem, int len);
Index: linux-2.6.15/arch/um/include/tt/uaccess-tt.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/tt/uaccess-tt.h	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/include/tt/uaccess-tt.h	2006-02-06 17:34:21.000000000 -0500
@@ -38,8 +38,8 @@ extern int __do_clear_user(void *mem, si
 extern int __do_strnlen_user(const char *str, unsigned long n,
 			     void **fault_addr, void **fault_catcher);
 
-extern int copy_from_user_tt(void *to, const void __user *from, int n);
-extern int copy_to_user_tt(void __user *to, const void *from, int n);
+extern int copy_from_user_tt(const void *to, const void __user *from, int n);
+extern int copy_to_user_tt(const void __user *to, const void *from, int n);
 extern int strncpy_from_user_tt(char *dst, const char __user *src, int count);
 extern int __clear_user_tt(void __user *mem, int len);
 extern int clear_user_tt(void __user *mem, int len);
Index: linux-2.6.15/arch/um/include/um_uaccess.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/um_uaccess.h	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/include/um_uaccess.h	2006-02-06 17:34:24.000000000 -0500
@@ -39,13 +39,13 @@
 	  segment_eq(get_fs(), KERNEL_DS) || \
 	  CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)))
 
-static inline int copy_from_user(void *to, const void __user *from, int n)
+static inline int copy_from_user(const void *to, const void __user *from, int n)
 {
 	return(CHOOSE_MODE_PROC(copy_from_user_tt, copy_from_user_skas, to,
 				from, n));
 }
 
-static inline int copy_to_user(void __user *to, const void *from, int n)
+static inline int copy_to_user(const void __user *to, const void *from, int n)
 {
 	return(CHOOSE_MODE_PROC(copy_to_user_tt, copy_to_user_skas, to, 
 				from, n));
Index: linux-2.6.15/arch/um/kernel/skas/uaccess.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/uaccess.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/uaccess.c	2006-02-06 17:34:24.000000000 -0500
@@ -136,10 +136,10 @@ static int copy_chunk_from_user(unsigned
 	return(0);
 }
 
-int copy_from_user_skas(void *to, const void __user *from, int n)
+int copy_from_user_skas(const void *to, const void __user *from, int n)
 {
 	if(segment_eq(get_fs(), KERNEL_DS)){
-		memcpy(to, (__force void*)from, n);
+		memcpy((void *) to, (__force void*)from, n);
 		return(0);
 	}
 
@@ -157,7 +157,7 @@ static int copy_chunk_to_user(unsigned l
 	return(0);
 }
 
-int copy_to_user_skas(void __user *to, const void *from, int n)
+int copy_to_user_skas(const void __user *to, const void *from, int n)
 {
 	if(segment_eq(get_fs(), KERNEL_DS)){
 		memcpy((__force void*)to, from, n);
Index: linux-2.6.15/arch/um/kernel/tt/uaccess.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/tt/uaccess.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/tt/uaccess.c	2006-02-06 17:34:24.000000000 -0500
@@ -6,7 +6,7 @@
 #include "linux/sched.h"
 #include "asm/uaccess.h"
 
-int copy_from_user_tt(void *to, const void __user *from, int n)
+int copy_from_user_tt(const void *to, const void __user *from, int n)
 {
 	if(!access_ok(VERIFY_READ, from, n))
 		return(n);
@@ -15,7 +15,7 @@ int copy_from_user_tt(void *to, const vo
 				   &current->thread.fault_catcher));
 }
 
-int copy_to_user_tt(void __user *to, const void *from, int n)
+int copy_to_user_tt(const void __user *to, const void *from, int n)
 {
 	if(!access_ok(VERIFY_WRITE, to, n))
 		return(n);
Index: linux-2.6.15/include/asm-um/uaccess.h
===================================================================
--- linux-2.6.15.orig/include/asm-um/uaccess.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-um/uaccess.h	2006-02-06 17:34:24.000000000 -0500
@@ -41,7 +41,7 @@
 
 #define __get_user(x, ptr) \
 ({ \
-        const __typeof__(ptr) __private_ptr = ptr; \
+        const __typeof__(ptr) __user __private_ptr = ptr; \
         __typeof__(*(__private_ptr)) __private_val; \
         int __private_ret = -EFAULT; \
         (x) = (__typeof__(*(__private_ptr)))0; \



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
