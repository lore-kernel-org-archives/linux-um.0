Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbQxT-0005Cs-M0	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 15:36:07 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DbQxR-0007ku-Vh	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 15:36:07 -0700
Message-Id: <200505262230.j4QMUQ5m014682@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/7] UML - Turn off kmalloc always on a fatal
	signal
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
Date: Thu, 26 May 2005 18:30:26 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

We should turn off kmalloc when getting a fatal signal regardless of the
mode we're in.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/main.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/main.c	2005-05-26 16:51:14.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/main.c	2005-05-26 17:05:40.000000000 -0400
@@ -71,7 +71,7 @@ static __init void do_uml_initcalls(void
 
 static void last_ditch_exit(int sig)
 {
-	CHOOSE_MODE(kmalloc_ok = 0, (void) 0);
+        kmalloc_ok = 0;
 	signal(SIGINT, SIG_DFL);
 	signal(SIGTERM, SIG_DFL);
 	signal(SIGHUP, SIG_DFL);



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
