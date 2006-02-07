Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6IV6-0003py-91 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:40 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6IV5-00044x-QU
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:40 -0800
Message-Id: <200602070223.k172Nr2L009659@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/8] UML - Add debug switch for skas mode
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
Date: Mon, 06 Feb 2006 21:23:53 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Pekka J Enberg <penberg@cs.Helsinki.FI>

It doesn't do anything but emit a warning, but there's a user population
that's used to adding 'debug' to the UML command line in order to gdb it.
With skas0 mode, that's not necessary, but these users need some indication
that 'debug' doesn't do what they want.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/um_arch.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/um_arch.c	2006-02-06 17:35:35.000000000 -0500
@@ -193,6 +193,24 @@ __uml_setup("root=", uml_root_setup,
 "        root=/dev/ubd5\n\n"
 );
 
+#ifndef CONFIG_MODE_TT
+
+static int __init no_skas_debug_setup(char *line, int *add)
+{
+	printf("'debug' is not necessary to gdb UML in skas mode - run \n");
+	printf("'gdb linux' and disable CONFIG_CMDLINE_ON_HOST if gdb \n");
+	printf("doesn't work as expected\n");
+
+	return 0;
+}
+
+__uml_setup("debug", no_skas_debug_setup,
+"debug\n"
+"    this flag is not needed to run gdb on UML in skas mode\n\n"
+);
+
+#endif
+
 #ifdef CONFIG_SMP
 static int __init uml_ncpus_setup(char *line, int *add)
 {



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
