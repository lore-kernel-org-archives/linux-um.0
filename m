Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GA8hr-0002ta-T7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Aug 2006 10:16:00 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GA8hq-0003AC-1K
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Aug 2006 10:15:59 -0700
Message-Id: <200608071715.k77HFkX1004664@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 07 Aug 2006 13:15:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] UML - Fix botched signal handling patch
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

I botched a previous patch which changed how UML handles signals.  I
left out a bit which sets the signal handler to be one provided by the
architecture.

This patch sets the handler correctly.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/signal.c	2006-08-07 10:05:32.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/signal.c	2006-08-07 10:15:38.000000000 -0400
@@ -118,7 +118,8 @@ void set_handler(int sig, void (*handler
 	sigset_t sig_mask;
 	int mask;
 
-	action.sa_handler = handler;
+	handlers[sig] = (void (*)(int, struct sigcontext *)) handler;
+	action.sa_handler = hard_handler;
 
 	sigemptyset(&action.sa_mask);
 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
