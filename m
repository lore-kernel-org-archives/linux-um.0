Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfJ35-0001rE-T9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 08:34:43 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GfJ31-0006zr-4i
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 08:34:43 -0800
Message-Id: <200611011732.kA1HWfMd005504@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 01 Nov 2006 12:32:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/2] UML - Include tidying
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

In order to get the __NR_* constants, we need sys/syscall.h.
linux/unistd.h works as well since it includes syscall.h, however
syscall.h is more parsimonious.  We were inconsistent in this, and
this patch adds syscall.h includes where necessary and removes
linux/unistd.h includes where they are not needed.  

asm/unistd.h also includes the __NR_* constants, but these are not the
glibc-sanctioned ones, so this also removes one such inclusion.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/process.c	2006-10-30 12:57:27.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/process.c	2006-10-30 15:25:20.000000000 -0500
@@ -7,7 +7,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <signal.h>
-#include <linux/unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
Index: linux-2.6.18-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/skas/process.c	2006-10-30 13:11:24.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/skas/process.c	2006-10-30 15:26:38.000000000 -0500
@@ -14,7 +14,7 @@
 #include <sys/mman.h>
 #include <sys/user.h>
 #include <sys/time.h>
-#include <asm/unistd.h>
+#include <sys/syscall.h>
 #include <asm/types.h>
 #include "user.h"
 #include "sysdep/ptrace.h"
Index: linux-2.6.18-mm/arch/um/os-Linux/tls.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/tls.c	2006-10-30 12:57:27.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/tls.c	2006-10-30 15:25:55.000000000 -0500
@@ -1,7 +1,7 @@
 #include <errno.h>
+#include <unistd.h>
 #include <sys/ptrace.h>
 #include <sys/syscall.h>
-#include <unistd.h>
 #include <asm/ldt.h>
 #include "sysdep/tls.h"
 #include "uml-config.h"


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
