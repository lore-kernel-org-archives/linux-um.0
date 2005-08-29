Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9q0o-0001bF-Ma	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:46 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9q0m-0002y6-6v
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:46 -0700
Message-Id: <200508292007.j7TK7Ags029938@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/9] UML - UML/i386 is i386 when running on x86_64
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
Date: Mon, 29 Aug 2005 16:07:10 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

From Paolo Giarrusso - Make a UML/i386 instance running on x86_64 pretend
to be i386 rather than x86_64.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc6/arch/um/kernel/user_util.c
===================================================================
--- linux-2.6.12-rc6.orig/arch/um/kernel/user_util.c	2005-08-08 12:32:06.000000000 -0400
+++ linux-2.6.12-rc6/arch/um/kernel/user_util.c	2005-08-12 14:00:34.000000000 -0400
@@ -132,7 +132,12 @@
 	struct utsname host;
 
 	uname(&host);
-	strcpy(machine_out, host.machine);
+	/* XXX: crude detection of 32-bit binary. */
+	if (sizeof(long) == 4 && !strcmp(host.machine, "x86_64")) {
+		strcpy(machine_out, "i686");
+	} else {
+		strcpy(machine_out, host.machine);
+	}
 }
 
 char host_info[(_UTSNAME_LENGTH + 1) * 4 + _UTSNAME_NODENAME_LENGTH + 1];



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
