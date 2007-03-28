Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWhXz-0007p6-VD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 16:27:22 -0700
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HWhXw-0007pl-VD
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 16:27:18 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Thu, 29 Mar 2007 01:26:11 +0200
Message-ID: <20070328232558.28719.96929.stgit@americanbeauty.home.lan>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH][2.6.21] uml: fix unreasonably long udelay
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
To: Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Currently we have a confused udelay implementation.

* __const_udelay does not accept usecs but xloops in i386 and x86_64
* our implementation requires usecs as arg
* it gets a xloops count when called by asm/arch/delay.h

Bugs related to this (extremely long shutdown times) where reported by some
x86_64 users, especially using Device Mapper.

To hit this bug, a compile-time constant time parameter must be passed - that's
why UML seems to work most times.
Fix this with a simple udelay implementation.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-i386/delay.c   |   11 -----------
 arch/um/sys-x86_64/delay.c |   11 -----------
 include/asm-um/delay.h     |   17 ++++++++++++++---
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/um/sys-i386/delay.c b/arch/um/sys-i386/delay.c
index 2c11b97..d623e07 100644
--- a/arch/um/sys-i386/delay.c
+++ b/arch/um/sys-i386/delay.c
@@ -27,14 +27,3 @@ void __udelay(unsigned long usecs)
 }
 
 EXPORT_SYMBOL(__udelay);
-
-void __const_udelay(unsigned long usecs)
-{
-	int i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
-}
-
-EXPORT_SYMBOL(__const_udelay);
diff --git a/arch/um/sys-x86_64/delay.c b/arch/um/sys-x86_64/delay.c
index 137f444..dee5be6 100644
--- a/arch/um/sys-x86_64/delay.c
+++ b/arch/um/sys-x86_64/delay.c
@@ -28,14 +28,3 @@ void __udelay(unsigned long usecs)
 }
 
 EXPORT_SYMBOL(__udelay);
-
-void __const_udelay(unsigned long usecs)
-{
-	unsigned long i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
-}
-
-EXPORT_SYMBOL(__const_udelay);
diff --git a/include/asm-um/delay.h b/include/asm-um/delay.h
index 0985bda..c71e32b 100644
--- a/include/asm-um/delay.h
+++ b/include/asm-um/delay.h
@@ -1,9 +1,20 @@
 #ifndef __UM_DELAY_H
 #define __UM_DELAY_H
 
-#include "asm/arch/delay.h"
-#include "asm/archparam.h"
-
 #define MILLION 1000000
 
+/* Undefined on purpose */
+extern void __bad_udelay(void);
+
+extern void __udelay(unsigned long usecs);
+extern void __delay(unsigned long loops);
+
+#define udelay(n) ((__builtin_constant_p(n) && (n) > 20000) ? \
+	__bad_udelay() : __udelay(n))
+
+/* It appears that ndelay is not used at all for UML, and has never been
+ * implemented. */
+extern void __unimplemented_ndelay(void);
+#define ndelay(n) __unimplemented_ndelay()
+
 #endif




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
