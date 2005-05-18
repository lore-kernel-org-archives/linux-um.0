Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYO2x-0006Tv-Pa	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 05:53:11 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYO2x-0002c8-0q	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 05:53:11 -0700
Message-Id: <200505180420.j4I4KQ6H017322@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/9] UML - Delay loop cleanups
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
Date: Wed, 18 May 2005 00:20:26 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

This patch cleans up the delay implementations a bit, makes the loops
unoptimizable, and exports __udelay and __const_udelay.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/sys-i386/delay.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-i386/delay.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-i386/delay.c	2005-05-17 18:11:21.000000000 -0400
@@ -1,5 +1,7 @@
-#include "linux/delay.h"
-#include "asm/param.h"
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <asm/param.h>
 
 void __delay(unsigned long time)
 {
@@ -20,13 +22,19 @@ void __udelay(unsigned long usecs)
 	int i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                barrier();
 }
 
+EXPORT_SYMBOL(__udelay);
+
 void __const_udelay(unsigned long usecs)
 {
 	int i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                barrier();
 }
+
+EXPORT_SYMBOL(__const_udelay);
Index: linux-2.6.12-rc/arch/um/sys-x86_64/delay.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-x86_64/delay.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-x86_64/delay.c	2005-05-17 18:11:21.000000000 -0400
@@ -5,40 +5,37 @@
  * Licensed under the GPL
  */
 
-#include "linux/delay.h"
-#include "asm/processor.h"
-#include "asm/param.h"
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <asm/processor.h>
+#include <asm/param.h>
 
 void __delay(unsigned long loops)
 {
 	unsigned long i;
 
-	for(i = 0; i < loops; i++) ;
+        for(i = 0; i < loops; i++)
+                barrier();
 }
 
 void __udelay(unsigned long usecs)
 {
-	int i, n;
+	unsigned long i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                barrier();
 }
 
+EXPORT_SYMBOL(__udelay);
+
 void __const_udelay(unsigned long usecs)
 {
-	int i, n;
+	unsigned long i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                barrier();
 }
 
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
+EXPORT_SYMBOL(__const_udelay);



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
