Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJUV4-0000Ko-8y for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 02:40:06 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BJUV3-0001MZ-LK
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 02:40:05 -0700
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-3) with ESMTP id
	i3U9e1u2008524 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 30 Apr 2004 11:40:02 +0200
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-3) with UUCP id
	i3U9P1tL006970 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 11:25:01 +0200
Received: from bytesex.org (kraxel@localhost [127.0.0.1])
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) with ESMTP id i3U9jvKx019241
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 30 Apr 2004 11:45:57 +0200
Received: (from kraxel@localhost)
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) id i3U9jvl5019240
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 11:45:57 +0200
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040430094557.GA19219@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] ethtool support
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
Date: Fri, 30 Apr 2004 11:45:57 +0200
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

Trivial patch for the uml network driver: basic ethtool support
so it returns name + version on ETHTOOL_GDRVINFO.

  Gerd

--- linux-2.6.5/arch/um/drivers/net_kern.c.ethtool	2004-04-28 15:17:29.125885216 +0200
+++ linux-2.6.5/arch/um/drivers/net_kern.c	2004-04-28 16:59:57.841138416 +0200
@@ -15,6 +15,7 @@
 #include "linux/module.h"
 #include "linux/init.h"
 #include "linux/etherdevice.h"
+#include "linux/ethtool.h"
 #include "linux/list.h"
 #include "linux/inetdevice.h"
 #include "linux/ctype.h"
@@ -242,7 +243,30 @@
 
 static int uml_net_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	return(-EINVAL);
+	static const struct ethtool_drvinfo info = {
+		.cmd     = ETHTOOL_GDRVINFO,
+		.driver  = "uml virtual ethernet",
+		.version = "42",
+	};
+	void *useraddr;
+	u32 ethcmd;
+
+	switch (cmd) {
+        case SIOCETHTOOL:
+		useraddr = ifr->ifr_data;
+		if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
+			return -EFAULT;
+		switch (ethcmd) {
+		case ETHTOOL_GDRVINFO:
+			if (copy_to_user(useraddr, &info, sizeof(info)))
+				return -EFAULT;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EINVAL;
+	}
 }
 
 void uml_net_user_timer_expire(unsigned long _conn)


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
