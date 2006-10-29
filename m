Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeFdM-0001Ql-TF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 10:43:48 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeFdK-0004zq-2o
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 10:43:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 19:43:39 +0100
References: <17728.49750.141048.595960@palau.inf.ed.ac.uk>
In-Reply-To: <17728.49750.141048.595960@palau.inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bZPRFT+vo1C2y7+"
Message-Id: <200610291943.39433.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] broken mdelay
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: Julian Bradfield <jcb+uml@inf.ed.ac.uk>

--Boundary-00=_bZPRFT+vo1C2y7+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 26 October 2006 16:12, Julian Bradfield wrote:
> A few years ago, I reported a problem with mdelay (that it basically
> didn't work) - see
>
> http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=103774842828993&w=2
>
> and preceding messages.
>
> I see the problem is still there in 2.6.18 (I find it because I insert an
> mdelay(1000) into one of the ubd routines to simulate the effect of
> busy-waiting on i/o in one of my practical exercises).
>
> Here's the patch I currently use to fix it. I can't remember now how I
> produced this patch four years ago, but it should make sense in
> conjunction with the above referenced message.

I've not yet looked at that messages, however:

Direct invocations of __const_udelay (see include/asm-i386/delay.h) are still 
broken with the below patch IMHO, since you do not multiply the value passed 
there by that magic constant - look also at arch/i386/lib/delay.c. Please try 
if the attached patch works for you. Also, a number of other users complained 
about the same bug (hangs on shutdown result for device-mapper users in some 
particular conditions, for instance).

> --- arch/um/sys-i386/delay.c.dist	2006-10-26 14:50:38.069023000 +0100
> +++ arch/um/sys-i386/delay.c	2006-10-26 14:50:42.527846000 +0100
> @@ -3,7 +3,7 @@
>  #include <linux/delay.h>
>  #include <asm/param.h>
>
> -void __delay(unsigned long time)
> +static void __loop_delay(unsigned long loops)
>  {
>  	/* Stolen from the i386 __loop_delay */
>  	int d0;
> @@ -14,27 +14,28 @@
>  		".align 16\n"
>  		"2:\tdecl %0\n\tjns 2b"
>
>  		:"=&a" (d0)
>
> -		:"0" (time));
> +		:"0" (loops));
>  }
>
> -void __udelay(unsigned long usecs)
> +void __delay(unsigned long loops)
>  {
> -	int i, n;
> -
> -	n = (loops_per_jiffy * HZ * usecs) / MILLION;
> -        for(i=0;i<n;i++)
> -                cpu_relax();
> +	__loop_delay(loops);
>  }
>
> -EXPORT_SYMBOL(__udelay);
> -
> -void __const_udelay(unsigned long usecs)
> +inline void __const_udelay(unsigned long xloops)
>  {
> -	int i, n;
> +	int d0;
> +	__asm__("mull %0"
> +		:"=d" (xloops), "=&a" (d0)
> +		:"1" (xloops),"0" (loops_per_jiffy));
> +        __delay(xloops * HZ);
> +}
>
> -	n = (loops_per_jiffy * HZ * usecs) / MILLION;
> -        for(i=0;i<n;i++)
> -                cpu_relax();
> +void __udelay(unsigned long usecs)
> +{
> +	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
>  }
>
> +EXPORT_SYMBOL(__udelay);
> +
>  EXPORT_SYMBOL(__const_udelay);

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_bZPRFT+vo1C2y7+
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-udelay.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-udelay.diff"

Index: linux-2.6.git/arch/um/sys-i386/delay.c
===================================================================
--- linux-2.6.git.orig/arch/um/sys-i386/delay.c
+++ linux-2.6.git/arch/um/sys-i386/delay.c
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
Index: linux-2.6.git/arch/um/sys-x86_64/delay.c
===================================================================
--- linux-2.6.git.orig/arch/um/sys-x86_64/delay.c
+++ linux-2.6.git/arch/um/sys-x86_64/delay.c
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
Index: linux-2.6.git/include/asm-um/delay.h
===================================================================
--- linux-2.6.git.orig/include/asm-um/delay.h
+++ linux-2.6.git/include/asm-um/delay.h
@@ -1,9 +1,20 @@
 #ifndef __UM_DELAY_H
 #define __UM_DELAY_H
 
-#include "asm/arch/delay.h"
-#include "asm/archparam.h"
-
 #define MILLION 1000000
 
+/* Undefined on purpose */
+extern void __bad_udelay(void);
+extern void __bad_ndelay(void);
+
+extern void __udelay(unsigned long usecs);
+extern void __const_udelay(unsigned long usecs);
+extern void __delay(unsigned long loops);
+
+#define udelay(n) ((__builtin_constant_p(n) && (n) > 20000) ? \
+	__bad_udelay() : __udelay(n))
+
+/* It appears that ndelay is not used at all for UML. */
+#define ndelay(n) __bad_ndelay()
+
 #endif

--Boundary-00=_bZPRFT+vo1C2y7+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_bZPRFT+vo1C2y7+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_bZPRFT+vo1C2y7+--
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

