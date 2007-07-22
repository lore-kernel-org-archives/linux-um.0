Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ICWNn-0000Q5-5c for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Jul 2007 01:01:39 -0700
Received: from smtp-out.google.com ([216.239.33.17])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ICWNl-0002pf-Dt
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Jul 2007 01:01:38 -0700
Date: Sun, 22 Jul 2007 01:01:12 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Message-ID: <alpine.DEB.0.99.0707220100410.4908@chino.kir.corp.google.com>
MIME-Version: 1.0
Subject: [uml-devel] [patch] um: replace __attribute_used__ with __used
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@karaya.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Replaces the deprecated __attribute_used__ with __used.

Cc: Jeff Dike <jdike@karaya.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/um/include/init.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/init.h b/arch/um/include/init.h
--- a/arch/um/include/init.h
+++ b/arch/um/include/init.h
@@ -45,12 +45,12 @@ typedef void (*exitcall_t)(void);
 #define __init		__attribute__ ((__section__ (".init.text")))
 #define __initdata	__attribute__ ((__section__ (".init.data")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
-#define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
+#define __exit_call	__used __attribute__ ((__section__ (".exitcall.exit")))
 
 #ifdef MODULE
 #define __exit		__attribute__ ((__section__(".exit.text")))
 #else
-#define __exit		__attribute_used__ __attribute__ ((__section__(".exit.text")))
+#define __exit		__used __attribute__ ((__section__(".exit.text")))
 #endif
 
 #endif
@@ -103,16 +103,16 @@ extern struct uml_param __uml_setup_start, __uml_setup_end;
  * Mark functions and data as being only used at initialization
  * or exit time.
  */
-#define __uml_init_setup	__attribute_used__ __attribute__ ((__section__ (".uml.setup.init")))
-#define __uml_setup_help	__attribute_used__ __attribute__ ((__section__ (".uml.help.init")))
-#define __uml_init_call		__attribute_used__ __attribute__ ((__section__ (".uml.initcall.init")))
-#define __uml_postsetup_call	__attribute_used__ __attribute__ ((__section__ (".uml.postsetup.init")))
-#define __uml_exit_call		__attribute_used__ __attribute__ ((__section__ (".uml.exitcall.exit")))
+#define __uml_init_setup	__used __attribute__ ((__section__ (".uml.setup.init")))
+#define __uml_setup_help	__used __attribute__ ((__section__ (".uml.help.init")))
+#define __uml_init_call		__used __attribute__ ((__section__ (".uml.initcall.init")))
+#define __uml_postsetup_call	__used __attribute__ ((__section__ (".uml.postsetup.init")))
+#define __uml_exit_call		__used __attribute__ ((__section__ (".uml.exitcall.exit")))
 
 #ifndef __KERNEL__
 
 #define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __attribute_used__ \
+	static initcall_t __initcall_##fn __used \
 	__attribute__((__section__(".initcall" level ".init"))) = fn
 
 /* Userspace initcalls shouldn't depend on anything in the kernel, so we'll
@@ -122,7 +122,7 @@ extern struct uml_param __uml_setup_start, __uml_setup_end;
 
 #define __exitcall(fn) static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define __init_call	__attribute_used__ __attribute__ ((__section__ (".initcall.init")))
+#define __init_call	__used __attribute__ ((__section__ (".initcall.init")))
 
 #endif
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
