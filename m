Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InJjE-0005YF-Ix for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 12:59:52 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1InJjB-00058N-Sd
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 12:59:52 -0700
Date: Wed, 31 Oct 2007 15:59:39 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071031195939.GA9640@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/4] UML - Fix build for !CONFIG_TCP
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Magotari <magotari@gmail.com>

Make UML build in the absence of CONFIG_INET by making the
inetaddr_notifier registration depend on it.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/net_kern.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

Index: linux-2.6.22/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/net_kern.c	2007-10-12 12:09:00.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/net_kern.c	2007-10-18 23:43:39.000000000 -0400
@@ -753,6 +753,7 @@ static struct mc_device net_mc = {
 	.remove		= net_remove,
 };
 
+#ifdef CONFIG_INET
 static int uml_inetaddr_event(struct notifier_block *this, unsigned long event,
 			      void *ptr)
 {
@@ -789,14 +790,13 @@ struct notifier_block uml_inetaddr_notif
 	.notifier_call		= uml_inetaddr_event,
 };
 
-static int uml_net_init(void)
+static void inet_register(void)
 {
 	struct list_head *ele;
 	struct uml_net_private *lp;
 	struct in_device *ip;
 	struct in_ifaddr *in;
 
-	mconsole_register_dev(&net_mc);
 	register_inetaddr_notifier(&uml_inetaddr_notifier);
 
 	/* Devices may have been opened already, so the uml_inetaddr_notifier
@@ -816,7 +816,17 @@ static int uml_net_init(void)
 		}
 	}
 	spin_unlock(&opened_lock);
+}
+#else
+static inline void inet_register(void)
+{
+}
+#endif
 
+static int uml_net_init(void)
+{
+	mconsole_register_dev(&net_mc);
+	inet_register();
 	return 0;
 }
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
