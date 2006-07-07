Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeHx-0006bR-Cz for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:45 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeHw-0006bC-4n
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:45 -0700
Message-Id: <200607070033.k670Xt1w008752@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 06 Jul 2006 20:33:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 19/19] UML - Make mconsole version requests
	happen in a process
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

Handling a host mconsole version request must be done in a process context
rather than interrupt context now that utsname information can be 
process-specific rather than global.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.16.orig/arch/um/drivers/mconsole_user.c
+++ linux-2.6.16/arch/um/drivers/mconsole_user.c
@@ -18,7 +18,12 @@
 #include "umid.h"
 
 static struct mconsole_command commands[] = {
-	{ "version", mconsole_version, MCONSOLE_INTR },
+	/* With uts namespaces, uts information becomes process-specific, so
+	 * we need a process context.  If we try handling this in interrupt
+	 * context, we may hit an exiting process without a valid uts
+	 * namespace.
+	 */
+	{ "version", mconsole_version, MCONSOLE_PROC },
 	{ "halt", mconsole_halt, MCONSOLE_PROC },
 	{ "reboot", mconsole_reboot, MCONSOLE_PROC },
 	{ "config", mconsole_config, MCONSOLE_PROC },


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
