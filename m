Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1WjZ-0004Qq-PJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jan 2006 14:33:53 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F1WjY-0004Fr-Ce
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jan 2006 14:33:53 -0800
Message-Id: <200601242326.k0ONQ2JM008908@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/2] UML - Fix some typos
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
Date: Tue, 24 Jan 2006 18:26:02 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Fix a couple of typos.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/drivers/mcast_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/drivers/mcast_kern.c	2006-01-24 17:04:22.000000000 -0500
+++ linux-2.6.15-mm/arch/um/drivers/mcast_kern.c	2006-01-24 17:05:38.000000000 -0500
@@ -40,7 +40,7 @@ static void mcast_init(struct net_device
 	dpri->dev = dev;
 
 	printk("mcast backend ");
-	printk("multicast adddress: %s:%u, TTL:%u ",
+	printk("multicast address: %s:%u, TTL:%u ",
 	       dpri->addr, dpri->port, dpri->ttl);
 
 	printk("\n");
Index: linux-2.6.15-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/drivers/mconsole_kern.c	2006-01-24 17:04:31.000000000 -0500
+++ linux-2.6.15-mm/arch/um/drivers/mconsole_kern.c	2006-01-24 17:05:38.000000000 -0500
@@ -273,7 +273,7 @@ void mconsole_proc(struct mc_request *re
     config <dev> - Query the configuration of a device \n\
     remove <dev> - Remove a device from UML \n\
     sysrq <letter> - Performs the SysRq action controlled by the letter \n\
-    cad - invoke the Ctl-Alt-Del handler \n\
+    cad - invoke the Ctrl-Alt-Del handler \n\
     stop - pause the UML; it will do nothing until it receives a 'go' \n\
     go - continue the UML after a 'stop' \n\
     log <string> - make UML enter <string> into the kernel log\n\



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
