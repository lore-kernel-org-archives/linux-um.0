Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcqCe-0008NU-5t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 12:17:52 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcqCc-00078o-Kn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 12:17:52 -0800
Message-Id: <200511172110.jAHLATGR010209@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/4] UML - Eliminate use of libc PAGE_SIZE
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
Date: Thu, 17 Nov 2005 16:10:29 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On some systems, libc PAGE_SIZE calls getpagesize, which can't
happen from a stub.  So, I use UM_KERN_PAGE_SIZE, which is less
variable in its definition, instead.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/skas/clone.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/clone.c	2005-11-17 14:58:54.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/clone.c	2005-11-17 14:59:40.000000000 -0500
@@ -9,9 +9,13 @@
 #include "stub-data.h"
 #include "uml-config.h"
 #include "sysdep/stub.h"
+#include "kern_constants.h"
 
 /* This is in a separate file because it needs to be compiled with any
  * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
+ *
+ * Use UM_KERN_PAGE_SIZE instead of PAGE_SIZE because that calls getpagesize
+ * on some systems.
  */
 
 #define STUB_DATA(field) (((struct stub_data *) UML_CONFIG_STUB_DATA)->field)
@@ -22,7 +26,7 @@ stub_clone_handler(void)
 	long err;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    UML_CONFIG_STUB_DATA + PAGE_SIZE / 2 -
+			    UML_CONFIG_STUB_DATA + UM_KERN_PAGE_SIZE / 2 -
 			    sizeof(void *));
 	if(err != 0)
 		goto out;
@@ -36,9 +40,10 @@ stub_clone_handler(void)
 	if(err)
 		goto out;
 
-	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, PAGE_SIZE,
-			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
-			    STUB_DATA(fd), STUB_DATA(offset));
+	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, 
+			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE, 
+			    MAP_FIXED | MAP_SHARED, STUB_DATA(fd), 
+			    STUB_DATA(offset));
  out:
 	/* save current result. Parent: pid; child: retcode of mmap */
 	STUB_DATA(err) = err;



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
