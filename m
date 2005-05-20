Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DZ8gs-0004sy-Hw	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 May 2005 07:41:30 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DZ8gq-0004MX-Ue	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 May 2005 07:41:30 -0700
Message-Id: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Wed, 18 May 2005 14:18:00 PDT."
             <20050518141800.299476d9.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [PATCH 4/9] UML - Delay loop cleanups
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
Date: Fri, 20 May 2005 10:35:57 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Arjan van de Ven <arjan@infradead.org>

akpm@osdl.org said:
> I'll drop this in light of the review comments - pls redo&&resend 

Here 'tis.

This patch cleans up the delay implementations a bit, makes the loops
unoptimizable, and exports __udelay and __const_udelay.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/sys-i386/delay.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/delay.c	2005-05-19 13:18:50.000000000 -0400
+++ linux-2.6.11/arch/um/sys-i386/delay.c	2005-05-19 13:19:40.000000000 -0400
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
+                cpu_relax();
 }
 
+EXPORT_SYMBOL(__udelay);
+
 void __const_udelay(unsigned long usecs)
 {
 	int i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                cpu_relax();
 }
+
+EXPORT_SYMBOL(__const_udelay);
Index: linux-2.6.11/arch/um/sys-x86_64/delay.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-x86_64/delay.c	2005-05-19 13:18:50.000000000 -0400
+++ linux-2.6.11/arch/um/sys-x86_64/delay.c	2005-05-19 13:19:40.000000000 -0400
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
+                cpu_relax();
 }
 
 void __udelay(unsigned long usecs)
 {
-	int i, n;
+	unsigned long i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
+        for(i=0;i<n;i++)
+                cpu_relax();
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
+                cpu_relax();
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
