Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWtEH-00082i-ID
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 00:09:53 -0800
Received: from [216.156.129.65] (helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AWtEH-0001F8-6m
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 00:09:53 -0800
Received: from hawk (mothership.theshore.net [68.52.199.4])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id hBI8D7sH014312
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Dec 2003 03:13:07 -0500
Message-ID: <000901c3c53e$4a759550$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <Pine.LNX.4.58.0312181520100.15701@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [PATCH] - fix for 2.4.22-7um RTC on CPUs faster than 2.1 GHz
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Dec 2003 02:09:39 -0600
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Enabling the RTC in 2.4.22-7um produced a hang very soon after INIT at boot time.

I discovered host_hz as an int overflows past 2.1 Ghz (2147483647 hz).  An
unsigned int/long would only work for up to ~ 4.3 Ghz (4294967295 hz) or so, which
isn't that far off, imo...  So -- Below is a patch that changes the type of
host_hz to unsigned long long.  Also, I believe some casting was taking place with
the return value of get_host_hz, so mhz is also redefined as an unsigned long
long.

-Chris


diff -Naur orig/arch/um/kernel/time.c mine/arch/um/kernel/time.c
--- orig/arch/um/kernel/time.c  2003-12-18 02:30:20.000000000 -0500
+++ mine/arch/um/kernel/time.c  2003-12-18 02:32:38.000000000 -0500
@@ -79,10 +79,11 @@
        set_interval(ITIMER_REAL);
 }

-static long get_host_hz(void)
+static unsigned long long get_host_hz(void)
 {
        char mhzline[16], *end;
-       int ret, mult, mhz, rest, len;
+       int ret, mult, rest, len;
+       unsigned long long mhz;

        ret = cpu_feature("cpu MHz", mhzline,
                          sizeof(mhzline) / sizeof(mhzline[0]));
@@ -112,7 +113,7 @@
        return(1000000 * mhz + rest);
 }

-int host_hz = 0;
+unsigned long long host_hz = 0;

 void time_init(void)
 {
diff -Naur orig/arch/um/kernel/time_kern.c mine/arch/um/kernel/time_kern.c
--- orig/arch/um/kernel/time_kern.c     2003-12-18 02:30:20.000000000 -0500
+++ mine/arch/um/kernel/time_kern.c     2003-12-18 02:34:58.000000000 -0500
@@ -39,7 +39,7 @@
 static unsigned long long prev_tsc;
 static long long delta;                /* Deviation per interval */

-extern int host_hz;
+extern unsigned long long host_hz;

 void timer_irq(union uml_pt_regs *regs)
 {



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
