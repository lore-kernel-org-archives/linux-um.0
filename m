Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeHm-0006aQ-Qc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:34 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeHm-0000fb-Be
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:34 -0700
Message-Id: <200607070033.k670XbdL008687@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 06 Jul 2006 20:33:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/19] UML - Remove useless declaration
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

wall_to_monotonic isn't used in this file, so we can remove the declaration.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-rc-mm/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.16-rc-mm.orig/arch/um/os-Linux/time.c	2006-06-26 17:51:36.000000000 -0400
+++ linux-2.6.16-rc-mm/arch/um/os-Linux/time.c	2006-06-28 13:07:09.000000000 -0400
@@ -17,11 +17,6 @@
 #include "kern_constants.h"
 #include "os.h"
 
-/* XXX This really needs to be declared and initialized in a kernel file since
- * it's in <linux/time.h>
- */
-extern struct timespec wall_to_monotonic;
-
 static void set_interval(int timer_type)
 {
 	int usec = 1000000/hz();


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
