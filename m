Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <006501c401a3$8442e4d0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <40430B47.3000004@sms.ed.ac.uk>
	<200403022005.42635.blaisorblade_spam@yahoo.it>
	<0d2e01c40174$dfda5b40$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] Hang at ipv4 setup is a cpufreq issue!
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
Date: Wed, 3 Mar 2004 22:45:25 -0600
To: roland <for_spam@gmx.de>
Cc: uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Here is my original post with patch.

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107173525906273&w=2

Some of it is already in the 2.6um tree. Just the very first patch in the patch to
time.c is necessary.  The lines are offset from 2.6 in this 2.4 patch, but it
should apply to 2.6um easy enough...

Relevant section:

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


-Chris



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
