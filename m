Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gd5ya-0001G9-2U for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Oct 2006 07:12:56 -0700
Received: from nutty.inf.ed.ac.uk ([129.215.216.3])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gd5yV-0006BO-Bo
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Oct 2006 07:12:56 -0700
MIME-Version: 1.0
Message-ID: <17728.49750.141048.595960@palau.inf.ed.ac.uk>
Date: Thu, 26 Oct 2006 15:12:38 +0100
From: Julian Bradfield <jcb+uml@inf.ed.ac.uk>
Subject: [uml-devel] broken mdelay
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
To: user-mode-linux-devel@lists.sourceforge.net

A few years ago, I reported a problem with mdelay (that it basically
didn't work) - see

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=103774842828993&w=2

and preceding messages.

I see the problem is still there in 2.6.18 (I find it because I insert an
mdelay(1000) into one of the ubd routines to simulate the effect of
busy-waiting on i/o in one of my practical exercises).

Here's the patch I currently use to fix it. I can't remember now how I
produced this patch four years ago, but it should make sense in
conjunction with the above referenced message.

--- arch/um/sys-i386/delay.c.dist	2006-10-26 14:50:38.069023000 +0100
+++ arch/um/sys-i386/delay.c	2006-10-26 14:50:42.527846000 +0100
@@ -3,7 +3,7 @@
 #include <linux/delay.h>
 #include <asm/param.h>
 
-void __delay(unsigned long time)
+static void __loop_delay(unsigned long loops)
 {
 	/* Stolen from the i386 __loop_delay */
 	int d0;
@@ -14,27 +14,28 @@
 		".align 16\n"
 		"2:\tdecl %0\n\tjns 2b"
 		:"=&a" (d0)
-		:"0" (time));
+		:"0" (loops));
 }
 
-void __udelay(unsigned long usecs)
+void __delay(unsigned long loops)
 {
-	int i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
+	__loop_delay(loops);
 }
 
-EXPORT_SYMBOL(__udelay);
-
-void __const_udelay(unsigned long usecs)
+inline void __const_udelay(unsigned long xloops)
 {
-	int i, n;
+	int d0;
+	__asm__("mull %0"
+		:"=d" (xloops), "=&a" (d0)
+		:"1" (xloops),"0" (loops_per_jiffy));
+        __delay(xloops * HZ);
+}
 
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
+void __udelay(unsigned long usecs)
+{
+	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
 }
 
+EXPORT_SYMBOL(__udelay);
+
 EXPORT_SYMBOL(__const_udelay);

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
