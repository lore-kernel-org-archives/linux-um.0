Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGhql-0003bR-OD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 14:04:51 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGhqi-0000cN-Sz
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 14:04:51 -0700
Date: Thu, 2 Aug 2007 17:04:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070802210437.GA11189@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/6] UML - Fix nonremovability of watchdog
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "Robert P. J. Day" <rpjday@mindspring.com>

The UML watchdog driver was using the wrong config variable to control
whether it can be unloaded once active.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/harddog_kern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.21-mm/arch/um/drivers/harddog_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/harddog_kern.c	2007-08-02 16:43:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/harddog_kern.c	2007-08-02 16:43:24.000000000 -0400
@@ -69,7 +69,7 @@ static int harddog_open(struct inode *in
 	spin_lock(&lock);
 	if(timer_alive)
 		goto err;
-#ifdef CONFIG_HARDDOG_NOWAYOUT
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
 	__module_get(THIS_MODULE);
 #endif
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
